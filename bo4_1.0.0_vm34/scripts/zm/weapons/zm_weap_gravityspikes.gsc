#using scripts\abilities\ability_player;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai\zombie_vortex;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\zm_lightning_chain;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_utility;

#namespace zm_weap_gravityspikes;

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 0, eflags: 0x2
// Checksum 0xc52f84b8, Offset: 0x3a8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_gravityspikes", &__init__, undefined, undefined);
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 0, eflags: 0x0
// Checksum 0xb012cdfd, Offset: 0x3f0
// Size: 0x2c4
function __init__() {
    level.hero_weapon[#"gravityspikes"][0] = getweapon(#"hero_gravityspikes_t8_lv1");
    level.hero_weapon[#"gravityspikes"][1] = getweapon(#"hero_gravityspikes_t8_lv2");
    level.hero_weapon[#"gravityspikes"][2] = getweapon(#"hero_gravityspikes_t8_lv3");
    zm_loadout::register_hero_weapon_for_level(#"hero_gravityspikes_t8_lv1");
    zm_loadout::register_hero_weapon_for_level(#"hero_gravityspikes_t8_lv2");
    zm_loadout::register_hero_weapon_for_level(#"hero_gravityspikes_t8_lv3");
    callback::on_connect(&function_e0f331f4);
    callback::on_player_damage(&player_invulnerable_during_gravityspike_slam);
    level.n_zombies_lifted_for_ragdoll = 0;
    level.spikes_chop_cone_range = 120;
    level.spikes_chop_cone_range_sq = level.spikes_chop_cone_range * level.spikes_chop_cone_range;
    level.ai_gravity_throttle = new throttle();
    [[ level.ai_gravity_throttle ]]->initialize(2, 0.1);
    level.var_74214c85 = new throttle();
    [[ level.var_74214c85 ]]->initialize(6, 0.1);
    zm::register_actor_damage_callback(&actor_damage_callback);
    zm_perks::register_lost_perk_override(&function_d9d1bae7);
    callback::on_connect(&function_9567396a);
    callback::on_bleedout(&function_b0e0bcdd);
    callback::on_revived(&function_b0e0bcdd);
    register_clientfields();
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 0, eflags: 0x0
// Checksum 0x25a266a6, Offset: 0x6c0
// Size: 0x2a4
function register_clientfields() {
    clientfield::register("actor", "gravity_slam_down", 1, 1, "int");
    clientfield::register("scriptmover", "gravity_trap_fx", 1, 1, "int");
    clientfield::register("scriptmover", "gravity_trap_spike_spark", 1, 1, "int");
    clientfield::register("scriptmover", "gravity_trap_destroy", 1, 1, "counter");
    clientfield::register("scriptmover", "gravity_trap_location", 1, 1, "int");
    clientfield::register("scriptmover", "gravity_slam_fx", 1, 1, "int");
    clientfield::register("toplayer", "gravity_slam_player_fx", 1, 1, "counter");
    clientfield::register("actor", "sparky_beam_fx", 1, 1, "int");
    clientfield::register("actor", "sparky_zombie_fx", 1, 1, "int");
    clientfield::register("actor", "sparky_zombie_trail_fx", 1, 1, "int");
    clientfield::register("actor", "ragdoll_impact_watch", 1, 1, "int");
    clientfield::register("allplayers", "gravity_shock_wave_fx", 1, 1, "int");
    clientfield::register("toplayer", "hero_gravityspikes_vigor_postfx", 1, 1, "counter");
    clientfield::register("actor", "gravity_aoe_impact_fx", 1, 1, "int");
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 2, eflags: 0x0
// Checksum 0xe465a8be, Offset: 0x970
// Size: 0xcc
function function_c822562(weapon, var_be5b1c67 = 1) {
    if (weapon == level.hero_weapon[#"gravityspikes"][2]) {
        return true;
    }
    if (weapon == level.hero_weapon[#"gravityspikes"][1] && var_be5b1c67 < 3) {
        return true;
    }
    if (weapon == level.hero_weapon[#"gravityspikes"][0] && var_be5b1c67 < 2) {
        return true;
    }
    return false;
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 0, eflags: 0x0
// Checksum 0xd3b27591, Offset: 0xa48
// Size: 0x3a8
function function_e0f331f4() {
    self endon(#"disconnect");
    self thread function_cb4d4500();
    while (true) {
        waitresult = self waittill(#"weapon_change");
        wpn_cur = waitresult.weapon;
        wpn_prev = waitresult.last_weapon;
        if (isinarray(level.hero_weapon[#"gravityspikes"], wpn_cur)) {
            self clientfield::increment_to_player("hero_gravityspikes_vigor_postfx");
            self update_gravityspikes_state(1);
            self thread function_6ae464c3();
            self.b_gravity_trap_fx_on = 0;
            self.var_c90b5ea6 = undefined;
            self thread gravityspikes_attack_watcher(wpn_cur);
        } else if (isinarray(level.hero_weapon[#"gravityspikes"], wpn_prev)) {
            self thread function_e83656ca(wpn_prev);
        }
        if (wpn_cur == level.hero_weapon[#"gravityspikes"][0]) {
            zm_hero_weapon::show_hint(wpn_cur, #"hash_2ed06d351658eadf");
            self thread function_a22e9cb(wpn_cur);
            continue;
        }
        if (wpn_cur == level.hero_weapon[#"gravityspikes"][1]) {
            if (!self gamepadusedlast()) {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_6b4f0b375a21c020");
            } else {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_1014fb82e4e32c24");
            }
            self thread gravityspikes_stuck_above_zombie_watcher();
            self thread function_a22e9cb(wpn_cur);
            self thread gravityspikes_altfire_watcher(wpn_cur);
            self thread function_d145c1c1(wpn_cur);
            continue;
        }
        if (wpn_cur == level.hero_weapon[#"gravityspikes"][2]) {
            if (!self gamepadusedlast()) {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_22403f43ff20f2db");
            } else {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_3b5dc0adfa400025");
            }
            self thread gravityspikes_stuck_above_zombie_watcher();
            self thread gravityspikes_altfire_watcher(wpn_cur);
            self thread function_8f7a5b57(wpn_cur);
        }
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 0, eflags: 0x4
// Checksum 0xe30abadd, Offset: 0xdf8
// Size: 0x90
function private function_cb4d4500() {
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill(#"hero_weapon_give");
        var_1cf82592 = waitresult.weapon;
        if (function_c822562(var_1cf82592, 2)) {
            self clientfield::increment_to_player("hero_gravityspikes_vigor_postfx");
        }
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 0, eflags: 0x4
// Checksum 0xdc9f315c, Offset: 0xe90
// Size: 0x22a
function private function_6ae464c3() {
    while (isalive(self) && self.n_gravityspikes_state === 1) {
        foreach (e_player in level.players) {
            if (distancesquared(e_player.origin, self.origin) <= 1048576 && abs(e_player.origin[2] - self.origin[2] <= 360)) {
                if (e_player.n_gravityspikes_state !== 1 && !e_player laststand::player_is_in_laststand() && !(isdefined(e_player.var_bb893b9d) && e_player.var_bb893b9d)) {
                    e_player.var_bb893b9d = 1;
                }
                continue;
            }
            if (isdefined(e_player.var_bb893b9d) && e_player.var_bb893b9d) {
                e_player.var_bb893b9d = undefined;
            }
        }
        waitframe(1);
    }
    foreach (e_player in level.players) {
        if (isdefined(e_player.var_bb893b9d) && e_player.var_bb893b9d) {
            e_player.var_bb893b9d = undefined;
        }
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 12, eflags: 0x0
// Checksum 0xfecf3576, Offset: 0x10c8
// Size: 0xd8
function actor_damage_callback(inflictor, eattacker, idamage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (isplayer(eattacker) && isdefined(eattacker.var_bb893b9d) && eattacker.var_bb893b9d) {
        n_damage = int(idamage * 1.15);
        return n_damage;
    }
    return -1;
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x4
// Checksum 0xc26b9d7c, Offset: 0x11a8
// Size: 0x13c
function private function_e83656ca(w_gravityspikes) {
    self endon(#"disconnect");
    n_slot = self gadgetgetslot(w_gravityspikes);
    if (self function_49de461b(n_slot)) {
        for (var_475f5ef6 = self gadgetpowerget(n_slot); var_475f5ef6 > 0; var_475f5ef6 = self gadgetpowerget(n_slot)) {
            waitframe(1);
        }
        self ability_player::function_281eba9f(w_gravityspikes);
        self.var_f5b9f476 = 0;
    }
    self update_gravityspikes_state(0);
    self.b_gravity_trap_spikes_in_ground = undefined;
    self.b_gravity_trap_fx_on = undefined;
    self notify(#"gravity_spike_expired");
    if (self clientfield::get("gravity_shock_wave_fx")) {
        self clientfield::set("gravity_shock_wave_fx", 0);
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x0
// Checksum 0x3a60dca9, Offset: 0x12f0
// Size: 0xd8
function gravityspikes_attack_watcher(w_gravityspikes) {
    self endon(#"disconnect", #"bled_out", #"death", #"gravity_spike_expired");
    while (true) {
        s_result = self waittill(#"weapon_melee_power");
        if (s_result.weapon == w_gravityspikes) {
            self playrumbleonentity("talon_spike");
            self thread knockdown_zombies_slam(1);
            self thread no_damage_gravityspikes_slam();
        }
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x0
// Checksum 0x9d45204d, Offset: 0x13d0
// Size: 0xd8
function function_a22e9cb(w_gravityspikes) {
    self endon(#"disconnect", #"bled_out", #"death", #"gravity_spike_expired");
    while (true) {
        s_result = self waittill(#"weapon_melee");
        if (s_result.weapon == w_gravityspikes) {
            self playrumbleonentity("talon_spike");
            self thread knockdown_zombies_slam();
            self thread no_damage_gravityspikes_slam();
        }
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x4
// Checksum 0x382938bf, Offset: 0x14b0
// Size: 0x174
function private knockdown_zombies_slam(var_bbd6f659) {
    v_forward = anglestoforward(self getplayerangles());
    v_pos = self.origin + vectorscale(v_forward, 24);
    a_ai = getaiteamarray(level.zombie_team);
    a_ai = array::filter(a_ai, 0, &gravityspikes_target_filtering);
    a_ai_kill_zombies = arraysortclosest(a_ai, v_pos, a_ai.size, 0, 200);
    array::thread_all(a_ai_kill_zombies, &gravity_spike_melee_kill, v_pos, self, var_bbd6f659);
    a_ai_slam_zombies = arraysortclosest(a_ai, v_pos, a_ai.size, 200, 400);
    array::thread_all(a_ai_slam_zombies, &zombie_slam_direction, v_pos);
    self thread play_slam_fx(v_pos);
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x4
// Checksum 0xf6287323, Offset: 0x1630
// Size: 0x9c
function private play_slam_fx(v_pos) {
    mdl_fx_pos = util::spawn_model("tag_origin", v_pos, (-90, 0, 0));
    waitframe(1);
    mdl_fx_pos clientfield::set("gravity_slam_fx", 1);
    self clientfield::increment_to_player("gravity_slam_player_fx");
    waitframe(1);
    mdl_fx_pos delete();
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x4
// Checksum 0xd826533, Offset: 0x16d8
// Size: 0x6c
function private zombie_slam_direction(v_position) {
    self endon(#"death");
    if (!(self.archetype === "zombie") || isdefined(self.knockdown) && self.knockdown) {
        return;
    }
    zombie_utility::setup_zombie_knockdown(v_position);
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 11, eflags: 0x4
// Checksum 0xfcccf9ea, Offset: 0x1750
// Size: 0x94
function private player_invulnerable_during_gravityspike_slam(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    if (self.n_gravityspikes_state === 1 && isdefined(self.gravityspikes_slam) && self.gravityspikes_slam) {
        return 0;
    }
    return idamage;
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 0, eflags: 0x4
// Checksum 0x779ab611, Offset: 0x17f0
// Size: 0x26
function private no_damage_gravityspikes_slam() {
    self.gravityspikes_slam = 1;
    wait 1.5;
    self.gravityspikes_slam = undefined;
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 0, eflags: 0x4
// Checksum 0x9c57af57, Offset: 0x1820
// Size: 0x47a
function private gravityspikes_stuck_above_zombie_watcher() {
    self endon(#"disconnect", #"bled_out", #"death", #"gravity_spike_expired", #"hash_55b145e95edc2ebe");
    var_172dc133 = 1;
    while (true) {
        v_player_angles = self getplayerangles();
        forward_vec = anglestoforward((0, v_player_angles[1], 0));
        if (forward_vec[0] == 0 && forward_vec[1] == 0 && forward_vec[2] == 0) {
            waitframe(1);
            continue;
        }
        forward_right_45_vec = rotatepoint(forward_vec, (0, 45, 0));
        forward_left_45_vec = rotatepoint(forward_vec, (0, -45, 0));
        right_vec = anglestoright(v_player_angles);
        start_point = self.origin + (0, 0, 50);
        end_point = self.origin + (0, 0, -35);
        var_b4e8cb58 = [];
        if (var_172dc133) {
            var_b4e8cb58[0] = end_point + vectorscale(forward_vec, 30);
            var_b4e8cb58[1] = end_point + vectorscale(right_vec, 30);
            var_b4e8cb58[2] = end_point - vectorscale(right_vec, 30);
            var_172dc133 = 0;
        } else {
            var_b4e8cb58[0] = end_point + vectorscale(forward_right_45_vec, 30);
            var_b4e8cb58[1] = end_point + vectorscale(forward_left_45_vec, 30);
            var_b4e8cb58[2] = end_point - vectorscale(forward_vec, 30);
            var_172dc133 = 1;
        }
        for (i = 0; i < 3; i++) {
            trace = bullettrace(start_point, var_b4e8cb58[i], 1, self);
            /#
                if (getdvarint(#"hash_5e15d0f6012693c5", 0) > 0) {
                    line(start_point, var_b4e8cb58[i], (1, 1, 1), 1, 0, 60);
                    recordline(start_point, var_b4e8cb58[i], (1, 1, 1), "<dev string:x30>", self);
                }
            #/
            if (trace[#"fraction"] < 1) {
                if (isactor(trace[#"entity"]) && trace[#"entity"].health > 0 && (trace[#"entity"].archetype == "zombie" || trace[#"entity"].archetype == "zombie_dog")) {
                    self thread knockdown_zombies_slam();
                    self thread no_damage_gravityspikes_slam();
                    wait 1;
                    break;
                }
            }
        }
        waitframe(1);
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x0
// Checksum 0xab1fe2f7, Offset: 0x1ca8
// Size: 0x11a
function gravityspikes_altfire_watcher(w_gravityspikes) {
    self endon(#"disconnect", #"bled_out", #"death", #"gravity_spike_expired", #"gravity_spike_planted");
    while (true) {
        s_result = self waittill(#"weapon_melee_power_left");
        if (s_result.weapon == w_gravityspikes && !(isdefined(self.var_c90b5ea6) && self.var_c90b5ea6)) {
            self.var_c90b5ea6 = 1;
            self playrumbleonentity("damage_heavy");
            self thread function_10fdc94d(w_gravityspikes);
            self waittilltimeout(5, #"stop_shockwave");
            self.var_c90b5ea6 = undefined;
        }
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x4
// Checksum 0x58bf7451, Offset: 0x1dd0
// Size: 0x2f4
function private function_10fdc94d(w_gravityspikes) {
    self endon(#"disconnect", #"gravity_spike_expired", #"gravity_spike_planted");
    self clientfield::set("gravity_shock_wave_fx", 1);
    while (isdefined(self.var_c90b5ea6) && self.var_c90b5ea6) {
        v_forward = anglestoforward(self getplayerangles());
        v_pos = self.origin + vectorscale(v_forward, 24);
        var_9995acbc = arraygetclosest(self.origin, getaiteamarray(level.zombie_team), 200);
        a_ai_zombies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, 200);
        foreach (ai_zombie in a_ai_zombies) {
            if (isalive(ai_zombie) && ai_zombie.var_29ed62b2 == #"basic" && math::cointoss()) {
                ai_zombie thread zombie_utility::setup_zombie_knockdown(v_pos);
            }
        }
        if (!isdefined(var_9995acbc)) {
            wait 0.2;
            continue;
        }
        if (var_9995acbc.var_29ed62b2 == #"basic" || var_9995acbc.var_29ed62b2 == #"popcorn") {
            while (isalive(var_9995acbc)) {
                var_9995acbc thread function_7323d05f(self, w_gravityspikes);
                wait 0.2;
            }
            continue;
        }
        var_9995acbc thread function_7323d05f(self, w_gravityspikes);
        wait 0.2;
    }
    self clientfield::set("gravity_shock_wave_fx", 0);
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 2, eflags: 0x4
// Checksum 0x9864dff0, Offset: 0x20d0
// Size: 0x2b4
function private function_7323d05f(e_player, w_gravityspikes) {
    if (self.var_29ed62b2 == #"basic") {
        [[ level.var_74214c85 ]]->waitinqueue(self);
        n_damage = self.maxhealth * 0.25;
        self clientfield::set("gravity_aoe_impact_fx", 1);
        if (n_damage >= self.health || distance2d(e_player.origin, self.origin) <= 50) {
            e_player thread electrocute_actor(self);
            return;
        } else {
            self dodamage(n_damage, self.origin, e_player, e_player, "torso_upper", "MOD_ELECTROCUTED", 0, w_gravityspikes);
        }
        return;
    }
    if (self.var_29ed62b2 == #"popcorn") {
        self clientfield::set("gravity_aoe_impact_fx", 1);
        self dodamage(self.health + 100, self.origin, e_player, e_player, "head", "MOD_ELECTROCUTED", 0, w_gravityspikes);
        return;
    }
    if (self.var_29ed62b2 == #"miniboss" || self.var_29ed62b2 == #"boss") {
        self clientfield::set("gravity_aoe_impact_fx", 1);
        self dodamage(self.maxhealth * 0.1, self.origin, e_player, e_player, "head", "MOD_ELECTROCUTED", 0, w_gravityspikes);
        return;
    }
    self clientfield::set("gravity_aoe_impact_fx", 1);
    self dodamage(self.maxhealth * 0.2, self.origin, e_player, e_player, "head", "MOD_ELECTROCUTED", 0, w_gravityspikes);
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x4
// Checksum 0xdffed6df, Offset: 0x2390
// Size: 0x13c
function private electrocute_actor(ai_zombie) {
    self endon(#"disconnect");
    if (!isdefined(ai_zombie) || !isalive(ai_zombie)) {
        return;
    }
    bhtnactionstartevent(ai_zombie, "electrocute");
    ai_zombie notify(#"bhtn_action_notify", {#action:"electrocute"});
    if (!isdefined(self.tesla_enemies_hit)) {
        self.tesla_enemies_hit = 1;
    }
    lightning_params = lightning_chain::create_lightning_chain_params(5);
    lightning_params.head_gib_chance = 100;
    lightning_params.network_death_choke = 4;
    lightning_params.should_kill_enemies = 0;
    ai_zombie.tesla_death = 0;
    self thread arc_damage_init(ai_zombie, lightning_params);
    ai_zombie thread tesla_death();
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 2, eflags: 0x4
// Checksum 0x624d1368, Offset: 0x24d8
// Size: 0x5c
function private arc_damage_init(ai_zombie, params) {
    self endon(#"disconnect");
    if (ai_zombie ai::is_stunned()) {
        return;
    }
    ai_zombie lightning_chain::arc_damage_ent(self, 1, params);
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 0, eflags: 0x4
// Checksum 0x16a97244, Offset: 0x2540
// Size: 0xdc
function private tesla_death() {
    self endon(#"death");
    if (isdefined(level.no_gib_in_wolf_area) && isdefined(self [[ level.no_gib_in_wolf_area ]]()) && self [[ level.no_gib_in_wolf_area ]]()) {
        self.no_gib = 1;
    }
    if (!(isdefined(self.no_gib) && self.no_gib)) {
        self thread function_a3501706();
    }
    wait 2;
    if (isdefined(self)) {
        self dodamage(self.health + 100, self.origin, undefined, undefined, "torso_upper", "MOD_ELECTROCUTED");
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 0, eflags: 0x4
// Checksum 0x4bc78336, Offset: 0x2628
// Size: 0xf4
function private function_a3501706() {
    self waittill(#"death");
    if (isdefined(self) && isactor(self)) {
        if (randomint(100) < 50) {
            gibserverutils::gibhead(self);
        }
        if (randomint(100) < 50) {
            gibserverutils::gibleftarm(self);
        }
        if (randomint(100) < 50) {
            gibserverutils::gibrightarm(self);
        }
        if (randomint(100) < 50) {
            gibserverutils::giblegs(self);
        }
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x0
// Checksum 0xfaa72f0d, Offset: 0x2728
// Size: 0x14c
function function_8f7a5b57(w_gravityspikes) {
    self endon(#"disconnect", #"bled_out", #"death", #"gravity_spike_expired", #"hash_55b145e95edc2ebe");
    while (true) {
        s_result = self waittill(#"weapon_melee");
        if (s_result.weapon === w_gravityspikes && isdefined(self gravity_spike_position_valid()) && self gravity_spike_position_valid()) {
            if (isdefined(self.var_c90b5ea6) && self.var_c90b5ea6) {
                self notify(#"stop_shockwave");
                self.var_c90b5ea6 = undefined;
            }
            self thread plant_gravity_trap(w_gravityspikes);
            continue;
        }
        self playsound(#"zmb_trap_deny");
        wait 1;
        continue;
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 0, eflags: 0x4
// Checksum 0xb0e315ab, Offset: 0x2880
// Size: 0x48
function private gravity_spike_position_valid() {
    if (!ispointonnavmesh(self.origin, self)) {
        return 0;
    }
    if (isdefined(level.gravityspike_position_check)) {
        return self [[ level.gravityspike_position_check ]]();
    }
    return 1;
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x4
// Checksum 0x6d0c1d44, Offset: 0x28d0
// Size: 0x23a
function private player_near_gravity_vortex(v_vortex_origin) {
    self endon(#"disconnect", #"bled_out", #"death", #"gravity_spike_expired");
    while (isdefined(self.b_gravity_trap_spikes_in_ground) && self.b_gravity_trap_spikes_in_ground && self.n_gravityspikes_state === 1) {
        foreach (e_player in level.players) {
            if (zm_utility::is_player_valid(e_player) && !(isdefined(e_player.idgun_vision_on) && e_player.idgun_vision_on)) {
                if (distance(e_player.origin, v_vortex_origin) < float(64)) {
                    e_player thread zombie_vortex::player_vortex_visionset("zm_idgun_vortex");
                }
            }
            if (distance(e_player.origin, v_vortex_origin) < 128) {
                e_player.var_b488bab0 = 1;
            } else {
                e_player.var_b488bab0 = undefined;
            }
            if (e_player laststand::player_is_in_laststand() && distance(e_player.origin, v_vortex_origin) < 128) {
                self thread function_54e4783e(e_player);
                continue;
            }
            if (isdefined(e_player.var_471b53c6)) {
                e_player thread function_b0e0bcdd();
            }
        }
        waitframe(1);
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 0, eflags: 0x0
// Checksum 0xd5916e83, Offset: 0x2b18
// Size: 0x1c
function function_9567396a() {
    self thread function_8b5fe69();
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 0, eflags: 0x0
// Checksum 0x96ad9125, Offset: 0x2b40
// Size: 0xb6
function function_8b5fe69() {
    if (!isdefined(self.var_6d2e4034)) {
        self.var_6d2e4034 = [];
    }
    s_revive_override = self zm_laststand::register_revive_override(&function_73277c01);
    if (!isdefined(self.var_6d2e4034)) {
        self.var_6d2e4034 = [];
    } else if (!isarray(self.var_6d2e4034)) {
        self.var_6d2e4034 = array(self.var_6d2e4034);
    }
    self.var_6d2e4034[self.var_6d2e4034.size] = s_revive_override;
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x4
// Checksum 0x88f6ffd6, Offset: 0x2c00
// Size: 0x84
function private function_54e4783e(e_revivee) {
    if (!isdefined(e_revivee.var_471b53c6)) {
        if (self !== e_revivee) {
            e_revivee.var_74f06e59 += 100;
        }
        e_revivee.get_revive_time = &override_revive_time;
        e_revivee.var_471b53c6 = self;
        self thread function_1136d2ac(e_revivee);
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x4
// Checksum 0xa4e9a8d8, Offset: 0x2c90
// Size: 0x8c
function private function_1136d2ac(e_revivee) {
    e_revivee endon(#"disconnect", #"death", #"bledout", #"stop_revive_trigger");
    self waittill(#"disconnect", #"gravity_spike_expired");
    e_revivee thread function_b0e0bcdd();
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x0
// Checksum 0xb130705f, Offset: 0x2d28
// Size: 0x62
function override_revive_time(e_revivee) {
    n_time = 3;
    if (self hasperk(#"specialty_quickrevive")) {
        n_time /= 4;
    } else {
        n_time /= 2;
    }
    return n_time;
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x0
// Checksum 0x3501c0a2, Offset: 0x2d98
// Size: 0x56
function function_b0e0bcdd(s_params) {
    if (self != level) {
        if (isdefined(s_params)) {
            e_revivee = s_params.e_revivee;
        } else {
            e_revivee = self;
        }
        e_revivee.get_revive_time = undefined;
        e_revivee.var_471b53c6 = undefined;
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x0
// Checksum 0x595dbd3d, Offset: 0x2df8
// Size: 0x192
function function_73277c01(e_revivee) {
    if (!isdefined(e_revivee.revivetrigger)) {
        return false;
    }
    if (!isalive(self)) {
        return false;
    }
    if (self laststand::player_is_in_laststand() && !isdefined(self.var_e916a9ce)) {
        return false;
    }
    if (self.team != e_revivee.team) {
        return false;
    }
    if (isdefined(self.is_zombie) && self.is_zombie) {
        return false;
    }
    if (isdefined(level.can_revive_use_depthinwater_test) && level.can_revive_use_depthinwater_test && e_revivee depthinwater() > 10) {
        return true;
    }
    if (isdefined(level.can_revive) && ![[ level.can_revive ]](e_revivee)) {
        return false;
    }
    if (isdefined(level.var_ae6ced2b) && ![[ level.var_ae6ced2b ]](e_revivee)) {
        return false;
    }
    if (e_revivee zm_player::in_kill_brush() || !e_revivee zm_player::in_enabled_playable_area()) {
        return false;
    }
    if (e_revivee.var_471b53c6 === self) {
        return true;
    }
    return false;
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x0
// Checksum 0x54f24741, Offset: 0x2f98
// Size: 0x36
function function_d9d1bae7(perk) {
    self thread zm_perks::function_dde955e2(perk, &function_77cc9c5c);
    return false;
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 2, eflags: 0x0
// Checksum 0x9677f86e, Offset: 0x2fd8
// Size: 0x28
function function_77cc9c5c(e_reviver, var_471b53c6) {
    return isdefined(self.var_b488bab0) && self.var_b488bab0;
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x0
// Checksum 0x163e0e40, Offset: 0x3008
// Size: 0x422
function plant_gravity_trap(w_gravityspikes) {
    self endon(#"disconnect", #"bled_out", #"death");
    self notify(#"hash_55b145e95edc2ebe");
    self ability_player::function_184edba5(w_gravityspikes);
    self.var_f5b9f476 = 1;
    self thread zm_audio::create_and_play_dialog(#"hero_level_3", #"gravityspikes");
    v_forward = anglestoforward(self.angles);
    v_right = anglestoright(self.angles);
    v_spawn_pos_right = self.origin + (0, 0, 32);
    v_spawn_pos_left = v_spawn_pos_right;
    a_trace = physicstraceex(v_spawn_pos_right, v_spawn_pos_right + v_right * 24, (-16, -16, -16), (16, 16, 16), self);
    v_spawn_pos_right += v_right * a_trace[#"fraction"] * 24;
    a_trace = physicstraceex(v_spawn_pos_left, v_spawn_pos_left + v_right * -24, (-16, -16, -16), (16, 16, 16), self);
    v_spawn_pos_left += v_right * a_trace[#"fraction"] * -24;
    v_spawn_pos_right = util::ground_position(v_spawn_pos_right, 1000, 24);
    v_spawn_pos_left = util::ground_position(v_spawn_pos_left, 1000, 24);
    var_e987f01a = array(v_spawn_pos_right, v_spawn_pos_left);
    self create_gravity_trap_spikes_in_ground(var_e987f01a);
    if (self isonground()) {
        var_5da14f3b = self.origin + (0, 0, 32);
    } else {
        var_5da14f3b = util::ground_position(self.origin, 1000, length((0, 0, 32)));
    }
    self gravity_trap_fx_on(var_5da14f3b);
    self.b_gravity_trap_spikes_in_ground = 1;
    self.var_5da14f3b = var_5da14f3b;
    self thread player_near_gravity_vortex(var_5da14f3b);
    self thread destroy_gravity_trap_spikes_in_ground();
    self thread gravity_trap_loop(self.var_5da14f3b, w_gravityspikes);
    self waittill(#"gravity_spike_expired");
    if (isdefined(self)) {
        self.b_gravity_trap_spikes_in_ground = undefined;
        self notify(#"destroy_ground_spikes");
    }
    foreach (e_player in level.players) {
        e_player.var_b488bab0 = undefined;
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 2, eflags: 0x4
// Checksum 0x5e0d1ecd, Offset: 0x3438
// Size: 0x154
function private gravity_trap_loop(var_5da14f3b, w_gravityspikes) {
    self endon(#"disconnect", #"bled_out", #"death");
    is_gravity_trap_fx_on = 1;
    while (true) {
        if (self gadgetpowerget(self gadgetgetslot(w_gravityspikes)) > 0) {
            a_zombies = getaiteamarray(level.zombie_team);
            a_zombies = array::filter(a_zombies, 0, &gravityspikes_target_filtering);
            array::thread_all(a_zombies, &gravity_trap_check, self);
        } else if (is_gravity_trap_fx_on) {
            self gravity_trap_fx_off();
            is_gravity_trap_fx_on = 0;
            return;
        }
        if (!(isdefined(self.b_gravity_trap_spikes_in_ground) && self.b_gravity_trap_spikes_in_ground)) {
            return;
        }
        wait 0.1;
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x4
// Checksum 0x60460992, Offset: 0x3598
// Size: 0x1bc
function private gravity_trap_check(player) {
    player endon(#"disconnect", #"bled_out", #"death");
    assert(isdefined(level.ai_gravity_throttle));
    assert(isdefined(player));
    if (!isdefined(player.mdl_gravity_trap_fx_source)) {
        return;
    }
    n_gravity_trap_radius_sq = 16384;
    v_gravity_trap_origin = player.mdl_gravity_trap_fx_source.origin;
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    if (self check_for_range_and_los(v_gravity_trap_origin, 96, n_gravity_trap_radius_sq)) {
        if (self.in_gravity_trap === 1) {
            return;
        }
        self.in_gravity_trap = 1;
        [[ level.ai_gravity_throttle ]]->waitinqueue(self);
        if (isdefined(self) && isalive(self)) {
            self zombie_lift(player, v_gravity_trap_origin, 0, randomintrange(184, 284), (0, 0, -24), randomintrange(64, 128));
        }
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x4
// Checksum 0x17b06dd0, Offset: 0x3760
// Size: 0x172
function private create_gravity_trap_spikes_in_ground(var_e987f01a) {
    if (!isdefined(self.mdl_gravity_trap_spikes)) {
        self.mdl_gravity_trap_spikes = [];
    }
    for (i = 0; i < var_e987f01a.size; i++) {
        if (!isdefined(self.mdl_gravity_trap_spikes[i])) {
            self.mdl_gravity_trap_spikes[i] = util::spawn_model("wpn_zmb_dlc1_talon_spike_single_world", var_e987f01a[i]);
        }
        self.mdl_gravity_trap_spikes[i].origin = var_e987f01a[i];
        self.mdl_gravity_trap_spikes[i].angles = self.angles;
        self.mdl_gravity_trap_spikes[i] show();
        waitframe(1);
        self.mdl_gravity_trap_spikes[i] thread gravity_spike_planted_play();
        self.mdl_gravity_trap_spikes[i] clientfield::set("gravity_trap_spike_spark", 1);
        if (isdefined(level.var_e1885a4b)) {
            [[ level.var_e1885a4b ]](self.mdl_gravity_trap_spikes[i]);
        }
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 0, eflags: 0x4
// Checksum 0x9bd6c53e, Offset: 0x38e0
// Size: 0x4c
function private gravity_spike_planted_play() {
    self endon(#"death");
    wait 2;
    self thread scene::play(#"cin_zm_dlc1_spike_plant_loop", self);
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 0, eflags: 0x4
// Checksum 0x6cdcd064, Offset: 0x3938
// Size: 0x16e
function private destroy_gravity_trap_spikes_in_ground() {
    mdl_spike_source = self.mdl_gravity_trap_fx_source;
    mdl_gravity_trap_spikes = self.mdl_gravity_trap_spikes;
    self.var_e916a9ce = mdl_spike_source;
    self waittill(#"destroy_ground_spikes", #"disconnect", #"bled_out");
    self.var_e916a9ce = undefined;
    if (isdefined(mdl_spike_source)) {
        mdl_spike_source playsound(#"hash_5d0917b44402f070");
        mdl_spike_source clientfield::set("gravity_trap_location", 0);
        mdl_spike_source delete();
    }
    if (!isdefined(mdl_gravity_trap_spikes)) {
        return;
    }
    for (i = 0; i < mdl_gravity_trap_spikes.size; i++) {
        mdl_gravity_trap_spikes[i] thread scene::stop(#"cin_zm_dlc1_spike_plant_loop");
        mdl_gravity_trap_spikes[i] clientfield::set("gravity_trap_spike_spark", 0);
        mdl_gravity_trap_spikes[i] delete();
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x4
// Checksum 0xafbdcb66, Offset: 0x3ab0
// Size: 0x8c
function private gravity_trap_fx_on(v_spawn_pos) {
    if (!isdefined(self.mdl_gravity_trap_fx_source)) {
        self.mdl_gravity_trap_fx_source = util::spawn_model("tag_origin", v_spawn_pos);
    }
    self.mdl_gravity_trap_fx_source.origin = v_spawn_pos;
    self.mdl_gravity_trap_fx_source show();
    waitframe(1);
    self.mdl_gravity_trap_fx_source clientfield::set("gravity_trap_fx", 1);
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 0, eflags: 0x4
// Checksum 0xeb0bcc07, Offset: 0x3b48
// Size: 0x5c
function private gravity_trap_fx_off() {
    if (!isdefined(self.mdl_gravity_trap_fx_source)) {
        return;
    }
    self.mdl_gravity_trap_fx_source clientfield::set("gravity_trap_fx", 0);
    self.mdl_gravity_trap_fx_source clientfield::set("gravity_trap_location", 1);
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x0
// Checksum 0xf51cf800, Offset: 0x3bb0
// Size: 0x1a
function update_gravityspikes_state(n_gravityspikes_state) {
    self.n_gravityspikes_state = n_gravityspikes_state;
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 3, eflags: 0x4
// Checksum 0xe4b361a1, Offset: 0x3bd8
// Size: 0xee
function private check_for_range_and_los(v_attack_source, n_allowed_z_diff, n_radius_sq) {
    if (isalive(self)) {
        n_z_diff = self.origin[2] - v_attack_source[2];
        if (abs(n_z_diff) < n_allowed_z_diff) {
            if (distance2dsquared(self.origin, v_attack_source) < n_radius_sq) {
                v_offset = (0, 0, 50);
                if (bullettracepassed(self.origin + v_offset, v_attack_source + v_offset, 0, self)) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x4
// Checksum 0x5e3d7800, Offset: 0x3cd0
// Size: 0x46
function private gravityspikes_target_filtering(ai_enemy) {
    b_callback_result = 1;
    if (isdefined(level.var_8142aca1)) {
        b_callback_result = [[ level.var_8142aca1 ]](ai_enemy);
    }
    return b_callback_result;
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 6, eflags: 0x4
// Checksum 0x17b50e7f, Offset: 0x3d20
// Size: 0xdb4
function private zombie_lift(player, v_attack_source, n_push_away, n_lift_height, v_lift_offset, n_lift_speed) {
    w_gravityspikes = player.var_c332c9d4;
    if (isdefined(self.zombie_lift_override)) {
        self thread [[ self.zombie_lift_override ]](player, v_attack_source, n_push_away, n_lift_height, v_lift_offset, n_lift_speed);
        return;
    }
    if (!isdefined(self) || !isdefined(self.var_29ed62b2)) {
        return;
    }
    if (self.var_29ed62b2 === #"popcorn") {
        self.no_powerups = 1;
        self dodamage(self.health + 100, self.origin, player, player, "head", "MOD_ELECTROCUTED", 0, w_gravityspikes);
        self playsound("wpn_dg4_electrocution_impact");
        return;
    }
    if (self.var_29ed62b2 === #"miniboss") {
        if (isalive(self) && isdefined(self.b_melee_kill) && self.b_melee_kill && !(isdefined(self.var_65bbe67a) && self.var_65bbe67a) && !(isdefined(player.b_gravity_trap_spikes_in_ground) && player.b_gravity_trap_spikes_in_ground)) {
            self dodamage(self.maxhealth * 0.1, self.origin, player, player, "head", "MOD_ELECTROCUTED", 0, w_gravityspikes);
            self.var_65bbe67a = 1;
            self.b_melee_kill = undefined;
            self ai::stun();
            wait 1;
            self.var_65bbe67a = undefined;
            self ai::clear_stun();
        } else if (isalive(self) && !(isdefined(self.var_10945084) && self.var_10945084) && isdefined(player.b_gravity_trap_spikes_in_ground) && player.b_gravity_trap_spikes_in_ground) {
            self dodamage(self.maxhealth * 0.1, self.origin, player, player, "torso_upper", "MOD_ELECTROCUTED", 0, w_gravityspikes);
            self thread track_lifted_for_ragdoll_count();
            self.var_10945084 = 1;
            self val::set(#"trap_ignore", "ignoreall", 1);
            self thread scene::init(#"p8_zm_gravityspikes_miniboss_trap_scene", self);
            self clientfield::set("sparky_beam_fx", 1);
            self clientfield::set("sparky_zombie_fx", 1);
            self thread gravity_trap_notify_watcher(player);
            self waittill(#"gravity_trap_complete");
            self thread scene::play(#"p8_zm_gravityspikes_miniboss_trap_scene", self);
            self.in_gravity_trap = undefined;
            self.var_10945084 = undefined;
            self val::reset(#"trap_ignore", "ignoreall");
            self clientfield::set("sparky_beam_fx", 0);
            self clientfield::set("sparky_zombie_fx", 0);
            self clientfield::set("sparky_zombie_trail_fx", 1);
        }
        return;
    }
    if (self.var_29ed62b2 === #"boss") {
        if (isalive(self) && isdefined(self.b_melee_kill) && self.b_melee_kill && !(isdefined(self.var_65bbe67a) && self.var_65bbe67a) && !(isdefined(player.b_gravity_trap_spikes_in_ground) && player.b_gravity_trap_spikes_in_ground)) {
            self dodamage(self.maxhealth * 0.05, self.origin, player, player, "head", "MOD_ELECTROCUTED", 0, w_gravityspikes);
            self.var_65bbe67a = 1;
            self.b_melee_kill = undefined;
            wait 1;
            self.var_65bbe67a = undefined;
        } else if (isalive(self) && !(isdefined(self.var_10945084) && self.var_10945084) && isdefined(player.b_gravity_trap_spikes_in_ground) && player.b_gravity_trap_spikes_in_ground) {
            self dodamage(self.maxhealth * 0.05, self.origin, player, player, "head", "MOD_ELECTROCUTED", 0, w_gravityspikes);
            self.var_10945084 = 1;
            self waittill(#"death", #"gravity_trap_complete");
            self.var_10945084 = undefined;
            self.in_gravity_trap = undefined;
        }
        return;
    }
    if (isdefined(level.no_gib_in_wolf_area) && isdefined(self [[ level.no_gib_in_wolf_area ]]()) && self [[ level.no_gib_in_wolf_area ]]()) {
        self.ignore_gravityspikes_ragdoll = 1;
    }
    if (level.n_zombies_lifted_for_ragdoll < 12 && !(isdefined(self.ignore_gravityspikes_ragdoll) && self.ignore_gravityspikes_ragdoll)) {
        self thread track_lifted_for_ragdoll_count();
        v_centroid = self getcentroid();
        v_away_from_source = vectornormalize(v_centroid - v_attack_source);
        v_away_from_source *= n_push_away;
        v_away_from_source = (v_away_from_source[0], v_away_from_source[1], n_lift_height);
        a_trace = physicstraceex(v_centroid + (0, 0, 32), v_centroid + v_away_from_source, (-16, -16, -16), (16, 16, 16), self);
        v_lift = a_trace[#"fraction"] * v_away_from_source;
        v_lift += v_lift_offset;
        if (!(isdefined(bullettracepassed(v_centroid, v_centroid + v_lift, 0, self)) && bullettracepassed(v_centroid, v_centroid + v_lift, 0, self))) {
            v_trace_pos = bullettrace(v_centroid, v_centroid + v_lift, 0, self)[#"position"];
            if (isdefined(v_trace_pos)) {
                v_lift = v_trace_pos + v_lift_offset;
            }
        }
        n_lift_time = length(v_lift) / n_lift_speed;
        if (isdefined(self) && isdefined(self.b_melee_kill) && self.b_melee_kill) {
            self setplayercollision(0);
            if (!(isdefined(level.ignore_gravityspikes_ragdoll) && level.ignore_gravityspikes_ragdoll)) {
                self startragdoll();
                self launchragdoll(150 * anglestoup(self.angles) + (v_away_from_source[0], v_away_from_source[1], 0));
            }
            self clientfield::set("ragdoll_impact_watch", 1);
            self clientfield::set("sparky_zombie_trail_fx", 1);
            waitframe(1);
        } else if (isdefined(self) && v_lift[2] > 0) {
            self setplayercollision(0);
            self clientfield::set("sparky_beam_fx", 1);
            self clientfield::set("sparky_zombie_fx", 1);
            self playsound("zmb_talon_electrocute");
            if (isdefined(self.missinglegs) && self.missinglegs) {
                self thread scene::play(#"cin_zm_dlc1_zombie_crawler_talonspike_a_loop", self);
            } else {
                self thread scene::play(#"cin_zm_dlc1_zombie_talonspike_loop", self);
            }
            self.mdl_trap_mover = util::spawn_model("tag_origin", v_centroid, self.angles);
            self thread util::delete_on_death(self.mdl_trap_mover);
            self linkto(self.mdl_trap_mover);
            self.mdl_trap_mover moveto(v_centroid + v_lift, n_lift_time, 0, n_lift_time * 0.4);
            self thread zombie_lift_wacky_rotate(n_lift_time, player);
            self thread gravity_trap_notify_watcher(player);
            self waittill(#"gravity_trap_complete");
            if (isdefined(self)) {
                self unlink();
                self scene::stop();
                self startragdoll(1);
                self clientfield::set("gravity_slam_down", 1);
                self clientfield::set("sparky_beam_fx", 0);
                self clientfield::set("sparky_zombie_fx", 0);
                self clientfield::set("sparky_zombie_trail_fx", 1);
                self clientfield::set("ragdoll_impact_watch", 1);
                v_land_pos = util::ground_position(self.origin, 1000);
                n_fall_dist = abs(self.origin[2] - v_land_pos[2]);
                n_slam_wait = n_fall_dist / 200 * 0.75;
                self thread corpse_off_navmesh_watcher(n_slam_wait);
                if (n_slam_wait > 0) {
                    wait n_slam_wait;
                }
            }
        }
        if (isalive(self)) {
            self zombie_kill_and_gib(player);
            self playsound("zmb_talon_ai_slam");
        }
        return;
    }
    self zombie_kill_and_gib(player);
    self playsound("zmb_talon_ai_slam");
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x4
// Checksum 0x4e085adf, Offset: 0x4ae0
// Size: 0x9e
function private gravity_trap_notify_watcher(player) {
    self endon(#"gravity_trap_complete");
    if (isdefined(self.mdl_trap_mover)) {
        self thread gravity_trap_timeout_watcher();
    }
    util::waittill_any_ents(self, "death", player, #"gravity_spike_expired", player, "disconnect", player, "bled_out");
    self notify(#"gravity_trap_complete");
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 0, eflags: 0x4
// Checksum 0x34217243, Offset: 0x4b88
// Size: 0x9e
function private gravity_trap_timeout_watcher() {
    self endon(#"gravity_trap_complete");
    self.mdl_trap_mover waittilltimeout(4, #"movedone");
    if (isalive(self) && !(isdefined(self.b_melee_kill) && self.b_melee_kill)) {
        wait randomfloatrange(0.2, 1);
    }
    self notify(#"gravity_trap_complete");
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 2, eflags: 0x4
// Checksum 0x5e1110b8, Offset: 0x4c30
// Size: 0x16c
function private zombie_lift_wacky_rotate(n_lift_time, player) {
    player endon(#"gravity_spike_expired");
    self endon(#"death");
    while (true) {
        negative_x = randomintrange(0, 10) > 5 ? -1 : 1;
        negative_z = randomintrange(0, 10) > 5 ? -1 : 1;
        self.mdl_trap_mover rotateto((randomintrange(90, 180) * negative_x, randomintrange(-90, 90), randomintrange(90, 180) * negative_z), n_lift_time < 2 ? 5 : n_lift_time, 0);
        self.mdl_trap_mover waittill(#"rotatedone");
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x4
// Checksum 0x986c2a67, Offset: 0x4da8
// Size: 0x134
function private zombie_kill_and_gib(player) {
    w_gravityspikes = player.var_c332c9d4;
    if (isdefined(level.no_gib_in_wolf_area) && isdefined(self [[ level.no_gib_in_wolf_area ]]()) && self [[ level.no_gib_in_wolf_area ]]()) {
        self.no_gib = 1;
    }
    self.no_powerups = 1;
    self dodamage(self.health + 100, self.origin, player, player, "torso_upper", "MOD_ELECTROCUTED", 0, w_gravityspikes);
    waitframe(1);
    if (isdefined(self) && true && !(isdefined(self.no_gib) && self.no_gib)) {
        n_random = randomint(100);
        if (n_random >= 20) {
            self zombie_utility::gib_random_parts();
        }
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 0, eflags: 0x4
// Checksum 0x5e2bcc32, Offset: 0x4ee8
// Size: 0x40
function private track_lifted_for_ragdoll_count() {
    level.n_zombies_lifted_for_ragdoll++;
    self waittill(#"death", #"gravity_trap_complete");
    level.n_zombies_lifted_for_ragdoll--;
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x4
// Checksum 0x340ec36d, Offset: 0x4f30
// Size: 0x124
function private corpse_off_navmesh_watcher(n_timeout) {
    self.b_ignore_cleanup = 1;
    if (self.var_29ed62b2 !== #"basic") {
        return;
    }
    s_result = self waittilltimeout(n_timeout, #"actor_corpse");
    if (s_result._notify == "actor_corpse") {
        v_pos = getclosestpointonnavmesh(s_result.corpse.origin, 256);
        if (!isdefined(v_pos) || s_result.corpse.origin[2] > v_pos[2] + 64) {
            s_result.corpse thread do_zombie_explode();
        }
        return;
    }
    if (isdefined(self)) {
        self thread do_zombie_explode();
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 0, eflags: 0x4
// Checksum 0x1888e490, Offset: 0x5060
// Size: 0xa4
function private do_zombie_explode() {
    waitframe(1);
    if (isdefined(self)) {
        if (self.animname === "zombie_eaten") {
            return;
        }
        if (isdefined(level.no_gib_in_wolf_area) && isdefined(self [[ level.no_gib_in_wolf_area ]]()) && self [[ level.no_gib_in_wolf_area ]]()) {
            self.no_gib = 1;
        }
        if (!(isdefined(self.no_gib) && self.no_gib)) {
            gibserverutils::annihilate(self);
        }
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 3, eflags: 0x4
// Checksum 0x73a079fe, Offset: 0x5110
// Size: 0xbc
function private gravity_spike_melee_kill(v_position, player, var_bbd6f659) {
    self.b_melee_kill = 1;
    self.var_3a279bb5 = var_bbd6f659;
    if (self check_for_range_and_los(v_position, 96, 40000)) {
        self zombie_lift(player, v_position, 128, randomintrange(128, 200), (0, 0, 0), randomintrange(150, 200));
    }
}

// Namespace zm_weap_gravityspikes/zm_weap_gravityspikes
// Params 1, eflags: 0x0
// Checksum 0xce10b3e7, Offset: 0x51d8
// Size: 0xc4
function function_d145c1c1(w_gravityspikes) {
    self endon(#"disconnect", #"bled_out", #"death", #"gravity_spike_expired", #"gravity_spike_planted");
    s_result = self waittill(#"weapon_melee_power_left");
    if (s_result.weapon == w_gravityspikes) {
        self thread zm_audio::create_and_play_dialog(#"hero_level_2", #"gravityspikes");
    }
}

