#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zombie_dog_util;

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x6
// Checksum 0x22ca5d88, Offset: 0x288
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"zombie_dog_util", &function_70a657d8, undefined, undefined, #"aat");
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x5 linked
// Checksum 0x9d483da7, Offset: 0x2d8
// Size: 0x1ac
function private function_70a657d8() {
    clientfield::register("actor", "dog_fx", 1, 1, "int");
    clientfield::register("world", "dog_round_fog_bank", 1, 1, "int");
    level.var_57c1626e = 1;
    level.var_a3f67fc2 = 0;
    level.dog_round_count = 1;
    level.dog_spawners = [];
    level flag::init("dog_clips");
    zombie_utility::set_zombie_var(#"dog_fire_trail_percent", 50);
    dog_spawner_init();
    level thread dog_clip_monitor();
    zm_round_spawning::register_archetype(#"zombie_dog", &function_b168b424, &dog_round_spawn, &function_62db7b1c, 25);
    zm_score::function_e5d6e6dd(#"zombie_dog", 60);
    callback::function_74872db6(&function_81f9083e);
}

// Namespace zombie_dog_util/ai_dog_util
// Params 1, eflags: 0x1 linked
// Checksum 0xc3ec6845, Offset: 0x490
// Size: 0xb8
function dog_enable_rounds(b_ignore_cleanup = 1) {
    if (!zm_custom::function_901b751c(#"zmspecialroundsenabled") || is_true(level.var_15747fb1)) {
        return;
    }
    level.var_a3f67fc2 = 1;
    level.var_dc50acfa = b_ignore_cleanup;
    if (!isdefined(level.dog_round_track_override)) {
        level.dog_round_track_override = &dog_round_tracker;
    }
    level thread [[ level.dog_round_track_override ]]();
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x1 linked
// Checksum 0x15bbfc79, Offset: 0x550
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
// Params 0, eflags: 0x1 linked
// Checksum 0x6e7e2383, Offset: 0x708
// Size: 0x5e
function function_dd162858() {
    a_e_players = getplayers();
    if (level.dog_round_count < 3) {
        n_max = a_e_players.size * 6;
    } else {
        n_max = a_e_players.size * 8;
    }
    return n_max;
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x1 linked
// Checksum 0x93770d88, Offset: 0x770
// Size: 0x62
function function_20aadb5e() {
    a_e_players = getplayers();
    n_max = zm_round_logic::get_zombie_count_for_round(level.round_number, a_e_players.size);
    return int(n_max * 0.6);
}

// Namespace zombie_dog_util/ai_dog_util
// Params 2, eflags: 0x1 linked
// Checksum 0xb80e848, Offset: 0x7e0
// Size: 0xf4
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
// Params 0, eflags: 0x1 linked
// Checksum 0xc8ba272b, Offset: 0x8e0
// Size: 0xc
function function_d544de30() {
    wait 0.25;
}

// Namespace zombie_dog_util/ai_dog_util
// Params 1, eflags: 0x1 linked
// Checksum 0xc9c3f6ec, Offset: 0x8f8
// Size: 0x64
function function_ed67c5e7(*s_params) {
    if (isdefined(self) && !zm_utility::is_standard()) {
        level thread zm_powerups::specific_powerup_drop("full_ammo", self.origin, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
    }
}

// Namespace zombie_dog_util/ai_dog_util
// Params 2, eflags: 0x1 linked
// Checksum 0xcffc0c80, Offset: 0x968
// Size: 0x2d8
function dog_spawn_fx(ai, ent) {
    ai endon(#"death");
    ai val::set(#"dog_spawn", "takedamage", 0);
    ai setfreecameralockonallowed(0);
    playsoundatposition(#"zmb_hellhound_prespawn", ent.origin);
    wait 1.5;
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
    assert(isdefined(ai), "<dev string:x38>");
    assert(isalive(ai), "<dev string:x4e>");
    ai zombie_setup_attack_properties_dog();
    ai val::reset(#"dog_spawn", "takedamage");
    wait 0.1;
    ai show();
    ai setfreecameralockonallowed(1);
    ai val::reset(#"dog_spawn", "ignoreme");
    ai notify(#"visible");
    ai.completed_emerging_into_playable_area = 1;
    ai notify(#"completed_emerging_into_playable_area");
}

// Namespace zombie_dog_util/ai_dog_util
// Params 1, eflags: 0x0
// Checksum 0xbe166476, Offset: 0xc48
// Size: 0xfa
function dog_spawn_factory_logic(var_8f952661) {
    dog_locs = array::randomize(level.zm_loc_types[#"dog_location"]);
    for (i = 0; i < dog_locs.size; i++) {
        if (isdefined(level.old_dog_spawn) && level.old_dog_spawn == dog_locs[i]) {
            continue;
        }
        dist_squared = distancesquared(dog_locs[i].origin, var_8f952661.origin);
        if (dist_squared > 160000 && dist_squared < 1000000) {
            level.old_dog_spawn = dog_locs[i];
            return dog_locs[i];
        }
    }
    return dog_locs[0];
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x1 linked
// Checksum 0x22a570e2, Offset: 0xd50
// Size: 0xa2
function function_81f9083e() {
    players = getplayers();
    foreach (player in players) {
        player.var_230becc2 = 0;
        player.hunted_by = 0;
    }
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x1 linked
// Checksum 0x7e57c20c, Offset: 0xe00
// Size: 0x10c
function function_a5abd591() {
    dog_targets = getplayers();
    var_d6c885ef = dog_targets[0];
    for (i = 0; i < dog_targets.size; i++) {
        if (!isdefined(dog_targets[i].var_230becc2)) {
            dog_targets[i].var_230becc2 = 0;
            dog_targets[i].hunted_by = 0;
        }
        if (!zm_utility::is_player_valid(dog_targets[i])) {
            continue;
        }
        if (!zm_utility::is_player_valid(var_d6c885ef)) {
            var_d6c885ef = dog_targets[i];
        }
        if (dog_targets[i].var_230becc2 < var_d6c885ef.var_230becc2) {
            var_d6c885ef = dog_targets[i];
        }
    }
    if (!zm_utility::is_player_valid(var_d6c885ef)) {
        return undefined;
    }
    return var_d6c885ef;
}

// Namespace zombie_dog_util/ai_dog_util
// Params 1, eflags: 0x1 linked
// Checksum 0xa56fe135, Offset: 0xf18
// Size: 0x1dc
function is_target_valid(target) {
    if (!isdefined(target)) {
        return 0;
    }
    if (!isalive(target)) {
        return 0;
    }
    if (self.team != #"allies") {
        if (!isplayer(target)) {
            return 0;
        }
        if (is_true(target.is_zombie)) {
            return 0;
        }
    }
    if (isplayer(target) && target.sessionstate == "spectator") {
        return 0;
    }
    if (isplayer(target) && target.sessionstate == "intermission") {
        return 0;
    }
    if (is_true(self.intermission)) {
        return 0;
    }
    if (is_true(target.ignoreme)) {
        return 0;
    }
    if (target isnotarget()) {
        return 0;
    }
    if (self.team == target.team) {
        return 0;
    }
    if (isplayer(target) && isdefined(level.var_6f6cc58)) {
        if (!self [[ level.var_6f6cc58 ]](target)) {
            return 0;
        }
    }
    if (isplayer(target) && isdefined(level.is_player_valid_override)) {
        return [[ level.is_player_valid_override ]](target);
    }
    return 1;
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x1 linked
// Checksum 0x7af16973, Offset: 0x1100
// Size: 0x1b4
function get_favorite_enemy() {
    dog_targets = [];
    if (self.team == #"allies") {
        dog_targets = getaiteamarray(level.zombie_team);
    } else {
        dog_targets = getplayers();
    }
    least_hunted = dog_targets[0];
    closest_target_dist_squared = undefined;
    for (i = 0; i < dog_targets.size; i++) {
        if (!isdefined(dog_targets[i].hunted_by)) {
            dog_targets[i].hunted_by = 0;
        }
        if (!is_target_valid(dog_targets[i])) {
            continue;
        }
        if (!is_target_valid(least_hunted)) {
            least_hunted = dog_targets[i];
        }
        dist_squared = distancesquared(self.origin, dog_targets[i].origin);
        if (dog_targets[i].hunted_by <= least_hunted.hunted_by && (!isdefined(closest_target_dist_squared) || dist_squared < closest_target_dist_squared)) {
            least_hunted = dog_targets[i];
            closest_target_dist_squared = dist_squared;
        }
    }
    if (!is_target_valid(least_hunted)) {
        return undefined;
    }
    least_hunted.hunted_by += 1;
    return least_hunted;
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x1 linked
// Checksum 0x9144158b, Offset: 0x12c0
// Size: 0xe0
function dog_health_increase() {
    players = getplayers();
    switch (level.dog_round_count) {
    case 1:
        level.dog_health = 300;
        break;
    case 2:
        level.dog_health = 700;
        break;
    case 3:
        level.dog_health = 1100;
        break;
    case 4:
        level.dog_health = 1500;
        break;
    }
    if (level.dog_health > 2000) {
        level.dog_health = 2000;
    }
}

// Namespace zombie_dog_util/ai_dog_util
// Params 1, eflags: 0x1 linked
// Checksum 0x9ae5cc1d, Offset: 0x13a8
// Size: 0x184
function dog_round_tracker(var_634c65f0) {
    level.dog_round_count = 1;
    if (isdefined(level.var_973488a5)) {
        level.next_dog_round = level.var_973488a5;
    } else {
        level.next_dog_round = level.round_number + randomintrange(4, 7);
    }
    zm_round_spawning::function_b4a8f95a(#"zombie_dog", level.next_dog_round, &dog_round_start, &dog_round_stop, &function_dd162858, &waiting_for_next_dog_spawn, level.var_dc50acfa);
    if (!is_true(var_634c65f0)) {
        zm_round_spawning::function_df803678(&function_ed67c5e7);
    }
    if (is_true(level.var_3ef0606f)) {
        zm_round_spawning::function_376e51ef(#"zombie_dog", level.next_dog_round + 1);
    }
    /#
        level thread function_de0a6ae4();
    #/
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0xd636b87d, Offset: 0x1538
// Size: 0x16c
function function_246a0760() {
    level endon(#"game_ended");
    level.dog_round_count = 1;
    level.next_dog_round = 6;
    zm_round_spawning::function_b4a8f95a(#"zombie_dog", level.next_dog_round, &dog_round_start, &function_5f1ef789, &function_20aadb5e, &function_d544de30, level.var_dc50acfa);
    zm_utility::function_fdb0368(7);
    level.dog_round_count = 3;
    level.next_dog_round = 24;
    zm_round_spawning::function_b4a8f95a(#"zombie_dog", level.next_dog_round, &dog_round_start, &function_5f1ef789, &function_20aadb5e, &function_d544de30, level.var_dc50acfa);
    /#
        level thread function_de0a6ae4();
    #/
}

/#

    // Namespace zombie_dog_util/ai_dog_util
    // Params 0, eflags: 0x0
    // Checksum 0x9ce0fc3, Offset: 0x16b0
    // Size: 0x60
    function function_de0a6ae4() {
        while (true) {
            level waittill(#"between_round_over");
            if (getdvarint(#"force_dogs", 0) > 0) {
                level.next_dog_round = level.round_number;
            }
        }
    }

#/

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x1 linked
// Checksum 0x6c4569f7, Offset: 0x1718
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
    level thread function_c5ab118d();
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x1 linked
// Checksum 0x3023db14, Offset: 0x1810
// Size: 0x24
function function_c5ab118d() {
    zm_audio::sndannouncerplayvox(#"dogstart");
}

// Namespace zombie_dog_util/ai_dog_util
// Params 1, eflags: 0x1 linked
// Checksum 0x9b4f3b8c, Offset: 0x1840
// Size: 0x1cc
function dog_round_stop(*var_d25bbdd5) {
    level flag::clear("dog_round");
    level flag::clear("dog_clips");
    level thread zm_audio::sndmusicsystem_playstate("dog_end");
    zm::increment_dog_round_stat("finished");
    level.dog_round_count += 1;
    wait 5;
    if (isdefined(level.var_539f36cd)) {
        [[ level.var_539f36cd ]]();
    } else {
        level.next_dog_round = level.round_number + randomintrange(5, 7);
    }
    zm_round_spawning::function_b4a8f95a(#"zombie_dog", level.next_dog_round, &dog_round_start, &dog_round_stop, &function_dd162858, &waiting_for_next_dog_spawn, level.var_dc50acfa);
    /#
        getplayers()[0] iprintln("<dev string:x5e>" + level.next_dog_round);
    #/
    level thread clientfield::set("dog_round_fog_bank", 0);
}

// Namespace zombie_dog_util/ai_dog_util
// Params 1, eflags: 0x1 linked
// Checksum 0xc1526607, Offset: 0x1a18
// Size: 0xac
function function_5f1ef789(*var_d25bbdd5) {
    level flag::clear("dog_round");
    level flag::clear("dog_clips");
    level thread zm_audio::sndmusicsystem_playstate("dog_end");
    zm::increment_dog_round_stat("finished");
    wait 5;
    level thread clientfield::set("dog_round_fog_bank", 0);
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x1 linked
// Checksum 0x38edaaf7, Offset: 0x1ad0
// Size: 0x8c
function play_dog_round() {
    variation_count = 5;
    wait 4.5;
    players = getplayers();
    num = randomintrange(0, players.size);
    players[num] zm_audio::create_and_play_dialog(#"general", #"dog_spawn");
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x5 linked
// Checksum 0xf4db17a1, Offset: 0x1b68
// Size: 0x56
function private function_7d5fa17e() {
    return self.var_9fde8624 != #"zombie_wolf" && self.var_9fde8624 != #"hash_28e36e7b7d5421f" && self.var_9fde8624 != #"hash_2a5479b83161cb35";
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x1 linked
// Checksum 0x42ce26f3, Offset: 0x1bc8
// Size: 0x400
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
    health_multiplier *= isdefined(level.var_570d178a) ? level.var_570d178a : 1;
    self.maxhealth = int(level.dog_health * health_multiplier);
    self.health = int(level.dog_health * health_multiplier);
    self.freezegun_damage = 0;
    self.zombie_move_speed = "sprint";
    if (self function_7d5fa17e()) {
        self.a.nodeath = 1;
    }
    self zm_score::function_82732ced();
    self thread dog_run_think();
    self thread zombie_utility::round_spawn_failsafe();
    self ghost();
    self thread dog_death();
    level thread zm_spawner::zombie_death_event(self);
    self zm_utility::disable_react();
    self cleargoalvolume();
    self.flame_damage_time = 0;
    self.thundergun_knockdown_func = &dog_thundergun_knockdown;
    /#
        self zm_spawner::zombie_history("<dev string:x72>" + self.origin);
    #/
    if (isdefined(level.var_9c55db3)) {
        self [[ level.var_9c55db3 ]]();
    }
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x1 linked
// Checksum 0x420022ce, Offset: 0x1fd0
// Size: 0x3f2
function dog_death() {
    self waittill(#"death");
    if (zombie_utility::get_current_zombie_count() == 0 && level.zombie_total == 0) {
        level.var_eb06f292 = self.origin;
        level notify(#"last_dog_down");
    }
    if (isplayer(self.attacker)) {
        event = "death";
        if (!is_true(self.deathpoints_already_given)) {
            self.attacker zm_score::player_add_points(event, self.damagemod, self.damagelocation, self, self.team, self.damageweapon);
        }
        if (isdefined(level.hero_power_update)) {
            [[ level.hero_power_update ]](self.attacker, self, event);
        }
        if (randomintrange(0, 100) >= 80) {
            self.attacker zm_audio::create_and_play_dialog(#"kill", #"hellhound");
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
    self playsound(#"");
    if (self function_7d5fa17e() && !is_true(self.a.nodeath)) {
        trace = groundtrace(self.origin + (0, 0, 10), self.origin - (0, 0, 30), 0, self);
        if (trace[#"fraction"] < 1) {
            pitch = acos(vectordot(trace[#"normal"], (0, 0, 1)));
            if (pitch > 10) {
                self.a.nodeath = 1;
            }
        }
    }
    if (self.var_9fde8624 != #"zombie_wolf" && isdefined(self.a.nodeath)) {
        if (self.var_c39323b5 !== 1) {
            level thread dog_explode_fx(self, self.origin);
            self ghost();
            self notsolid();
            wait 1;
        }
    }
}

// Namespace zombie_dog_util/ai_dog_util
// Params 2, eflags: 0x1 linked
// Checksum 0x1a3161a5, Offset: 0x23d0
// Size: 0x34
function dog_explode_fx(dog, *origin) {
    origin clientfield::set("dog_fx", 0);
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x1 linked
// Checksum 0x64b2ace1, Offset: 0x2410
// Size: 0xbc
function zombie_setup_attack_properties_dog() {
    /#
        self zm_spawner::zombie_history("<dev string:x99>");
    #/
    self val::reset(#"dog_spawn", "ignoreall");
    self val::reset(#"dog_spawn", "ignoreme");
    self.meleeattackdist = 64;
    self.disablearrivals = 1;
    self.disableexits = 1;
    if (isdefined(level.var_a5d11757)) {
        self [[ level.var_a5d11757 ]]();
    }
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x1 linked
// Checksum 0x39982e45, Offset: 0x24d8
// Size: 0x1f6
function dog_clip_monitor() {
    clips_on = 0;
    level.dog_clips = getentarray("dog_clips", "targetname");
    while (true) {
        for (i = 0; i < level.dog_clips.size; i++) {
            level.dog_clips[i] connectpaths();
        }
        level flag::wait_till("dog_clips");
        if (isdefined(level.var_53f3cbde) && level.var_53f3cbde == 1) {
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
// Params 0, eflags: 0x1 linked
// Checksum 0xd1d22f6e, Offset: 0x26d8
// Size: 0x100
function dog_run_think() {
    self endon(#"death");
    self waittill(#"visible");
    if (self.health > level.dog_health) {
        self.maxhealth = level.dog_health;
        self.health = level.dog_health;
    }
    if (self.aitype !== "spawner_zm_wolf") {
        self clientfield::set("dog_fx", 1);
    }
    while (true) {
        if (!is_target_valid(self.favoriteenemy)) {
            self.favoriteenemy = get_favorite_enemy();
        }
        if (isdefined(level.custom_dog_target_validity_check)) {
            self [[ level.custom_dog_target_validity_check ]]();
        }
        wait 0.2;
    }
}

// Namespace zombie_dog_util/ai_dog_util
// Params 2, eflags: 0x1 linked
// Checksum 0xf25c9065, Offset: 0x27e0
// Size: 0x7c
function dog_thundergun_knockdown(player, *gib) {
    self endon(#"death");
    damage = int(self.maxhealth * 0.5);
    self dodamage(damage, gib.origin, gib);
}

// Namespace zombie_dog_util/ai_dog_util
// Params 1, eflags: 0x1 linked
// Checksum 0x898ee555, Offset: 0x2868
// Size: 0xe2
function function_b168b424(var_dbce0c44) {
    var_8cf00d40 = int(floor(var_dbce0c44 / 25));
    if (level.round_number < 20) {
        var_23c888e1 = 0.02;
    } else if (level.round_number < 30) {
        var_23c888e1 = 0.03;
    } else {
        var_23c888e1 = 0.04;
    }
    return min(var_8cf00d40, int(ceil(level.zombie_total * var_23c888e1)));
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x1 linked
// Checksum 0x1d1a0ea7, Offset: 0x2958
// Size: 0x38
function dog_round_spawn() {
    ai = function_62db7b1c();
    if (isdefined(ai)) {
        level.zombie_total--;
        return true;
    }
    return false;
}

// Namespace zombie_dog_util/ai_dog_util
// Params 2, eflags: 0x1 linked
// Checksum 0xfd0838d7, Offset: 0x2998
// Size: 0x9ec
function function_62db7b1c(b_force_spawn = 0, var_eb3a8721) {
    if (!b_force_spawn && !function_c1faf4d5()) {
        return undefined;
    }
    e_target = function_a5abd591();
    if (!isdefined(e_target)) {
        return undefined;
    }
    players = getplayers();
    if (isdefined(var_eb3a8721)) {
        s_spawn_loc = var_eb3a8721;
    } else if (isdefined(level.dog_spawn_func)) {
        s_spawn_loc = [[ level.dog_spawn_func ]]();
    } else if (level.zm_loc_types[#"dog_location"].size > 0) {
        var_5f3b05e8 = e_target zm_zonemgr::get_player_zone();
        if (!isdefined(var_5f3b05e8)) {
            return undefined;
        }
        var_24f5d9f8 = [];
        if (!isdefined(var_24f5d9f8)) {
            var_24f5d9f8 = [];
        } else if (!isarray(var_24f5d9f8)) {
            var_24f5d9f8 = array(var_24f5d9f8);
        }
        if (!isinarray(var_24f5d9f8, var_5f3b05e8)) {
            var_24f5d9f8[var_24f5d9f8.size] = var_5f3b05e8;
        }
        var_4cb112e = level.zones[var_5f3b05e8];
        adj_zone_names = getarraykeys(var_4cb112e.adjacent_zones);
        to_remove = [];
        foreach (str_zone in adj_zone_names) {
            if (var_4cb112e.adjacent_zones[str_zone].is_connected) {
                if (!isdefined(var_24f5d9f8)) {
                    var_24f5d9f8 = [];
                } else if (!isarray(var_24f5d9f8)) {
                    var_24f5d9f8 = array(var_24f5d9f8);
                }
                if (!isinarray(var_24f5d9f8, level.zones[str_zone].name)) {
                    var_24f5d9f8[var_24f5d9f8.size] = level.zones[str_zone].name;
                }
                continue;
            }
            if (!isdefined(to_remove)) {
                to_remove = [];
            } else if (!isarray(to_remove)) {
                to_remove = array(to_remove);
            }
            if (!isinarray(to_remove, level.zones[str_zone].name)) {
                to_remove[to_remove.size] = level.zones[str_zone].name;
            }
        }
        foreach (remove in to_remove) {
            arrayremovevalue(adj_zone_names, remove);
        }
        foreach (str_zone in adj_zone_names) {
            s_zone = level.zones[str_zone];
            a_str_adj_zone = getarraykeys(s_zone.adjacent_zones);
            foreach (str_adj_zone in a_str_adj_zone) {
                if (s_zone.adjacent_zones[str_adj_zone].is_connected) {
                    if (!isdefined(var_24f5d9f8)) {
                        var_24f5d9f8 = [];
                    } else if (!isarray(var_24f5d9f8)) {
                        var_24f5d9f8 = array(var_24f5d9f8);
                    }
                    if (!isinarray(var_24f5d9f8, level.zones[str_adj_zone].name)) {
                        var_24f5d9f8[var_24f5d9f8.size] = level.zones[str_adj_zone].name;
                    }
                }
            }
        }
        var_5adfb389 = struct::get_array("dog_location", "script_noteworthy");
        var_5adfb389 = arraysortclosest(var_5adfb389, e_target.origin, undefined, 1024);
        var_e99dec8e = [];
        var_22b984bd = [];
        foreach (v_loc in var_5adfb389) {
            if (isinarray(var_24f5d9f8, v_loc.zone_name)) {
                n_sqr_dist = distancesquared(v_loc.origin, e_target.origin);
                if (173056 < n_sqr_dist && n_sqr_dist < 376996) {
                    if (!isdefined(var_e99dec8e)) {
                        var_e99dec8e = [];
                    } else if (!isarray(var_e99dec8e)) {
                        var_e99dec8e = array(var_e99dec8e);
                    }
                    var_e99dec8e[var_e99dec8e.size] = v_loc;
                    continue;
                }
                if (n_sqr_dist > 376996) {
                    if (!isdefined(var_22b984bd)) {
                        var_22b984bd = [];
                    } else if (!isarray(var_22b984bd)) {
                        var_22b984bd = array(var_22b984bd);
                    }
                    var_22b984bd[var_22b984bd.size] = v_loc;
                }
            }
        }
        if (var_e99dec8e.size < 6) {
            var_22b984bd = arraysort(var_22b984bd, e_target.origin, 1);
            n_spawns_needed = 6 - var_e99dec8e.size;
            for (i = 0; i < n_spawns_needed; i++) {
                if (!isdefined(var_e99dec8e)) {
                    var_e99dec8e = [];
                } else if (!isarray(var_e99dec8e)) {
                    var_e99dec8e = array(var_e99dec8e);
                }
                var_e99dec8e[var_e99dec8e.size] = var_22b984bd[i];
            }
        }
        if (var_e99dec8e.size < 1 && level.zm_loc_types[#"dog_location"].size > 0) {
            var_e99dec8e = arraycopy(level.zm_loc_types[#"dog_location"]);
        }
        s_spawn_loc = array::random(var_e99dec8e);
    }
    if (!isdefined(s_spawn_loc)) {
        return undefined;
    }
    ai = zombie_utility::spawn_zombie(level.dog_spawners[0]);
    if (isdefined(ai)) {
        ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
        ai thread zombie_utility::round_spawn_failsafe();
        ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
        if (isdefined(level.var_6189feaf)) {
            ai thread [[ level.var_6189feaf ]](s_spawn_loc);
        } else {
            s_spawn_loc thread dog_spawn_fx(ai, s_spawn_loc);
        }
        s_spawn_loc.var_d51f4e2d = gettime();
        ai.favoriteenemy = e_target;
        ai.favoriteenemy.hunted_by++;
        ai.favoriteenemy.var_230becc2++;
    }
    return ai;
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x1 linked
// Checksum 0x43ebc5b7, Offset: 0x3390
// Size: 0x94
function function_c1faf4d5() {
    var_d881b102 = function_bb101706();
    var_672d3c4 = function_71e3c90d();
    if (!is_true(level.var_2b94ce72) && (is_true(level.var_15747fb1) || var_d881b102 >= var_672d3c4)) {
        return false;
    }
    return true;
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x1 linked
// Checksum 0xcf75fcbc, Offset: 0x3430
// Size: 0x112
function function_71e3c90d() {
    switch (level.players.size) {
    case 1:
        if (zm_utility::is_trials()) {
            return 6;
        }
        return 3;
    case 2:
        if (zm_utility::is_trials()) {
            return 10;
        }
        return 5;
    case 3:
        if (zm_utility::is_trials()) {
            return 14;
        }
        return 7;
    case 4:
        if (zm_utility::is_trials()) {
            return 20;
        }
        return 10;
    default:
        if (zm_utility::is_trials()) {
            return 28;
        }
        return 14;
    }
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x1 linked
// Checksum 0x6af0ce03, Offset: 0x3550
// Size: 0xca
function function_bb101706() {
    var_cbfe0149 = getaiarchetypearray(#"zombie_dog");
    var_d881b102 = var_cbfe0149.size;
    foreach (ai_dog in var_cbfe0149) {
        if (!isalive(ai_dog)) {
            var_d881b102--;
        }
    }
    return var_d881b102;
}

