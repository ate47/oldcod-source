#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\archetype_tiger;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;

#namespace zm_ai_tiger;

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 0, eflags: 0x2
// Checksum 0x575ea98e, Offset: 0x170
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_ai_tiger", &__init__, &__main__, undefined);
}

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 0, eflags: 0x0
// Checksum 0xe1d4c3f8, Offset: 0x1c0
// Size: 0x19c
function __init__() {
    clientfield::register("toplayer", "" + #"hash_14c746e550d9f3ca", 1, 2, "counter");
    function_cea6d78a();
    zm_player::register_player_damage_callback(&function_cd31d5b2);
    spawner::add_archetype_spawn_function("tiger", &tiger_init);
    level thread aat::register_immunity("zm_aat_frostbite", "tiger", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_kill_o_watt", "tiger", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_plasmatic_burst", "tiger", 1, 1, 1);
    /#
        spawner::add_archetype_spawn_function("<dev string:x30>", &zombie_utility::updateanimationrate);
    #/
    /#
        if (!zm_score::function_7636d211("<dev string:x30>")) {
            zm_score::function_c723805e("<dev string:x30>", 60);
        }
    #/
}

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x368
// Size: 0x4
function __main__() {
    
}

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 0, eflags: 0x4
// Checksum 0x4639ae17, Offset: 0x378
// Size: 0x74
function private function_cea6d78a() {
    assert(isscriptfunctionptr(&function_cacaf49e));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zmtigertargetservice", &function_cacaf49e, 1);
}

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 1, eflags: 0x4
// Checksum 0x4bbc9f9e, Offset: 0x3f8
// Size: 0x53a
function private function_cacaf49e(entity) {
    if (isdefined(entity.ignoreall) && entity.ignoreall) {
        return 0;
    }
    if (isdefined(entity.disabletargetservice) && entity.disabletargetservice) {
        return 0;
    }
    if (entity.team == #"allies") {
        entity function_40502936();
        if (isdefined(entity.favoriteenemy)) {
            return entity zm_utility::function_23a24406(entity.favoriteenemy.origin, 128);
        }
        return 0;
    }
    zombie_poi = entity zm_utility::get_zombie_point_of_interest(entity.origin);
    entity zombie_utility::run_ignore_player_handler();
    entity.favoriteenemy = entity.var_532a149b;
    if (isdefined(zombie_poi) && isdefined(zombie_poi[1])) {
        goalpos = zombie_poi[0];
        return entity zm_utility::function_23a24406(goalpos, 128);
    }
    if (!isdefined(entity.favoriteenemy) || zm_behavior::zombieshouldmoveawaycondition(entity)) {
        zone = zm_utility::get_current_zone();
        if (isdefined(zone)) {
            wait_locations = level.zones[zone].a_loc_types[#"wait_location"];
            if (isdefined(wait_locations) && wait_locations.size > 0) {
                return entity zm_utility::function_23a24406(wait_locations[0].origin, 128);
            }
        }
        entity setgoal(entity.origin);
        return 0;
    }
    if (!(isdefined(entity.hasseenfavoriteenemy) && entity.hasseenfavoriteenemy)) {
        if (isdefined(entity.favoriteenemy) && entity tigerbehavior::need_to_run()) {
            entity.hasseenfavoriteenemy = 1;
            entity setblackboardattribute("_seen_enemy", "has_seen");
        }
    }
    /#
        if (entity.favoriteenemy isnotarget()) {
            entity setgoal(entity.origin);
            return 0;
        }
    #/
    var_ab621d86 = 0;
    if (distancesquared(entity.origin, entity.favoriteenemy.origin) >= 400 * 400) {
        var_ab621d86 = 1;
    }
    if (var_ab621d86 && entity function_34e8ccf6() && !(isdefined(entity.var_9a091f8a) && entity.var_9a091f8a) && isdefined(entity.hasseenfavoriteenemy) && entity.hasseenfavoriteenemy) {
        if (!isdefined(entity.var_f45f364b)) {
            entity.var_f45f364b = 0;
            if (math::cointoss()) {
                entity.var_f45f364b = 2;
            }
        }
        entity function_a599aa72();
    }
    if (isdefined(entity.var_9a091f8a) && entity.var_9a091f8a && !(isdefined(entity.var_7d2830bc) && entity.var_7d2830bc)) {
        self function_3c8dce03(entity.var_f7ffba7b);
        if (distancesquared(entity.origin, entity.var_f7ffba7b) <= 64 * 64) {
            entity.var_7d2830bc = 1;
        }
        return 1;
    }
    goalent = entity.favoriteenemy;
    if (isplayer(goalent)) {
        goalent = zm_ai_utility::function_93d978d(entity, entity.favoriteenemy);
    }
    return entity zm_utility::function_23a24406(goalent.origin, 128);
}

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 0, eflags: 0x4
// Checksum 0x4a5148cd, Offset: 0x940
// Size: 0x224
function private function_a599aa72() {
    var_85d9e229 = 45;
    if (isdefined(self.var_f45f364b)) {
        if (self.var_f45f364b == 0) {
            var_85d9e229 = -45;
        } else if (self.var_f45f364b == 1) {
            var_85d9e229 = -22.5;
        } else if (self.var_f45f364b == 3) {
            var_85d9e229 = 22.5;
        }
        self.var_f45f364b++;
        if (self.var_f45f364b > 3) {
            self.var_f45f364b = 0;
        }
    }
    enemy = self.favoriteenemy;
    var_c72cdeba = vectortoangles(self.origin - self.favoriteenemy.origin)[1];
    var_d84522df = absangleclamp360(var_c72cdeba + var_85d9e229);
    var_8912a0e4 = anglestoforward((0, var_d84522df, 0));
    var_1452d98c = enemy.origin + var_8912a0e4 * 400;
    var_88bceffd = getclosestpointonnavmesh(var_1452d98c, 128, self getpathfindingradius());
    if (isdefined(var_88bceffd)) {
        path_success = self findpath(self.origin, var_88bceffd, 1, 0);
        if (path_success) {
            self.var_f7ffba7b = var_88bceffd;
            self.var_9a091f8a = 1;
            /#
                recordsphere(self.var_f7ffba7b, 3, (0, 1, 0), "<dev string:x36>");
            #/
            return true;
        }
    }
    return false;
}

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 0, eflags: 0x4
// Checksum 0x69f83162, Offset: 0xb70
// Size: 0x1a
function private function_34e8ccf6() {
    if (gettime() > self.var_ff860bd8) {
        return true;
    }
    return false;
}

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 0, eflags: 0x0
// Checksum 0x7d3c108f, Offset: 0xb98
// Size: 0x1aa
function function_40502936() {
    zombies = getaispeciesarray(level.zombie_team, "all");
    zombie_enemy = undefined;
    closest_dist = undefined;
    foreach (zombie in zombies) {
        if (isalive(zombie) && isdefined(zombie.completed_emerging_into_playable_area) && zombie.completed_emerging_into_playable_area && !zm_utility::is_magic_bullet_shield_enabled(zombie) && (isdefined(zombie.canbetargetedbyturnedzombies) && zombie.canbetargetedbyturnedzombies || isdefined(zombie.var_8666ebbf) && zombie.var_8666ebbf)) {
            dist = distancesquared(self.origin, zombie.origin);
            if (!isdefined(closest_dist) || dist < closest_dist) {
                closest_dist = dist;
                zombie_enemy = zombie;
            }
        }
    }
    self.favoriteenemy = zombie_enemy;
}

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 0, eflags: 0x0
// Checksum 0x6cf98f64, Offset: 0xd50
// Size: 0x23a
function tiger_init() {
    self.allowdeath = 1;
    self.allowpain = 0;
    self.force_gib = 1;
    self.is_zombie = 1;
    self.gibbed = 0;
    self.head_gibbed = 0;
    self.default_goalheight = 40;
    self.ignore_inert = 1;
    self.holdfire = 1;
    self.var_63606097 = 1;
    self.grenadeawareness = 0;
    self.badplaceawareness = 0;
    self.ignoresuppression = 1;
    self.suppressionthreshold = 1;
    self.dontshootwhilemoving = 1;
    self.pathenemylookahead = 0;
    self.badplaceawareness = 0;
    self.chatinitialized = 0;
    self.b_ignore_cleanup = 1;
    self.team = level.zombie_team;
    self.var_8666ebbf = 1;
    self.var_82c786f1 = 1;
    self.ignorepathenemyfightdist = 1;
    self allowpitchangle(1);
    self setpitchorient();
    self setavoidancemask("avoid ai");
    self collidewithactors(1);
    self.closest_player_override = &zm_utility::function_87d568c4;
    self thread zombie_utility::round_spawn_failsafe();
    level thread zm_spawner::zombie_death_event(self);
    self callback::function_1dea870d(#"on_ai_killed", &on_tiger_killed);
    self thread zm_audio::zmbaivox_notifyconvert();
    self thread zm_audio::play_ambient_zombie_vocals();
    self.deathfunction = &zm_spawner::zombie_death_animscript;
}

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 1, eflags: 0x0
// Checksum 0xcc97290d, Offset: 0xf98
// Size: 0x2c
function on_tiger_killed(params) {
    waittillframeend();
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 10, eflags: 0x0
// Checksum 0xced46202, Offset: 0xfd0
// Size: 0xe0
function function_cd31d5b2(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    if (isdefined(eattacker) && isai(eattacker) && eattacker.archetype == "tiger" && eattacker.team != self.team) {
        if (isdefined(eattacker.var_10dac2a8)) {
            self function_3c9c9085(eattacker.var_10dac2a8);
        }
    }
    return -1;
}

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 1, eflags: 0x0
// Checksum 0xf58fd09e, Offset: 0x10b8
// Size: 0xa2
function function_3c9c9085(notetrack) {
    switch (notetrack) {
    case #"tiger_melee_left":
        self clientfield::increment_to_player("" + #"hash_14c746e550d9f3ca", 2);
        break;
    case #"tiger_melee_right":
        self clientfield::increment_to_player("" + #"hash_14c746e550d9f3ca", 1);
        break;
    }
}

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 0, eflags: 0x0
// Checksum 0x45d9c80a, Offset: 0x1168
// Size: 0x138
function get_favorite_enemy() {
    var_a817ff2d = getplayers();
    least_hunted = var_a817ff2d[0];
    for (i = 0; i < var_a817ff2d.size; i++) {
        if (!isdefined(var_a817ff2d[i].hunted_by)) {
            var_a817ff2d[i].hunted_by = 0;
        }
        if (!zm_utility::is_player_valid(var_a817ff2d[i])) {
            continue;
        }
        if (!zm_utility::is_player_valid(least_hunted)) {
            least_hunted = var_a817ff2d[i];
        }
        if (var_a817ff2d[i].hunted_by < least_hunted.hunted_by) {
            least_hunted = var_a817ff2d[i];
        }
    }
    if (!zm_utility::is_player_valid(least_hunted)) {
        return undefined;
    }
    least_hunted.hunted_by += 1;
    return least_hunted;
}

// Namespace zm_ai_tiger/zm_ai_tiger
// Params 0, eflags: 0x0
// Checksum 0xaa63d8d3, Offset: 0x12a8
// Size: 0x68
function function_a08f368d() {
    self endon(#"death");
    while (true) {
        if (!zm_utility::is_player_valid(self.favoriteenemy)) {
            self.favoriteenemy = get_favorite_enemy();
        }
        wait 0.2;
    }
}

