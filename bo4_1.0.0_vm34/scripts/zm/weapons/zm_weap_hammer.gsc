#using scripts\abilities\ability_player;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_lightning_chain;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_net;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;

#namespace zm_weap_hammer;

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 0, eflags: 0x2
// Checksum 0x517a920f, Offset: 0x318
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_hammer", &__init__, undefined, undefined);
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 0, eflags: 0x0
// Checksum 0x351f2f1a, Offset: 0x360
// Size: 0x4c4
function __init__() {
    clientfield::register("allplayers", "lightning_bolt_fx", 1, 1, "counter");
    clientfield::register("toplayer", "hero_hammer_armor_postfx", 1, 1, "counter");
    clientfield::register("scriptmover", "lightning_miss_fx", 1, 1, "int");
    clientfield::register("scriptmover", "hammer_storm", 1, 1, "int");
    clientfield::register("actor", "lightning_impact_fx", 1, 1, "int");
    clientfield::register("vehicle", "lightning_impact_fx", 1, 1, "int");
    clientfield::register("actor", "hero_hammer_melee_impact_trail", 1, 1, "counter");
    clientfield::register("vehicle", "hero_hammer_melee_impact_trail", 1, 1, "counter");
    clientfield::register("actor", "lightning_arc_fx", 1, 1, "int");
    clientfield::register("vehicle", "lightning_arc_fx", 1, 1, "int");
    clientfield::register("actor", "hero_hammer_stun", 1, 1, "int");
    clientfield::register("vehicle", "hero_hammer_stun", 1, 1, "int");
    clientfield::register("toplayer", "hammer_rumble", 1, 1, "counter");
    level.hero_weapon[#"hammer"][0] = getweapon(#"hero_hammer_lv1");
    level.hero_weapon[#"hammer"][1] = getweapon(#"hero_hammer_lv2");
    level.hero_weapon[#"hammer"][2] = getweapon(#"hero_hammer_lv3");
    level.var_7ea45b61 = getweapon(#"hash_76986baf9b6770c6");
    zm_loadout::register_hero_weapon_for_level("hero_hammer_lv1");
    zm_loadout::register_hero_weapon_for_level("hero_hammer_lv2");
    zm_loadout::register_hero_weapon_for_level("hero_hammer_lv3");
    level.var_5fd67c92 = 22500;
    level.var_7e478e1b = 57600;
    level.var_b993b6f5 = 10000;
    level.var_a7e1b133 = new throttle();
    [[ level.var_a7e1b133 ]]->initialize(6, 0.1);
    callback::on_connect(&function_47f7849d);
    callback::on_disconnect(&on_player_disconnect);
    callback::function_5a6e6389(&function_5a6e6389);
    level._effect[#"lightning_eyes"] = #"hash_5aa1120d061d1f6c";
    ability_player::register_gadget_activation_callbacks(11, undefined, &hammer_off);
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 2, eflags: 0x0
// Checksum 0x20ff4c38, Offset: 0x830
// Size: 0xcc
function function_6a20c86d(weapon, var_be5b1c67 = 1) {
    if (weapon == level.hero_weapon[#"hammer"][2]) {
        return true;
    }
    if (weapon == level.hero_weapon[#"hammer"][1] && var_be5b1c67 < 3) {
        return true;
    }
    if (weapon == level.hero_weapon[#"hammer"][0] && var_be5b1c67 < 2) {
        return true;
    }
    return false;
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 0, eflags: 0x4
// Checksum 0x33d2bd19, Offset: 0x908
// Size: 0x2e0
function private function_47f7849d() {
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill(#"weapon_change");
        wpn_cur = waitresult.weapon;
        wpn_prev = waitresult.last_weapon;
        if (wpn_cur == level.hero_weapon[#"hammer"][0]) {
            self thread hammer_rumble(1);
            zm_hero_weapon::show_hint(wpn_cur, #"hash_10c853c67454fff6");
            self thread function_7023a787(wpn_cur);
            self thread activate_armor(wpn_cur);
            continue;
        }
        if (wpn_cur == level.hero_weapon[#"hammer"][1]) {
            self thread hammer_rumble(1);
            zm_hero_weapon::show_hint(wpn_cur, #"hash_2745ea06a4f8e7fd");
            self thread function_610de562(wpn_cur);
            self thread function_7023a787(wpn_cur);
            self thread activate_armor(wpn_cur);
            self thread function_d145c1c1(wpn_cur);
            continue;
        }
        if (wpn_cur == level.hero_weapon[#"hammer"][2]) {
            self thread hammer_rumble(1);
            if (!self gamepadusedlast()) {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_78fab15695ef9758");
            } else {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_7b9c8543bd5b051c");
            }
            self thread function_610de562(wpn_cur);
            self thread function_7023a787(wpn_cur);
            self thread activate_armor(wpn_cur);
            self thread function_a26a7e00(wpn_cur);
            self thread function_28e4f6c8(wpn_cur);
        }
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x0
// Checksum 0xe6fd50ed, Offset: 0xbf0
// Size: 0xd4
function function_b665014e(s_params) {
    if (isplayer(s_params.eattacker) && function_6a20c86d(s_params.weapon, 1)) {
        player = s_params.eattacker;
        var_89961bc5 = 100 - player zm_utility::get_armor(#"hash_1088bacfbba523ff");
        if (var_89961bc5 >= 10) {
            var_e0ea3581 = 10;
        } else {
            var_e0ea3581 = var_89961bc5;
        }
        player set_armor(var_e0ea3581);
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x4
// Checksum 0xe70c0e02, Offset: 0xcd0
// Size: 0x90
function private function_610de562(weapon) {
    self endon(#"weapon_change", #"disconnect", #"bled_out");
    while (true) {
        self waittill(#"weapon_melee_power_left");
        weapon thread function_ddfe8dca(self);
        weapon function_64da8da3(self);
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x4
// Checksum 0xba559aa, Offset: 0xd68
// Size: 0x274
function private function_64da8da3(player) {
    player endon(#"weapon_change", #"disconnect", #"bled_out");
    wait 0.5;
    player playsound(#"hash_334d4a903f12856f");
    v_start = player geteye();
    v_forward = player getweaponforwarddir();
    v_end = v_start + v_forward * 32;
    s_trace = groundtrace(v_start, v_end, 0, player);
    v_start = s_trace[#"position"] + (0, 0, 5);
    v_end = v_start + (0, 0, -200);
    s_trace = groundtrace(v_start, v_end, 0, player);
    n_offset = v_end[2] + 96;
    v_drop = zm_utility::function_eb5eb205(s_trace[#"position"]);
    if (!isdefined(v_drop) || n_offset >= player.origin[2]) {
        /#
        #/
        return;
    }
    while (!isdefined(player.e_storm)) {
        player.e_storm = util::spawn_model("tag_origin", player.origin);
        util::wait_network_frame();
    }
    player.e_storm.origin = v_drop[#"point"] + (0, 0, 20);
    player thread storm_think();
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 0, eflags: 0x0
// Checksum 0xd92bed2c, Offset: 0xfe8
// Size: 0x12c
function storm_think() {
    self endon(#"disconnect");
    self notify(#"storm_think");
    self endon(#"storm_think");
    waitframe(3);
    if (self.e_storm clientfield::get("hammer_storm")) {
        self.e_storm clientfield::set("hammer_storm", 0);
        util::wait_network_frame();
    }
    self.e_storm clientfield::set("hammer_storm", 1);
    self thread function_331b4f29();
    wait 10;
    self.e_storm clientfield::set("hammer_storm", 0);
    util::wait_network_frame();
    self.e_storm delete();
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x4
// Checksum 0xcd4899df, Offset: 0x1120
// Size: 0x78
function private function_7023a787(weapon) {
    self endon(#"weapon_change", #"disconnect", #"bled_out");
    while (true) {
        self waittill(#"weapon_melee_power");
        weapon function_9e22fe2c(self);
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x0
// Checksum 0xc6936b38, Offset: 0x11a0
// Size: 0x74
function function_ddfe8dca(player) {
    player endon(#"weapon_change", #"disconnect");
    waitframe(15);
    player thread hammer_rumble(2);
    player thread function_d7f406a7(1, self);
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x0
// Checksum 0x13668c08, Offset: 0x1220
// Size: 0x74
function function_9e22fe2c(player) {
    player endon(#"weapon_change", #"disconnect");
    waitframe(5);
    player thread function_d7f406a7(2, self);
    waitframe(11);
    player thread function_d7f406a7(3, self);
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x4
// Checksum 0x131b65c6, Offset: 0x12a0
// Size: 0x9c
function private activate_armor(weapon) {
    level callback::on_ai_killed(&function_b665014e);
    self clientfield::increment_to_player("hero_hammer_armor_postfx");
    self thread set_armor(100);
    self waittill(#"weapon_change");
    level callback::remove_on_ai_killed(&function_b665014e);
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x4
// Checksum 0x38ba0376, Offset: 0x1348
// Size: 0x34
function private set_armor(n_armor) {
    self thread zm_utility::add_armor(#"hash_1088bacfbba523ff", n_armor, 100);
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x4
// Checksum 0x74050edd, Offset: 0x1388
// Size: 0x78
function private function_a26a7e00(weapon) {
    self endon(#"weapon_change", #"disconnect", #"bled_out");
    while (true) {
        self waittill(#"weapon_melee");
        self thread lightning_bolt(weapon);
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 5, eflags: 0x0
// Checksum 0xc93272bf, Offset: 0x1408
// Size: 0x31c
function function_c9303e85(e_target, weapon = level.weaponnone, var_3e9ee1aa, v_to_target, n_damage) {
    if (!isalive(e_target)) {
        return;
    }
    self thread hammer_rumble(4);
    if (isactor(e_target)) {
        [[ level.var_a7e1b133 ]]->waitinqueue(e_target);
        switch (e_target.var_29ed62b2) {
        case #"popcorn":
        case #"basic":
            n_damage = e_target.health;
            break;
        case #"heavy":
            n_damage = int(e_target.maxhealth * 0.25);
            break;
        case #"miniboss":
            n_damage = int(e_target.maxhealth * 0.15);
            break;
        }
        e_target.no_gib = 1;
        e_target thread zm_hero_weapon::function_f53ff9();
        e_target dodamage(n_damage, self.origin, self, self, "none", "MOD_MELEE", 0, weapon);
        if (e_target.health <= 0) {
            e_target clientfield::increment("hero_hammer_melee_impact_trail");
            e_target.ignoremelee = 1;
            switch (var_3e9ee1aa) {
            case 1:
                v_fling = (0, 0, -1) * 250;
                break;
            case 2:
            case 3:
                v_fling = v_to_target * 250;
                break;
            }
            e_target zm_utility::function_620780d9(v_fling, self);
            self playrumbleonentity("damage_heavy");
        } else {
            self playrumbleonentity("shotgun_fire");
        }
        return;
    }
    e_target dodamage(n_damage, self.origin, self, self, "none", "MOD_MELEE", 0, weapon);
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 2, eflags: 0x0
// Checksum 0x12a572ae, Offset: 0x1730
// Size: 0x3b6
function function_d7f406a7(var_3e9ee1aa, weapon = level.weaponnone) {
    if (var_3e9ee1aa == 1) {
        n_damage = 5000;
    } else {
        n_damage = 2500;
    }
    view_pos = self geteye();
    forward_view_angles = anglestoforward(self getplayerangles());
    if (forward_view_angles[2] < -0.7) {
        var_907cefce = (forward_view_angles[0], forward_view_angles[1], -0.25);
    } else {
        var_907cefce = forward_view_angles;
    }
    a_e_targets = zm_hero_weapon::function_765137a1();
    foreach (e_target in a_e_targets) {
        if (!isalive(e_target)) {
            continue;
        }
        test_origin = e_target getcentroid();
        dist_sq = distancesquared(view_pos, test_origin);
        if (isdefined(e_target.var_4da97639)) {
            dist_to_check = e_target.var_4da97639;
        } else {
            dist_to_check = level.var_5fd67c92;
        }
        if (dist_sq > dist_to_check) {
            continue;
        }
        v_normal = vectornormalize(test_origin - self.origin);
        dot = vectordot(var_907cefce, v_normal);
        if (dot <= 0 && dist_sq > 1600) {
            continue;
        }
        if (0 == e_target damageconetrace(view_pos, self, forward_view_angles)) {
            continue;
        }
        n_random_x = randomfloatrange(-3, 3);
        n_random_y = randomfloatrange(-3, 3);
        var_eb157df6 = randomfloatrange(5, 20);
        v_ragdoll = vectornormalize(e_target.origin - self.origin + (n_random_x, n_random_y, var_eb157df6));
        if (isdefined(e_target.var_caa5a7cb)) {
            self thread [[ e_target.var_caa5a7cb ]](e_target, weapon, var_3e9ee1aa, v_ragdoll);
        } else {
            self thread function_c9303e85(e_target, weapon, var_3e9ee1aa, v_ragdoll, n_damage);
        }
        waitframe(1);
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x0
// Checksum 0x2215a648, Offset: 0x1af0
// Size: 0x45c
function lightning_bolt(weapon) {
    self endon(#"disconnect");
    self playsound("wpn_hammer_bolt_fire");
    self thread hammer_rumble(3);
    waitframe(9);
    var_1319fcbb = vectortoangles(self getweaponforwarddir());
    var_e1b84d95 = self getweaponmuzzlepoint();
    level notify(#"lightning_ball_created");
    if (!isdefined(var_1319fcbb)) {
        var_1319fcbb = (0, 0, 0);
    }
    e_ball_fx = spawn("script_model", var_e1b84d95 + anglestoforward(var_1319fcbb) * 100);
    e_ball_fx.angles = var_1319fcbb;
    e_ball_fx.str_weapon = weapon;
    e_ball_fx setmodel(#"tag_origin");
    e_ball_fx.n_range = 250;
    e_ball_fx.n_damage_per_sec = 1000;
    e_ball_fx clientfield::set("lightning_miss_fx", 1);
    e_ball_fx playloopsound(#"hash_15299b453cf5dd24", 0.5);
    var_b6f44f8a = 600;
    v_end = var_e1b84d95 + anglestoforward(var_1319fcbb) * var_b6f44f8a;
    trace = bullettrace(var_e1b84d95, v_end, 0, self);
    if (trace[#"fraction"] != 1) {
        v_end = trace[#"position"];
    }
    if (isdefined(trace[#"entity"]) && function_a5354464(trace[#"entity"])) {
        self thread function_2f8a6614(trace[#"entity"]);
    }
    if (isdefined(level.var_d9e9a35f)) {
        self thread function_d3264932();
    }
    staff_lightning_ball_speed = var_b6f44f8a / 8 * 5;
    n_dist = distance(e_ball_fx.origin, v_end);
    n_max_movetime_s = var_b6f44f8a / staff_lightning_ball_speed;
    n_movetime_s = n_dist / staff_lightning_ball_speed;
    n_leftover_time = n_max_movetime_s - n_movetime_s;
    e_ball_fx thread staff_lightning_ball_kill_zombies(self);
    e_ball_fx moveto(v_end, n_movetime_s);
    finished_playing = e_ball_fx lightning_ball_wait(n_leftover_time);
    e_ball_fx stoploopsound(0.25);
    e_ball_fx playsound(#"hash_3f29c3ebe4a7417a");
    e_ball_fx notify(#"stop_killing");
    e_ball_fx notify(#"stop_debug_position");
    if (isdefined(e_ball_fx)) {
        e_ball_fx delete();
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 0, eflags: 0x0
// Checksum 0xf728beec, Offset: 0x1f58
// Size: 0x110
function function_d3264932() {
    var_7dda366c = self getweaponmuzzlepoint();
    v_forward = self getweaponforwarddir();
    v_end = var_7dda366c + v_forward * 10000;
    a_trace = bullettrace(var_7dda366c, v_end, 0, self);
    level notify(#"hero_weapon_hit", {#player:self, #e_entity:a_trace[#"entity"], #var_3657beb7:self.currentweapon, #v_position:a_trace[#"position"]});
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 0, eflags: 0x0
// Checksum 0x7c2ff1b5, Offset: 0x2070
// Size: 0xc0
function function_331b4f29() {
    self endon(#"disconnect", #"bled_out", #"death", #"storm_think");
    self.e_storm endon(#"death");
    while (true) {
        a_zombies = getaiteamarray(level.zombie_team);
        array::thread_all(a_zombies, &storm_check, self);
        wait 0.05;
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x0
// Checksum 0xc41d0b35, Offset: 0x2138
// Size: 0x1e2
function storm_check(player) {
    player endon(#"disconnect", #"bled_out", #"death", #"storm_think");
    player.e_storm endon(#"death");
    assert(isdefined(player));
    var_37c2950f = 10000;
    var_f4766248 = player.e_storm.origin;
    if (!isalive(self) || isdefined(self.takedamage) && !self.takedamage) {
        return;
    }
    if (self check_for_range(var_f4766248, 96, var_37c2950f)) {
        self.var_e281b956 = 1;
        if (isalive(self)) {
            switch (self.var_29ed62b2) {
            case #"heavy":
            case #"miniboss":
            case #"basic":
                self thread function_41ecbdf9();
                break;
            case #"popcorn":
                self.var_e1594fd6 = 1;
                self dodamage(self.health + 100, var_f4766248, player, player);
                break;
            }
        }
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 0, eflags: 0x0
// Checksum 0x48b32fbe, Offset: 0x2328
// Size: 0x12e
function function_41ecbdf9() {
    self endon(#"death");
    self notify(#"hash_61a6572fbb6d74ab");
    self endon(#"hash_61a6572fbb6d74ab");
    if (isdefined(self.aat_turned) && self.aat_turned) {
        return;
    }
    self ai::stun();
    self.var_4920f478 = 1;
    if (!self clientfield::get("hero_hammer_stun")) {
        self clientfield::set("hero_hammer_stun", 1);
        if (self.archetype == "zombie") {
            bhtnactionstartevent(self, "electrocute");
        }
    }
    wait 0.2;
    self ai::clear_stun();
    self clientfield::set("hero_hammer_stun", 0);
    self.var_4920f478 = 0;
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 3, eflags: 0x0
// Checksum 0x4e8de4ba, Offset: 0x2460
// Size: 0xa2
function check_for_range(v_attack_source, n_allowed_z_diff, n_radius_sq) {
    if (isalive(self)) {
        n_z_diff = self.origin[2] - v_attack_source[2];
        if (abs(n_z_diff) < n_allowed_z_diff) {
            if (distance2dsquared(self.origin, v_attack_source) < n_radius_sq) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 0, eflags: 0x0
// Checksum 0xe6ae1e3d, Offset: 0x2510
// Size: 0x44
function function_5a6e6389() {
    if (isdefined(self.var_e281b956) && self.var_e281b956) {
        self.var_e281b956 = 0;
        self clientfield::set("lc_fx", 0);
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x0
// Checksum 0x9a6d4eb7, Offset: 0x2560
// Size: 0x44
function function_2f8a6614(var_25e38789) {
    var_25e38789 endon(#"death");
    var_25e38789 dodamage(1000, self.origin, self, self);
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x0
// Checksum 0x66099b7f, Offset: 0x25b0
// Size: 0x10c
function staff_lightning_ball_kill_zombies(e_attacker) {
    self endon(#"death", #"stop_killing");
    while (true) {
        a_zombies = staff_lightning_get_valid_targets(e_attacker, self.origin);
        if (isdefined(a_zombies)) {
            foreach (zombie in a_zombies) {
                if (staff_lightning_is_target_valid(zombie)) {
                    e_attacker thread staff_lightning_arc_fx(self, zombie);
                    wait 0.05;
                }
            }
        }
        wait 0.05;
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 2, eflags: 0x0
// Checksum 0x2c5f49c2, Offset: 0x26c8
// Size: 0x118
function staff_lightning_get_valid_targets(player, v_source) {
    player endon(#"disconnect");
    a_enemies = [];
    a_zombies = getaiteamarray(level.zombie_team);
    a_zombies = util::get_array_of_closest(v_source, a_zombies, undefined, undefined, self.n_range);
    if (isdefined(a_zombies)) {
        foreach (ai_zombie in a_zombies) {
            if (staff_lightning_is_target_valid(ai_zombie)) {
                a_enemies[a_enemies.size] = ai_zombie;
            }
        }
    }
    return a_enemies;
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 2, eflags: 0x0
// Checksum 0xc09ec3bb, Offset: 0x27e8
// Size: 0xbc
function staff_lightning_arc_fx(e_source, ai_zombie) {
    self endon(#"disconnect");
    if (!isdefined(ai_zombie)) {
        return;
    }
    if (!bullet_trace_throttled(e_source.origin, ai_zombie.origin + (0, 0, 20), ai_zombie)) {
        return;
    }
    if (isdefined(e_source) && isdefined(ai_zombie) && isalive(ai_zombie)) {
        level thread staff_lightning_ball_damage_over_time(e_source, ai_zombie, self);
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 3, eflags: 0x0
// Checksum 0xa8c6827f, Offset: 0x28b0
// Size: 0x2f4
function staff_lightning_ball_damage_over_time(e_source, e_target, e_attacker) {
    e_attacker endon(#"disconnect");
    if (!isalive(e_target) || isdefined(e_target.takedamage) && !e_target.takedamage) {
        return;
    }
    e_target clientfield::set("lightning_impact_fx", 1);
    if (e_target.archetype == "zombie") {
        bhtnactionstartevent(e_target, "electrocute");
    }
    n_range_sq = e_source.n_range * e_source.n_range;
    e_target.is_being_zapped = 1;
    e_target clientfield::set("lightning_arc_fx", 1);
    if (isdefined(e_source)) {
        if (!isdefined(e_source.n_damage_per_sec)) {
            e_source.n_damage_per_sec = 1000;
        }
        n_damage_per_pulse = e_source.n_damage_per_sec * 0.25;
    }
    while (isdefined(e_source) && isalive(e_target)) {
        e_target thread stun_zombie();
        w_attack = e_source.str_weapon;
        wait 0.25;
        if (!isalive(e_target)) {
            break;
        }
        if (isalive(e_target) && isdefined(e_source)) {
            switch (e_target.var_29ed62b2) {
            case #"basic":
                if (e_target.archetype != "tiger") {
                    e_target thread zombie_shock_eyes();
                }
                e_target thread function_39693792(e_attacker, w_attack);
                break;
            default:
                e_target function_2f31684b(e_attacker, n_damage_per_pulse, w_attack, "MOD_ELECTROCUTED");
                break;
            }
        }
    }
    if (isdefined(e_target)) {
        e_target.is_being_zapped = 0;
        e_target clientfield::set("lightning_arc_fx", 0);
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 3, eflags: 0x0
// Checksum 0x88a8ee2b, Offset: 0x2bb0
// Size: 0xa2
function bullet_trace_throttled(v_start, v_end, e_ignore) {
    if (!isdefined(level.bullet_traces_this_frame)) {
        level thread _throttle_bullet_trace_think();
    }
    while (level.bullet_traces_this_frame >= 2) {
        util::wait_network_frame();
    }
    level.bullet_traces_this_frame++;
    return bullettracepassed(v_start, v_end, 0, e_ignore);
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 0, eflags: 0x0
// Checksum 0xbfb168d8, Offset: 0x2c60
// Size: 0x2c
function _throttle_bullet_trace_think() {
    do {
        level.bullet_traces_this_frame = 0;
        util::wait_network_frame();
    } while (true);
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 4, eflags: 0x0
// Checksum 0x3d9953ce, Offset: 0x2c98
// Size: 0x124
function function_2f31684b(e_attacker, n_amount, w_damage, str_mod) {
    if (isstring(w_damage)) {
        w_damage = getweapon(w_damage);
        return;
    }
    if (n_amount < self.health) {
        self.var_c5a77b9b = str_mod;
        zm_net::network_safe_init("dodamage", 6);
        self zm_net::network_choke_action("dodamage", &function_ad22cd8f, e_attacker, w_damage, n_amount);
        return;
    }
    self.var_c5a77b9b = str_mod;
    self.staff_dmg = w_damage;
    self dodamage(self.health, self.origin, e_attacker, e_attacker, "none", self.var_c5a77b9b, 0, w_damage);
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x0
// Checksum 0x1f451d53, Offset: 0x2dc8
// Size: 0x44
function lightning_ball_wait(n_lifetime_after_move) {
    level endon(#"lightning_ball_created");
    self waittill(#"movedone");
    wait n_lifetime_after_move;
    return true;
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x0
// Checksum 0xbc065d9c, Offset: 0x2e18
// Size: 0xa6
function staff_lightning_is_target_valid(ai_zombie) {
    if (!isdefined(ai_zombie)) {
        return false;
    }
    if (isdefined(ai_zombie.is_being_zapped) && ai_zombie.is_being_zapped) {
        return false;
    }
    if (isdefined(ai_zombie.is_mechz) && ai_zombie.is_mechz) {
        return false;
    }
    if (isvehicle(ai_zombie) && isdefined(ai_zombie.takedamage) && !ai_zombie.takedamage) {
        return false;
    }
    return true;
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 0, eflags: 0x0
// Checksum 0x5b1e5b8, Offset: 0x2ec8
// Size: 0x7c
function stun_zombie() {
    self endon(#"death");
    if (isdefined(self.is_mechz) && self.is_mechz) {
        return;
    }
    if (isdefined(self.is_electrocuted) && self.is_electrocuted) {
        return;
    }
    if (!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
        return;
    }
    self ai::stun();
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 3, eflags: 0x0
// Checksum 0x12192932, Offset: 0x2f50
// Size: 0x8c
function zombie_shock_eyes_network_safe(fx, entity, tag) {
    if (zm_net::network_entity_valid(entity)) {
        if (!(isdefined(self.head_gibbed) && self.head_gibbed) && !gibserverutils::isgibbed(self, 8)) {
            playfxontag(fx, entity, tag);
        }
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 0, eflags: 0x0
// Checksum 0xebf42446, Offset: 0x2fe8
// Size: 0xf4
function zombie_shock_eyes() {
    if (isdefined(self.head_gibbed) && self.head_gibbed || gibserverutils::isgibbed(self, 8)) {
        return;
    }
    if (isdefined(self.is_mechz) && self.is_mechz || isvehicle(self)) {
        return;
    }
    if (isdefined(self gettagorigin("j_eyeball_le"))) {
        zm_net::network_safe_init("shock_eyes", 2);
        zm_net::network_choke_action("shock_eyes", &zombie_shock_eyes_network_safe, level._effect[#"lightning_eyes"], self, "j_eyeball_le");
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 2, eflags: 0x0
// Checksum 0x8c4382c2, Offset: 0x30e8
// Size: 0x7c
function function_39693792(player, str_weapon) {
    player endon(#"disconnect");
    if (!isalive(self)) {
        return;
    }
    self.var_26747e92 = 1;
    self function_2f31684b(player, self.health, str_weapon, "MOD_RIFLE_BULLET");
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 3, eflags: 0x0
// Checksum 0xebdc3254, Offset: 0x3170
// Size: 0x7c
function function_ad22cd8f(e_attacker, str_weapon, var_c776f4) {
    if (!isdefined(self)) {
        return;
    }
    if (!isalive(self)) {
        return;
    }
    self dodamage(var_c776f4, self.origin, e_attacker, e_attacker, "none", self.var_c5a77b9b, 0, str_weapon);
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 0, eflags: 0x0
// Checksum 0x50e2cfd0, Offset: 0x31f8
// Size: 0x1c
function on_player_disconnect() {
    self function_2df078f1();
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 0, eflags: 0x0
// Checksum 0x12cfe3a8, Offset: 0x3220
// Size: 0x4c
function function_2df078f1() {
    if (isdefined(self.e_storm)) {
        self.e_storm clientfield::set("hammer_storm", 0);
        self.e_storm delete();
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 2, eflags: 0x0
// Checksum 0xc69a0fb7, Offset: 0x3278
// Size: 0x3c
function hammer_off(n_slot, w_hero) {
    self notify(#"storm_think");
    self function_2df078f1();
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x0
// Checksum 0x270330c4, Offset: 0x32c0
// Size: 0x10a
function hammer_rumble(n_index) {
    if (n_index) {
        waitframe(1);
        switch (n_index) {
        case 1:
            self playrumbleonentity("zm_weap_special_activate_rumble");
            break;
        case 2:
            playrumbleonposition("zm_weap_hammer_slam_rumble", self.origin);
            break;
        case 3:
            playrumbleonposition("zm_weap_hammer_storm_rumble", self.origin);
            break;
        case 4:
            self clientfield::increment_to_player("hammer_rumble", 4);
            break;
        }
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x0
// Checksum 0xd407a18, Offset: 0x33d8
// Size: 0xa4
function function_d145c1c1(w_hammer) {
    self endon(#"weapon_change", #"disconnect", #"bled_out");
    s_result = self waittill(#"weapon_melee_power_left");
    if (s_result.weapon == w_hammer) {
        self thread zm_audio::create_and_play_dialog(#"hero_level_2", #"hammer");
    }
}

// Namespace zm_weap_hammer/zm_weap_hammer
// Params 1, eflags: 0x0
// Checksum 0xc72a3e45, Offset: 0x3488
// Size: 0xa4
function function_28e4f6c8(w_hammer) {
    self endon(#"weapon_change", #"disconnect", #"bled_out");
    s_result = self waittill(#"weapon_melee");
    if (s_result.weapon === w_hammer) {
        self thread zm_audio::create_and_play_dialog(#"hero_level_3", #"hammer");
    }
}

