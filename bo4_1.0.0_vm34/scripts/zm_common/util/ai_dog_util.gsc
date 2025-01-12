#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_net;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zombie_dog_util;

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x2
// Checksum 0xb0080bc, Offset: 0x300
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zombie_dog_util", &__init__, undefined, #"aat");
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0x525339a1, Offset: 0x350
// Size: 0x284
function __init__() {
    clientfield::register("actor", "dog_fx", 1, 1, "int");
    clientfield::register("actor", "dog_spawn_fx", 1, 1, "counter");
    clientfield::register("world", "dog_round_fog_bank", 1, 1, "int");
    level.var_61c54e76 = 1;
    level.var_459c76d = 0;
    level.dog_round_count = 1;
    level.dog_spawners = [];
    level flag::init("dog_clips");
    zombie_utility::set_zombie_var(#"dog_fire_trail_percent", 50);
    level thread aat::register_immunity("zm_aat_brain_decay", "zombie_dog", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_frostbite", "zombie_dog", 0, 0, 1);
    level thread aat::register_immunity("zm_aat_kill_o_watt", "blight_father", 0, 1, 1);
    level thread aat::register_immunity("zm_aat_plasmatic_burst", "zombie_dog", 0, 1, 1);
    dog_spawner_init();
    level thread dog_clip_monitor();
    zm_round_spawning::register_archetype("zombie_dog", &function_cd72b07e, &dog_round_spawn, &function_ce9ad1e6, 25);
    zm_score::function_c723805e("zombie_dog", 60);
    callback::function_8def5e51(&function_fb5bfc80);
}

// Namespace zombie_dog_util/ai_dog_util
// Params 1, eflags: 0x0
// Checksum 0xa18c2c9a, Offset: 0x5e0
// Size: 0x9c
function dog_enable_rounds(b_ignore_cleanup = 1) {
    if (!zm_custom::function_5638f689(#"zmspecialroundsenabled")) {
        return;
    }
    level.var_459c76d = 1;
    level.var_9490a685 = b_ignore_cleanup;
    if (!isdefined(level.dog_round_track_override)) {
        level.dog_round_track_override = &dog_round_tracker;
    }
    level thread [[ level.dog_round_track_override ]]();
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0x97f7893d, Offset: 0x688
// Size: 0x1ac
function dog_spawner_init() {
    level.dog_spawners = getentarray("zombie_dog_spawner", "script_noteworthy");
    later_dogs = getentarray("later_round_dog_spawners", "script_noteworthy");
    level.dog_spawners = arraycombine(level.dog_spawners, later_dogs, 1, 0);
    if (level.dog_spawners.size == 0) {
        return;
    }
    for (i = 0; i < level.dog_spawners.size; i++) {
        if (zm_spawner::is_spawner_targeted_by_blocker(level.dog_spawners[i])) {
            level.dog_spawners[i].is_enabled = 0;
            continue;
        }
        level.dog_spawners[i].is_enabled = 1;
        level.dog_spawners[i].script_forcespawn = 1;
    }
    assert(level.dog_spawners.size > 0);
    level.dog_health = 100;
    array::thread_all(level.dog_spawners, &spawner::add_spawn_function, &dog_init);
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0xc3d1bd3c, Offset: 0x840
// Size: 0x5e
function function_a4ff236() {
    a_e_players = getplayers();
    if (level.dog_round_count < 3) {
        n_max = a_e_players.size * 6;
    } else {
        n_max = a_e_players.size * 8;
    }
    return n_max;
}

// Namespace zombie_dog_util/ai_dog_util
// Params 2, eflags: 0x0
// Checksum 0x5bfd25c9, Offset: 0x8a8
// Size: 0xfc
function waiting_for_next_dog_spawn(count, max) {
    default_wait = 0.75;
    if (level.dog_round_count == 1) {
        default_wait = 2;
    } else if (level.dog_round_count == 2) {
        default_wait = 1.5;
    } else if (level.dog_round_count == 3) {
        default_wait = 1;
    } else {
        default_wait = 0.75;
    }
    if (isdefined(count) && isdefined(max)) {
        wait max(default_wait - count / max, 0.05);
        return;
    }
    wait max(default_wait - 0.5, 0.05);
}

// Namespace zombie_dog_util/ai_dog_util
// Params 1, eflags: 0x0
// Checksum 0xbfa8f26a, Offset: 0x9b0
// Size: 0x4c
function function_3ab5914f(s_params) {
    if (isdefined(self) && !zm_utility::is_standard()) {
        level thread zm_powerups::specific_powerup_drop("full_ammo", self.origin);
    }
}

// Namespace zombie_dog_util/ai_dog_util
// Params 2, eflags: 0x0
// Checksum 0xbdde1b3b, Offset: 0xa08
// Size: 0x308
function dog_spawn_fx(ai, ent) {
    ai endon(#"death");
    ai val::set(#"dog_spawn", "allowdeath", 0);
    ai setfreecameralockonallowed(0);
    playsoundatposition(#"zmb_hellhound_prespawn", ent.origin);
    wait 1.5;
    playsoundatposition(#"zmb_hellhound_bolt", ent.origin);
    earthquake(0.5, 0.75, ent.origin, 1000);
    playsoundatposition(#"zmb_hellhound_spawn", ent.origin);
    if (isdefined(ai.favoriteenemy)) {
        angle = vectortoangles(ai.favoriteenemy.origin - ent.origin);
        angles = (ai.angles[0], angle[1], ai.angles[2]);
    } else {
        angles = ent.angles;
    }
    ai dontinterpolate();
    ai forceteleport(ent.origin, angles);
    ai clientfield::increment("dog_spawn_fx");
    assert(isdefined(ai), "<dev string:x30>");
    assert(isalive(ai), "<dev string:x43>");
    ai zombie_setup_attack_properties_dog();
    ai val::reset(#"dog_spawn", "allowdeath");
    wait 0.1;
    ai show();
    ai setfreecameralockonallowed(1);
    ai val::reset(#"dog_spawn", "ignoreme");
    ai notify(#"visible");
}

// Namespace zombie_dog_util/ai_dog_util
// Params 1, eflags: 0x0
// Checksum 0xce715e3d, Offset: 0xd18
// Size: 0x114
function dog_spawn_factory_logic(favorite_enemy) {
    dog_locs = array::randomize(level.zm_loc_types[#"dog_location"]);
    for (i = 0; i < dog_locs.size; i++) {
        if (isdefined(level.old_dog_spawn) && level.old_dog_spawn == dog_locs[i]) {
            continue;
        }
        dist_squared = distancesquared(dog_locs[i].origin, favorite_enemy.origin);
        if (dist_squared > 160000 && dist_squared < 1000000) {
            level.old_dog_spawn = dog_locs[i];
            return dog_locs[i];
        }
    }
    return dog_locs[0];
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0x1f3a5b10, Offset: 0xe38
// Size: 0x96
function function_fb5bfc80() {
    players = getplayers();
    foreach (player in players) {
        player.var_51adc1b0 = 0;
        player.hunted_by = 0;
    }
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0x6502637e, Offset: 0xed8
// Size: 0x134
function function_a37b6ca1() {
    dog_targets = getplayers();
    var_a4f0bce3 = dog_targets[0];
    for (i = 0; i < dog_targets.size; i++) {
        if (!isdefined(dog_targets[i].var_51adc1b0)) {
            dog_targets[i].var_51adc1b0 = 0;
            dog_targets[i].hunted_by = 0;
        }
        if (!zm_utility::is_player_valid(dog_targets[i])) {
            continue;
        }
        if (!zm_utility::is_player_valid(var_a4f0bce3)) {
            var_a4f0bce3 = dog_targets[i];
        }
        if (dog_targets[i].var_51adc1b0 < var_a4f0bce3.var_51adc1b0) {
            var_a4f0bce3 = dog_targets[i];
        }
    }
    if (!zm_utility::is_player_valid(var_a4f0bce3)) {
        return undefined;
    }
    return var_a4f0bce3;
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0xd5e6c635, Offset: 0x1018
// Size: 0xf4
function get_favorite_enemy() {
    dog_targets = getplayers();
    least_hunted = dog_targets[0];
    for (i = 0; i < dog_targets.size; i++) {
        if (!zm_utility::is_player_valid(dog_targets[i])) {
            continue;
        }
        if (!zm_utility::is_player_valid(least_hunted)) {
            least_hunted = dog_targets[i];
        }
        if (dog_targets[i].hunted_by < least_hunted.hunted_by) {
            least_hunted = dog_targets[i];
        }
    }
    if (!zm_utility::is_player_valid(least_hunted)) {
        return undefined;
    }
    return least_hunted;
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0x1677fe9, Offset: 0x1118
// Size: 0xca
function dog_health_increase() {
    players = getplayers();
    if (level.dog_round_count == 1) {
        level.dog_health = 800;
    } else if (level.dog_round_count == 2) {
        level.dog_health = 1200;
    } else if (level.dog_round_count == 3) {
        level.dog_health = 1600;
    } else if (level.dog_round_count == 4) {
        level.dog_health = 2000;
    }
    if (level.dog_health > 2000) {
        level.dog_health = 2000;
    }
}

// Namespace zombie_dog_util/ai_dog_util
// Params 1, eflags: 0x0
// Checksum 0xd6b40c45, Offset: 0x11f0
// Size: 0x16c
function dog_round_tracker(var_f2cf1965) {
    level.dog_round_count = 1;
    if (isdefined(level.var_e1c867db)) {
        level.next_dog_round = level.var_e1c867db;
    } else {
        level.next_dog_round = level.round_number + randomintrange(4, 7);
    }
    zm_round_spawning::function_5788a6e7("zombie_dog", level.next_dog_round, &dog_round_start, &dog_round_stop, &function_a4ff236, &waiting_for_next_dog_spawn, level.var_9490a685);
    if (!(isdefined(var_f2cf1965) && var_f2cf1965)) {
        zm_round_spawning::function_6f7eee39(&function_3ab5914f);
    }
    if (isdefined(level.var_1470c628) && level.var_1470c628) {
        zm_round_spawning::function_c9b9ab96("zombie_dog", level.next_dog_round + 1);
    }
    /#
        level thread function_f340c285();
    #/
}

/#

    // Namespace zombie_dog_util/ai_dog_util
    // Params 0, eflags: 0x0
    // Checksum 0xc3e33e49, Offset: 0x1368
    // Size: 0x62
    function function_f340c285() {
        while (true) {
            level waittill(#"between_round_over");
            if (getdvarint(#"force_dogs", 0) > 0) {
                level.next_dog_round = level.round_number;
            }
        }
    }

#/

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0x4dcb84ec, Offset: 0x13d8
// Size: 0xec
function dog_round_start() {
    level flag::set("dog_round");
    level flag::set("dog_clips");
    level thread zm_audio::sndmusicsystem_playstate("dog_start");
    level thread clientfield::set("dog_round_fog_bank", 1);
    dog_health_increase();
    players = getplayers();
    array::thread_all(players, &play_dog_round);
    wait 5;
    level thread function_a8fbbb3d();
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0x310951f0, Offset: 0x14d0
// Size: 0x1c
function function_a8fbbb3d() {
    zm_audio::sndannouncerplayvox("dogstart");
}

// Namespace zombie_dog_util/ai_dog_util
// Params 1, eflags: 0x0
// Checksum 0xf582bcdc, Offset: 0x14f8
// Size: 0x1c4
function dog_round_stop(var_1569ac92) {
    level flag::clear("dog_round");
    level flag::clear("dog_clips");
    level thread zm_audio::sndmusicsystem_playstate("dog_end");
    zm::increment_dog_round_stat("finished");
    level.dog_round_count += 1;
    wait 5;
    if (isdefined(level.var_d057a720)) {
        [[ level.var_d057a720 ]]();
    } else {
        level.next_dog_round = level.round_number + randomintrange(5, 7);
    }
    zm_round_spawning::function_5788a6e7("zombie_dog", level.next_dog_round, &dog_round_start, &dog_round_stop, &function_a4ff236, &waiting_for_next_dog_spawn, level.var_9490a685);
    /#
        getplayers()[0] iprintln("<dev string:x50>" + level.next_dog_round);
    #/
    level thread clientfield::set("dog_round_fog_bank", 0);
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0xf95c3d7d, Offset: 0x16c8
// Size: 0x84
function play_dog_round() {
    variation_count = 5;
    wait 4.5;
    players = getplayers();
    num = randomintrange(0, players.size);
    players[num] zm_audio::create_and_play_dialog("general", "dog_spawn");
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0xc6a2b91d, Offset: 0x1758
// Size: 0x430
function dog_init() {
    self.targetname = "zombie_dog";
    self.script_noteworthy = undefined;
    self.animname = "zombie_dog";
    self val::set(#"dog_spawn", "ignoreall", 1);
    self val::set(#"dog_spawn", "ignoreme", 1);
    self.allowdeath = 1;
    self.allowpain = 0;
    self.force_gib = 1;
    self.is_zombie = 1;
    self.gibbed = 0;
    self.head_gibbed = 0;
    self.default_goalheight = 40;
    self.ignore_inert = 1;
    self.holdfire = 1;
    self.grenadeawareness = 0;
    self.badplaceawareness = 0;
    self.ignoresuppression = 1;
    self.suppressionthreshold = 1;
    self.nododgemove = 1;
    self.dontshootwhilemoving = 1;
    self.pathenemylookahead = 0;
    self.badplaceawareness = 0;
    self.chatinitialized = 0;
    self.team = level.zombie_team;
    self.heroweapon_kill_power = 2;
    self allowpitchangle(1);
    self setpitchorient();
    self setavoidancemask("avoid none");
    self collidewithactors(1);
    health_multiplier = getdvarfloat(#"scr_dog_health_walk_multiplier", 4);
    health_multiplier *= isdefined(level.var_702ddaaa) ? level.var_702ddaaa : 1;
    self.maxhealth = int(level.dog_health * health_multiplier);
    self.health = int(level.dog_health * health_multiplier);
    self.freezegun_damage = 0;
    self.zombie_move_speed = "sprint";
    if (self.var_ea94c12a != "zombie_wolf") {
        self.a.nodeath = 1;
    }
    self zm_score::function_c4374c52();
    self thread dog_run_think();
    self thread dog_stalk_audio();
    self thread zombie_utility::round_spawn_failsafe();
    self ghost();
    self thread dog_death();
    level thread zm_spawner::zombie_death_event(self);
    self thread zm_audio::zmbaivox_notifyconvert();
    self zm_utility::disable_react();
    self cleargoalvolume();
    self.flame_damage_time = 0;
    self.thundergun_knockdown_func = &dog_thundergun_knockdown;
    /#
        self zm_spawner::zombie_history("<dev string:x61>" + self.origin);
    #/
    if (isdefined(level.var_9aca36e2)) {
        self [[ level.var_9aca36e2 ]]();
    }
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0x469f7bde, Offset: 0x1b90
// Size: 0x44e
function dog_death() {
    self waittill(#"death");
    if (zombie_utility::get_current_zombie_count() == 0 && level.zombie_total == 0) {
        level.var_ad1233d3 = self.origin;
        level notify(#"last_dog_down");
    }
    if (isplayer(self.attacker)) {
        event = "death";
        if (self.damageweapon.isballisticknife) {
            event = "ballistic_knife_death";
        }
        if (!(isdefined(self.deathpoints_already_given) && self.deathpoints_already_given)) {
            self.attacker zm_score::player_add_points(event, self.damagemod, self.damagelocation, self, self.team, self.damageweapon);
        }
        if (isdefined(level.hero_power_update)) {
            [[ level.hero_power_update ]](self.attacker, self, event);
        }
        if (randomintrange(0, 100) >= 80) {
            self.attacker zm_audio::create_and_play_dialog("kill", "hellhound");
        }
        self.attacker zm_stats::increment_client_stat("zdogs_killed");
        self.attacker zm_stats::increment_player_stat("zdogs_killed");
    }
    if (isdefined(self.attacker) && isai(self.attacker)) {
        self.attacker notify(#"killed", {#victim:self});
    }
    if (!isdefined(self)) {
        return;
    }
    self stoploopsound();
    if (self.var_ea94c12a != "zombie_wolf" && !(isdefined(self.a.nodeath) && self.a.nodeath)) {
        trace = groundtrace(self.origin + (0, 0, 10), self.origin - (0, 0, 30), 0, self);
        if (trace[#"fraction"] < 1) {
            pitch = acos(vectordot(trace[#"normal"], (0, 0, 1)));
            if (pitch > 10) {
                self.a.nodeath = 1;
            }
        }
    }
    if (self.var_ea94c12a != "zombie_wolf" && isdefined(self.a.nodeath)) {
        if (self.var_4d11bb60 !== 1) {
            level thread dog_explode_fx(self, self.origin);
            self ghost();
            self notsolid();
            wait 1;
        }
        if (isdefined(self)) {
            self delete();
        }
        return;
    }
    bhtnactionstartevent(self, "death");
    self notify(#"bhtn_action_notify", {#action:"death"});
}

// Namespace zombie_dog_util/ai_dog_util
// Params 2, eflags: 0x0
// Checksum 0xba9789b6, Offset: 0x1fe8
// Size: 0x54
function dog_explode_fx(dog, origin) {
    dog clientfield::set("dog_fx", 0);
    playsoundatposition(#"zmb_hellhound_explode", origin);
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0x1a78dd1d, Offset: 0x2048
// Size: 0xd4
function zombie_setup_attack_properties_dog() {
    /#
        self zm_spawner::zombie_history("<dev string:x85>");
    #/
    self thread dog_behind_audio();
    self val::reset(#"dog_spawn", "ignoreall");
    self val::reset(#"dog_spawn", "ignoreme");
    self.meleeattackdist = 64;
    self.disablearrivals = 1;
    self.disableexits = 1;
    if (isdefined(level.var_3565ea48)) {
        self [[ level.var_3565ea48 ]]();
    }
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0x11d8740d, Offset: 0x2128
// Size: 0x34
function stop_dog_sound_on_death() {
    self waittill(#"death");
    if (isdefined(self)) {
        self stopsounds();
    }
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0x24ebd290, Offset: 0x2168
// Size: 0x22c
function dog_behind_audio() {
    self thread stop_dog_sound_on_death();
    self endon(#"death");
    self waittill(#"dog_running", #"dog_combat");
    bhtnactionstartevent(self, "close");
    self notify(#"bhtn_action_notify", {#action:"close"});
    wait 3;
    while (true) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            dogangle = angleclamp180(vectortoangles(self.origin - players[i].origin)[1] - players[i].angles[1]);
            if (isalive(players[i]) && !isdefined(players[i].revivetrigger)) {
                if (abs(dogangle) > 90 && distance2d(self.origin, players[i].origin) > 100) {
                    bhtnactionstartevent(self, "close");
                    self notify(#"bhtn_action_notify", {#action:"close"});
                    wait 3;
                }
            }
        }
        wait 0.75;
    }
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0xe465ae4d, Offset: 0x23a0
// Size: 0x206
function dog_clip_monitor() {
    clips_on = 0;
    level.dog_clips = getentarray("dog_clips", "targetname");
    while (true) {
        for (i = 0; i < level.dog_clips.size; i++) {
            level.dog_clips[i] connectpaths();
        }
        level flag::wait_till("dog_clips");
        if (isdefined(level.var_c7e50b48) && level.var_c7e50b48 == 1) {
            return;
        }
        for (i = 0; i < level.dog_clips.size; i++) {
            level.dog_clips[i] disconnectpaths();
            util::wait_network_frame();
        }
        dog_is_alive = 1;
        while (dog_is_alive || level flag::get("dog_round")) {
            dog_is_alive = 0;
            dogs = getentarray("zombie_dog", "targetname");
            for (i = 0; i < dogs.size; i++) {
                if (isalive(dogs[i])) {
                    dog_is_alive = 1;
                }
            }
            wait 1;
        }
        level flag::clear("dog_clips");
        wait 1;
    }
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0xb729ffe4, Offset: 0x25b0
// Size: 0x120
function dog_run_think() {
    self endon(#"death");
    self waittill(#"visible");
    if (self.health > level.dog_health) {
        self.maxhealth = level.dog_health;
        self.health = level.dog_health;
    }
    if (self.aitype !== "spawner_zm_wolf") {
        self clientfield::set("dog_fx", 1);
        self playloopsound(#"zmb_hellhound_loop_fire");
    }
    while (true) {
        if (!zm_utility::is_player_valid(self.favoriteenemy)) {
            self.favoriteenemy = get_favorite_enemy();
        }
        if (isdefined(level.custom_dog_target_validity_check)) {
            self [[ level.custom_dog_target_validity_check ]]();
        }
        wait 0.2;
    }
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0x81cd12e9, Offset: 0x26d8
// Size: 0xa8
function dog_stalk_audio() {
    self endon(#"death");
    self endon(#"dog_running");
    self endon(#"dog_combat");
    while (true) {
        bhtnactionstartevent(self, "ambient");
        self notify(#"bhtn_action_notify", {#action:"ambient"});
        wait randomfloatrange(3, 6);
    }
}

// Namespace zombie_dog_util/ai_dog_util
// Params 2, eflags: 0x0
// Checksum 0xb575475a, Offset: 0x2788
// Size: 0x7c
function dog_thundergun_knockdown(player, gib) {
    self endon(#"death");
    damage = int(self.maxhealth * 0.5);
    self dodamage(damage, player.origin, player);
}

// Namespace zombie_dog_util/ai_dog_util
// Params 1, eflags: 0x0
// Checksum 0xbef24c6, Offset: 0x2810
// Size: 0x4a
function function_cd72b07e(var_e14d9cae) {
    var_13385fd5 = int(floor(var_e14d9cae / 25));
    return var_13385fd5;
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0xc03a60ab, Offset: 0x2868
// Size: 0x3c
function dog_round_spawn() {
    ai = function_ce9ad1e6();
    if (isdefined(ai)) {
        level.zombie_total--;
        return true;
    }
    return false;
}

// Namespace zombie_dog_util/ai_dog_util
// Params 2, eflags: 0x0
// Checksum 0xb4615d10, Offset: 0x28b0
// Size: 0x5f8
function function_ce9ad1e6(b_force_spawn = 0, var_b7959229) {
    if (!b_force_spawn && !function_8d2bf052()) {
        return undefined;
    }
    target = function_a37b6ca1();
    if (!isdefined(target)) {
        return undefined;
    }
    players = getplayers();
    if (isdefined(var_b7959229)) {
        s_spawn_loc = var_b7959229;
    } else if (isdefined(level.dog_spawn_func)) {
        s_spawn_loc = [[ level.dog_spawn_func ]]();
    } else if (level.zm_loc_types[#"dog_location"].size > 0) {
        zone_tag = target zm_zonemgr::get_player_zone();
        if (!isdefined(zone_tag)) {
            return undefined;
        }
        target_zone = level.zones[zone_tag];
        adj_zone_names = getarraykeys(target_zone.adjacent_zones);
        var_a8a02a7 = array(target_zone.name);
        foreach (zone_name in adj_zone_names) {
            if (target_zone.adjacent_zones[zone_name].is_connected) {
                if (!isdefined(var_a8a02a7)) {
                    var_a8a02a7 = [];
                } else if (!isarray(var_a8a02a7)) {
                    var_a8a02a7 = array(var_a8a02a7);
                }
                var_a8a02a7[var_a8a02a7.size] = level.zones[zone_name].name;
            }
        }
        var_ceb8329 = [];
        var_494a654b = [];
        foreach (loc in level.zm_loc_types[#"dog_location"]) {
            if (array::contains(var_a8a02a7, loc.zone_name)) {
                sqr_dist = distancesquared(loc.origin, target.origin);
                if (sqr_dist < 9000000) {
                    if (sqr_dist > 250000) {
                        if (!isdefined(var_ceb8329)) {
                            var_ceb8329 = [];
                        } else if (!isarray(var_ceb8329)) {
                            var_ceb8329 = array(var_ceb8329);
                        }
                        var_ceb8329[var_ceb8329.size] = loc;
                        continue;
                    }
                    if (sqr_dist > 10000) {
                        if (!isdefined(var_494a654b)) {
                            var_494a654b = [];
                        } else if (!isarray(var_494a654b)) {
                            var_494a654b = array(var_494a654b);
                        }
                        var_494a654b[var_494a654b.size] = loc;
                    }
                }
            }
        }
        if (var_ceb8329.size < 3) {
            foreach (loc in var_494a654b) {
                if (!isdefined(var_ceb8329)) {
                    var_ceb8329 = [];
                } else if (!isarray(var_ceb8329)) {
                    var_ceb8329 = array(var_ceb8329);
                }
                var_ceb8329[var_ceb8329.size] = loc;
            }
        }
        s_spawn_loc = array::random(var_ceb8329);
    }
    if (!isdefined(s_spawn_loc)) {
        return undefined;
    }
    ai = zombie_utility::spawn_zombie(level.dog_spawners[0]);
    if (isdefined(ai)) {
        ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
        ai thread zombie_utility::round_spawn_failsafe();
        ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
        if (isdefined(level.dog_on_spawned)) {
            ai thread [[ level.dog_on_spawned ]](s_spawn_loc);
        } else {
            s_spawn_loc thread dog_spawn_fx(ai, s_spawn_loc);
        }
        ai.favoriteenemy = target;
        ai.favoriteenemy.hunted_by++;
        ai.favoriteenemy.var_51adc1b0++;
    }
    return ai;
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0x1188dbed, Offset: 0x2eb0
// Size: 0x96
function function_8d2bf052() {
    var_6918547c = function_c57652b6();
    var_6122e233 = function_bdf261f5();
    if (!(isdefined(level.var_1e301b4e) && level.var_1e301b4e) && isdefined(level.var_c643d497) && level.var_c643d497 || var_6918547c >= var_6122e233) {
        return false;
    }
    return true;
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0xf429c10, Offset: 0x2f50
// Size: 0x8a
function function_bdf261f5() {
    switch (level.players.size) {
    case 1:
        return 3;
    case 2:
        return 5;
    case 3:
        return 7;
    case 4:
        return 10;
    }
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0x3030cf1, Offset: 0x2fe8
// Size: 0xb4
function function_c57652b6() {
    var_81bcaf70 = getaiarchetypearray("zombie_dog");
    var_6918547c = var_81bcaf70.size;
    foreach (ai_dog in var_81bcaf70) {
        if (!isalive(ai_dog)) {
            var_6918547c--;
        }
    }
    return var_6918547c;
}

