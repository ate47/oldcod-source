#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\archetype_brutus;
#using scripts\core_common\ai\archetype_brutus_interface;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\archetype_mocomps_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\debug;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_lockdown_util;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_pack_a_punch_util;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_transformation;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;

#namespace zm_ai_brutus;

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 0, eflags: 0x2
// Checksum 0xcfcd30c3, Offset: 0x4e8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_ai_brutus", &__init__, &__main__, undefined);
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 0, eflags: 0x0
// Checksum 0x2503942e, Offset: 0x538
// Size: 0x2bc
function __init__() {
    registerbehaviorscriptfunctions();
    spawner::add_archetype_spawn_function("brutus", &function_93b89882);
    spawner::function_c2d00d5a("brutus", &function_e1154818);
    level._effect[#"brutus"] = [];
    level._effect[#"brutus"][#"lockdown_stub_type_pap"] = "maps/zm_escape/fx8_alcatraz_perk_lock";
    level._effect[#"brutus"][#"lockdown_stub_type_perks"] = "maps/zm_escape/fx8_alcatraz_perk_s_lock";
    level._effect[#"brutus"][#"lockdown_stub_type_crafting_tables"] = "maps/zm_escape/fx8_alcatraz_w_bench_lock";
    level thread aat::register_immunity("zm_aat_brain_decay", "brutus", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_frostbite", "brutus", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_kill_o_watt", "brutus", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_plasmatic_burst", "brutus", 1, 1, 1);
    clientfield::register("actor", "brutus_shock_attack", 1, 1, "counter");
    clientfield::register("actor", "brutus_spawn_clientfield", 1, 1, "int");
    clientfield::register("toplayer", "brutus_shock_attack_player", 1, 1, "counter");
    callback::on_actor_killed(&on_brutus_killed);
    /#
        zm_devgui::function_9b9b2fe4("<dev string:x30>");
    #/
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x800
// Size: 0x4
function __main__() {
    
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 0, eflags: 0x0
// Checksum 0x5dbb060b, Offset: 0x810
// Size: 0x1c4
function function_93b89882() {
    self zombie_utility::set_zombie_run_cycle("run");
    aiutility::addaioverridedamagecallback(self, &function_1a3d0991);
    self.hashelmet = 1;
    self.helmethits = 0;
    self.var_12869fc4 = 0;
    self.var_b6327073 = 0;
    self.var_4d530b4a = self ai::function_a0dbf10a().var_ebea820d;
    self.meleedamage = self ai::function_a0dbf10a().var_bf0789ce;
    self.nuke_damage_func = &function_28fc62d1;
    self.instakill_func = &instakill_override;
    self.var_101fcd59 = 1;
    self.var_2e8cef76 = 1;
    self.var_c5a4812d = 0;
    self.var_77966006 = &brutustargetservice;
    self.cant_move_cb = &zombiebehavior::function_6137e5da;
    self thread zm_audio::zmbaivox_notifyconvert();
    self thread zm_audio::play_ambient_zombie_vocals();
    self callback::function_1dea870d(#"hash_6f9c2499f805be2f", &function_4f58695b);
    if (!isdefined(self.var_ea94c12a)) {
        self attach("c_t8_zmb_mob_brutus_baton", "tag_weapon_right");
    }
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 0, eflags: 0x0
// Checksum 0x1f760f1f, Offset: 0x9e0
// Size: 0x6c
function function_4f58695b() {
    self clientfield::set("brutus_spawn_clientfield", 1);
    if (isdefined(level.var_1169d000) && level.var_1169d000) {
        return;
    }
    playsoundatposition(#"zmb_ai_brutus_spawn", self.origin);
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 0, eflags: 0x0
// Checksum 0x457df571, Offset: 0xa58
// Size: 0x76
function function_500594e7() {
    if (!isdefined(level.brutus_last_spawn_round)) {
        level.brutus_last_spawn_round = 0;
    }
    if (!isdefined(level.brutus_round_count)) {
        level.brutus_round_count = 0;
    }
    if (level.round_number > level.brutus_last_spawn_round) {
        level.brutus_round_count++;
        level.brutus_last_spawn_round = level.round_number;
    }
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 0, eflags: 0x0
// Checksum 0xaad4f55f, Offset: 0xad8
// Size: 0xea
function function_6e0b9a5f() {
    a_players = getplayers();
    n_player_modifier = 1;
    if (a_players.size > 1) {
        n_player_modifier = a_players.size * self ai::function_a0dbf10a().var_e63097b4;
    }
    var_e1cfdbda = self ai::function_a0dbf10a().var_4e860818 * n_player_modifier * level.brutus_round_count;
    var_e1cfdbda = int(min(var_e1cfdbda, self ai::function_a0dbf10a().var_6c1ee03a * n_player_modifier));
    return var_e1cfdbda;
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 0, eflags: 0x0
// Checksum 0x85fae9ae, Offset: 0xbd0
// Size: 0x184
function function_e1154818() {
    if (!isdefined(self.starting_health)) {
        function_500594e7();
        self.maxhealth = int(self zm_ai_utility::function_55a1bfd1(1, level.brutus_round_count) * (isdefined(level.var_fff66c5c) ? level.var_fff66c5c : 1));
        self.health = int(self zm_ai_utility::function_55a1bfd1(1, level.brutus_round_count) * (isdefined(level.var_fff66c5c) ? level.var_fff66c5c : 1));
    } else {
        self.maxhealth = self.starting_health;
        self.health = self.starting_health;
    }
    self.starting_health = undefined;
    self.explosive_dmg_req = self function_6e0b9a5f();
    starting_round = isdefined(self._starting_round_number) ? self._starting_round_number : level.round_number;
    ai::set_behavior_attribute("can_ground_slam", starting_round > self ai::function_a0dbf10a().var_ebe2a311);
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 1, eflags: 0x0
// Checksum 0x297d1c73, Offset: 0xd60
// Size: 0xa4
function on_brutus_killed(params) {
    if (self.archetype !== "brutus") {
        return;
    }
    self clientfield::set("brutus_spawn_clientfield", 0);
    playsoundatposition(#"zmb_ai_brutus_death", self.origin);
    self destructserverutils::togglespawngibs(self, 1);
    self destructserverutils::function_2a60056f(self, "tag_weapon_right");
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 0, eflags: 0x4
// Checksum 0x1b7f6cb5, Offset: 0xe10
// Size: 0x42c
function private registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&function_9b9b8cb6));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_68d081058095794", &function_9b9b8cb6);
    assert(isscriptfunctionptr(&function_8ba9bd8c));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_df1d28cebbb75f6", &function_8ba9bd8c);
    assert(isscriptfunctionptr(&function_5b80b3b9));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_d8653062b32a601", &function_5b80b3b9);
    assert(isscriptfunctionptr(&function_61c69ae8));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_691307470629f20e", &function_61c69ae8);
    assert(isscriptfunctionptr(&function_cfacb9a0));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_526dcca6d6d76bfe", &function_cfacb9a0);
    assert(isscriptfunctionptr(&brutuslockdownstub));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"brutuslockdownstub", &brutuslockdownstub);
    assert(isscriptfunctionptr(&function_9011a2f7));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_643443bf9243e4ff", &function_9011a2f7);
    assert(isscriptfunctionptr(&function_ba6bef3c));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5800441474109ca6", &function_ba6bef3c);
    animationstatenetwork::registernotetrackhandlerfunction("hit_ground", &function_7b956338);
    animationstatenetwork::registernotetrackhandlerfunction("locked", &brutuslockdownstub);
    animationstatenetwork::registeranimationmocomp("mocomp_purchase_lockdown@brutus", &function_ee8434a9, undefined, undefined);
    assert(isscriptfunctionptr(&function_a217930b));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1ba2ab8d76e1cd9b", &function_a217930b);
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 2, eflags: 0x4
// Checksum 0xf5776756, Offset: 0x1248
// Size: 0x1f2
function private function_b7fa40f1(entity, minplayerdist) {
    playerpositions = [];
    foreach (player in getplayers()) {
        if (!isdefined(playerpositions)) {
            playerpositions = [];
        } else if (!isarray(playerpositions)) {
            playerpositions = array(playerpositions);
        }
        if (!isinarray(playerpositions, isdefined(player.last_valid_position) ? player.last_valid_position : player.origin)) {
            playerpositions[playerpositions.size] = isdefined(player.last_valid_position) ? player.last_valid_position : player.origin;
        }
    }
    navmesh_origin = getclosestpointonnavmesh(entity.origin, entity getpathfindingradius());
    if (isdefined(navmesh_origin)) {
        pathdata = generatenavmeshpath(navmesh_origin, playerpositions, entity);
        if (isdefined(pathdata) && pathdata.status === "succeeded" && pathdata.pathdistance < minplayerdist) {
            return false;
        }
    }
    return true;
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 1, eflags: 0x4
// Checksum 0x4759f040, Offset: 0x1448
// Size: 0x392
function private brutustargetservice(entity) {
    if (isdefined(entity.ignoreall) && entity.ignoreall) {
        return 0;
    }
    entity.favoriteenemy = entity.var_532a149b;
    if (!isdefined(entity.favoriteenemy) || zm_behavior::zombieshouldmoveawaycondition(entity)) {
        zone = zm_utility::get_current_zone();
        if (isdefined(zone)) {
            wait_locations = level.zones[zone].a_loc_types[#"wait_location"];
            if (isdefined(wait_locations) && wait_locations.size > 0) {
                entity zm_utility::function_23a24406(wait_locations[0].origin, 200);
                return 1;
            }
        }
        entity setgoal(entity.origin);
        return 1;
    }
    /#
        zm_lockdown_util::function_819c89(entity);
    #/
    if (!isdefined(entity.var_e6c0c0c1)) {
        entity.var_92f42df = undefined;
        pointofinterest = entity zm_utility::get_zombie_point_of_interest(entity.origin);
        if (isdefined(pointofinterest) && pointofinterest.size > 0) {
            foreach (poi in pointofinterest) {
                if (isdefined(poi) && isentity(poi) && isdefined(poi.classname) && poi.classname == "grenade") {
                    goalpos = getclosestpointonnavmesh(poi.origin, 10, self getpathfindingradius());
                    if (isdefined(goalpos)) {
                        entity.var_e6c0c0c1 = poi;
                        entity.var_92f42df = goalpos;
                    }
                }
            }
        }
    }
    if (isdefined(entity.var_92f42df) && entity zm_utility::function_23a24406(entity.var_92f42df)) {
        return 1;
    }
    if (isdefined(entity.var_12190c8f)) {
        entity function_3c8dce03(entity.var_12190c8f);
        return 1;
    }
    goalent = entity.favoriteenemy;
    if (isplayer(goalent)) {
        goalent = zm_ai_utility::function_93d978d(entity, entity.favoriteenemy);
    }
    return entity zm_utility::function_23a24406(goalent.origin);
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 1, eflags: 0x4
// Checksum 0x6a3d98f8, Offset: 0x17e8
// Size: 0x4a0
function private function_a217930b(entity) {
    var_4e32c3bc = zm_lockdown_util::function_13e129fe(entity);
    if (isdefined(entity.var_e6c0c0c1) || !isdefined(var_4e32c3bc) || !zm_lockdown_util::function_70cf3d31(entity, var_4e32c3bc)) {
        zm_lockdown_util::function_26e5ad8c(var_4e32c3bc);
        entity.var_12190c8f = undefined;
    }
    if (isdefined(entity.var_e6c0c0c1) || isdefined(var_4e32c3bc)) {
        return;
    }
    if (entity.var_c5a4812d > gettime()) {
        return 0;
    }
    if (!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
        return 0;
    }
    /#
        zm_lockdown_util::function_819c89(entity);
    #/
    stub_types = [];
    array::add(stub_types, "lockdown_stub_type_crafting_tables");
    array::add(stub_types, "lockdown_stub_type_perks");
    array::add(stub_types, "lockdown_stub_type_pap");
    array::add(stub_types, "lockdown_stub_type_magic_box");
    array::add(stub_types, "lockdown_stub_type_boards");
    array::add(stub_types, "lockdown_stub_type_traps");
    var_ad671012 = zm_lockdown_util::function_6b5c9744(entity, stub_types, entity ai::function_a0dbf10a().var_1a0e2fc8, entity ai::function_a0dbf10a().var_71b1bbb5);
    entity.var_c5a4812d = gettime() + 500;
    if (var_ad671012.size == 0) {
        return 0;
    }
    stub = var_ad671012[0];
    if (!function_b7fa40f1(entity, entity ai::function_a0dbf10a().var_39e9348d)) {
        /#
            zm_lockdown_util::function_a5eb496b(entity, stub, 9);
        #/
        return 0;
    }
    var_a927530b = undefined;
    var_553984f5 = zm_lockdown_util::function_d6ef7837(entity, stub);
    if (!isdefined(var_553984f5)) {
        var_c9672c88 = zm_utility::function_eb5eb205(stub.origin);
        halfheight = 32;
        if (!isdefined(var_c9672c88)) {
            var_c9672c88 = [];
            var_c9672c88[#"point"] = stub.origin;
            halfheight = (stub.origin - zm_utility::groundpos(stub.origin))[2] + 1;
        }
        var_b61e6cbf = positionquery_source_navigation(var_c9672c88[#"point"], 0, 256, halfheight, 20, 1);
        if (var_b61e6cbf.data.size == 0) {
            return 0;
        }
        var_a927530b = var_b61e6cbf.data[0].origin;
    } else {
        var_a927530b = getclosestpointonnavmesh(var_553984f5.origin, 200, 24);
    }
    if (!isdefined(var_a927530b)) {
        return 0;
    }
    entity.var_12190c8f = var_a927530b;
    zm_lockdown_util::function_66774b7(entity, stub);
    entity setblackboardattribute("_lockdown_type", zm_lockdown_util::function_165ef62f(stub.lockdowntype));
    /#
        zm_lockdown_util::function_819c89(entity);
    #/
    return 1;
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 1, eflags: 0x4
// Checksum 0xb6e127e5, Offset: 0x1c90
// Size: 0x74
function private function_8ba9bd8c(entity) {
    if (!isdefined(entity.var_e6c0c0c1) || !isdefined(entity.var_92f42df) || distancesquared(entity.var_92f42df, entity.origin) > 10 * 10) {
        return false;
    }
    return true;
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 1, eflags: 0x4
// Checksum 0xf4f14fb8, Offset: 0x1d10
// Size: 0xd4
function private function_9011a2f7(entity) {
    if (!isdefined(entity.var_e6c0c0c1)) {
        return;
    }
    monkeybomb = entity.var_e6c0c0c1;
    level notify(#"hash_79c0225ea09cd215", {#brutus:self, #var_af11b0eb:monkeybomb.origin, #var_b9c44175:monkeybomb.angles});
    if (isdefined(monkeybomb.damagearea)) {
        monkeybomb.damagearea delete();
    }
    monkeybomb delete();
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 1, eflags: 0x0
// Checksum 0xa76ac30, Offset: 0x1df0
// Size: 0x2ae
function function_61c69ae8(entity) {
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (isdefined(entity.marked_for_death)) {
        return false;
    }
    if (isdefined(entity.ignoremelee) && entity.ignoremelee) {
        return false;
    }
    if (abs(entity.origin[2] - entity.enemy.origin[2]) > 64) {
        return false;
    }
    if (isdefined(entity.meleeweapon) && entity.meleeweapon !== level.weaponnone) {
        meleedistsq = entity.meleeweapon.aimeleerange * entity.meleeweapon.aimeleerange;
    }
    if (!isdefined(meleedistsq)) {
        return false;
    }
    if (distancesquared(entity.origin, entity.enemy.origin) > meleedistsq) {
        return false;
    }
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
    if (abs(yawtoenemy) > 60) {
        return false;
    }
    if (!entity cansee(entity.enemy)) {
        return false;
    }
    if (distancesquared(entity.origin, entity.enemy.origin) < 40 * 40) {
        return true;
    }
    if (!tracepassedonnavmesh(entity.origin, isdefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin, entity getpathfindingradius())) {
        return false;
    }
    return true;
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 1, eflags: 0x4
// Checksum 0xe0a5df08, Offset: 0x20a8
// Size: 0x52
function private function_cfacb9a0(entity) {
    return entity ai::has_behavior_attribute("scripted_mode") && entity ai::get_behavior_attribute("scripted_mode") === 1;
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 1, eflags: 0x4
// Checksum 0xe4d32a7f, Offset: 0x2108
// Size: 0x140
function private function_5b80b3b9(entity) {
    if (!entity ai::get_behavior_attribute("can_ground_slam")) {
        return false;
    }
    if (entity.var_12869fc4 > gettime()) {
        return false;
    }
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (!(isdefined(entity.favoriteenemy.am_i_valid) && entity.favoriteenemy.am_i_valid)) {
        return false;
    }
    if (abs(entity.origin[2] - entity.favoriteenemy.origin[2]) > 72) {
        return false;
    }
    if (distance2dsquared(entity.origin, entity.favoriteenemy.origin) > entity ai::function_a0dbf10a().var_682a3da6 * entity ai::function_a0dbf10a().var_682a3da6) {
        return false;
    }
    return true;
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 1, eflags: 0x4
// Checksum 0x1159369b, Offset: 0x2250
// Size: 0x4e
function private function_ba6bef3c(entity) {
    entity.var_12869fc4 = gettime() + int(entity ai::function_a0dbf10a().var_cc6c96be * 1000);
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 1, eflags: 0x4
// Checksum 0xa89646dc, Offset: 0x22a8
// Size: 0x378
function private function_7b956338(entity) {
    players = getplayers();
    zombies = getaiteamarray(level.zombie_team);
    ents = arraycombine(players, zombies, 0, 0);
    ents = arraysortclosest(ents, entity.origin, undefined, 0, entity ai::function_a0dbf10a().var_3d56fc04);
    shock_status_effect = getstatuseffect(#"hash_19533caf858a9f3b");
    entity clientfield::increment("brutus_shock_attack", 1);
    foreach (ent in ents) {
        if (isplayer(ent)) {
            if (!zombie_utility::is_player_valid(ent, 0, 0)) {
                continue;
            }
            if (!bullettracepassed(entity.origin, ent gettagorigin("j_spine4"), 0, entity, ent)) {
                continue;
            }
            damage = mapfloat(entity getpathfindingradius() + 15, entity ai::function_a0dbf10a().var_3d56fc04, entity ai::function_a0dbf10a().var_3f5ecf8a, 0, distance(entity.origin, ent.origin));
            damage = int(max(10, damage));
            ent dodamage(damage, entity.origin, entity, entity, "none");
            ent status_effect::status_effect_apply(shock_status_effect, undefined, self, 0);
            ent clientfield::increment_to_player("brutus_shock_attack_player", 1);
            continue;
        }
        if (isai(ent)) {
            if (ent.var_29ed62b2 === #"basic") {
                ent zombie_utility::setup_zombie_knockdown(entity);
            }
        }
    }
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 1, eflags: 0x4
// Checksum 0xf3c33b53, Offset: 0x2628
// Size: 0xa0
function private function_9b9b8cb6(entity) {
    if (!isdefined(entity.var_12190c8f) || !zm_lockdown_util::function_e4baa0a4(entity)) {
        return false;
    }
    if (distancesquared(entity.var_12190c8f, entity.origin) > entity ai::function_a0dbf10a().var_67c0627d * entity ai::function_a0dbf10a().var_67c0627d) {
        return false;
    }
    return true;
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 1, eflags: 0x0
// Checksum 0x19697916, Offset: 0x26d0
// Size: 0x8a
function function_f11471ec(player) {
    if (zm_utility::is_standard()) {
        self sethintstring(#"hash_41048087f44fc9b0");
    } else {
        self sethintstring(#"hash_5bdb56428055a4c1", self.stub.var_2ad7ea0c);
    }
    return zm_lockdown_util::function_ec53c9d4(self.stub);
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 2, eflags: 0x4
// Checksum 0x280bf679, Offset: 0x2768
// Size: 0x140
function private function_48b8ecaa(type, stub) {
    if (!isdefined(stub.var_31687a6a)) {
        stub.var_31687a6a = 0;
    }
    var_57423d63 = 2000;
    switch (type) {
    case #"lockdown_stub_type_crafting_tables":
        var_5b8ab669 = 1;
        break;
    case #"lockdown_stub_type_magic_box":
        var_5b8ab669 = 1;
        break;
    case #"lockdown_stub_type_pap":
        var_5b8ab669 = 3;
        break;
    case #"lockdown_stub_type_perks":
        var_5b8ab669 = 3;
        break;
    default:
        var_5b8ab669 = 1;
        break;
    }
    stub.var_31687a6a = int(min(stub.var_31687a6a + 1, var_5b8ab669));
    return var_57423d63 * stub.var_31687a6a;
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 0, eflags: 0x4
// Checksum 0xa02db775, Offset: 0x28b0
// Size: 0x198
function private function_eb5991e4() {
    self endon(#"death");
    for (;;) {
        waitresult = self waittill(#"trigger");
        if (!isdefined(waitresult.activator) || !zm_utility::is_player_valid(waitresult.activator)) {
            continue;
        }
        player = waitresult.activator;
        if (!player zm_score::can_player_purchase(self.stub.var_2ad7ea0c)) {
            continue;
        }
        player zm_score::minus_to_player_score(self.stub.var_2ad7ea0c);
        level notify(#"unlock_purchased", {#s_stub:self.stub});
        if (isdefined(self.stub.var_c6035c50)) {
            self.stub thread zm_lockdown_util::function_2d50e64d();
            continue;
        }
        if (self.stub.lockdowntype == "lockdown_stub_type_magic_box") {
            self.stub.trigger_target.zbarrier thread zm_magicbox::set_magic_box_zbarrier_state("unlocking");
        }
        self.stub thread zm_lockdown_util::function_13c3d2e9();
    }
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 1, eflags: 0x4
// Checksum 0x1ab934c7, Offset: 0x2a50
// Size: 0x194
function private brutuslockdownstub(entity) {
    stub = zm_lockdown_util::function_13e129fe(entity);
    if (isdefined(stub)) {
        if (!zm_lockdown_util::function_70cf3d31(entity, stub)) {
            zm_lockdown_util::function_26e5ad8c(stub);
            entity.var_12190c8f = undefined;
            return;
        }
        if (stub.lockdowntype == "lockdown_stub_type_magic_box") {
            stub.trigger_target.zbarrier zm_magicbox::set_magic_box_zbarrier_state("locking");
        }
        if (isdefined(stub.lockdowntype)) {
            var_abd12ab4 = function_48b8ecaa(stub.lockdowntype, stub);
        } else {
            var_abd12ab4 = 2000;
        }
        stub.var_2ad7ea0c = var_abd12ab4;
        level notify(#"brutus_locked", {#s_stub:stub});
        zm_lockdown_util::function_a0ca5bc8(entity, &function_f11471ec, &function_eb5991e4);
        entity setblackboardattribute("_lockdown_type", "INVALID");
    }
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 5, eflags: 0x4
// Checksum 0x73557f08, Offset: 0x2bf0
// Size: 0x7c
function private function_ee8434a9(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    stub = zm_lockdown_util::function_13e129fe(entity);
    if (isdefined(stub)) {
        entity orientmode("face point", stub.origin);
    }
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 1, eflags: 0x4
// Checksum 0x418320eb, Offset: 0x2c78
// Size: 0x62
function private function_74890104(v_org) {
    grenade = self magicgrenadetype(getweapon(#"willy_pete"), v_org, (0, 0, 0), 0.4);
    grenade.owner = self;
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 0, eflags: 0x0
// Checksum 0xab2f9131, Offset: 0x2ce8
// Size: 0x16c
function function_ac97890d() {
    self.hashelmet = 0;
    self zombie_utility::set_zombie_run_cycle("sprint");
    self.var_b6327073 = gettime() + int(self ai::function_a0dbf10a().var_fda675c0 * 1000);
    destructserverutils::function_fa9a6761(self, "helmet");
    self playsound(#"evt_brutus_helmet");
    self thread zm_audio::zmbaivox_playvox(self, "roar", 1, 3);
    if (isalive(self)) {
        function_74890104(self gettagorigin("TAG_WEAPON_LEFT"));
        function_74890104(self gettagorigin("TAG_WEAPON_RIGHT"));
        level thread smoke_vo(self.origin);
    }
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 1, eflags: 0x0
// Checksum 0xd03b85fa, Offset: 0x2e60
// Size: 0x100
function smoke_vo(v_pos) {
    t_smoke = spawn("trigger_radius", v_pos, 0, 200, 80);
    t_smoke endon(#"death");
    t_smoke thread function_6522bfc();
    while (true) {
        waitresult = t_smoke waittill(#"trigger");
        if (isplayer(waitresult.activator)) {
            waitresult.activator zm_audio::create_and_play_dialog("brutus", "smoke_react");
        }
        wait randomfloatrange(0.666667, 1.33333);
    }
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 0, eflags: 0x0
// Checksum 0x1304e36a, Offset: 0x2f68
// Size: 0x1c
function function_6522bfc() {
    wait 20;
    self delete();
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 5, eflags: 0x4
// Checksum 0xbe8baaf8, Offset: 0x2f90
// Size: 0x174
function private function_981ea04f(attacker, damage, var_e85e6e94, damagemultiplier, damageoverride) {
    if (!(isdefined(self.hashelmet) && self.hashelmet)) {
        if (attacker hasperk(#"specialty_mod_awareness")) {
            damage *= 1.2;
        }
        return (damage * (damageoverride ? damagemultiplier : var_e85e6e94));
    }
    self.helmethits++;
    if (self.helmethits >= self.var_4d530b4a) {
        self function_ac97890d();
        if (isdefined(attacker) && isplayer(attacker) && isdefined(level.brutus_points_for_helmet)) {
            attacker zm_score::add_to_player_score(zm_score::get_points_multiplier(attacker) * zm_utility::round_up_score(level.brutus_points_for_helmet, 5));
            attacker notify(#"hash_1413599b710f10bd");
        }
    }
    return damage * damagemultiplier;
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 11, eflags: 0x4
// Checksum 0x29708f04, Offset: 0x3110
// Size: 0x39c
function private function_1a3d0991(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, poffsettime, boneindex) {
    var_cbee50fe = isdefined(level.brutus_damage_percent) ? level.brutus_damage_percent : 0.1;
    var_cdaf2d92 = 1.5;
    var_e85e6e94 = 1;
    if (self.var_b6327073 > gettime()) {
        if (isplayer(attacker)) {
            attacker util::show_hit_marker();
        }
        return 0;
    }
    var_ce4361a0 = zm_ai_utility::function_9094ed69(self, attacker, weapon, boneindex);
    var_cbee50fe = var_ce4361a0.damage_scale;
    var_1c83b4e4 = self zm_ai_utility::function_2d622750(weapon);
    if (isdefined(attacker) && isalive(attacker) && isplayer(attacker) && attacker zm_powerups::is_insta_kill_active()) {
        var_e85e6e94 = 2;
    }
    if (isdefined(weapon) && weapon.weapclass == "spread") {
        var_cbee50fe *= var_cdaf2d92;
        var_e85e6e94 *= var_cdaf2d92;
    }
    if (zm_utility::is_explosive_damage(meansofdeath)) {
        if (!isdefined(self.explosivedmgtaken)) {
            self.explosivedmgtaken = 0;
        }
        self.explosivedmgtaken += damage;
        scaler = var_cbee50fe;
        if (self.explosivedmgtaken >= self.explosive_dmg_req && isdefined(self.hashelmet) && self.hashelmet) {
            self function_ac97890d();
            if (isdefined(attacker) && isplayer(attacker) && isdefined(level.brutus_points_for_helmet)) {
                attacker zm_score::add_to_player_score(zm_score::get_points_multiplier(attacker) * zm_utility::round_up_score(level.brutus_points_for_helmet, 5));
                attacker notify(#"hash_1413599b710f10bd");
            }
        }
        return (damage * scaler);
    }
    if (shitloc != "head" && shitloc != "helmet") {
        return (damage * var_cbee50fe);
    }
    return int(self function_981ea04f(attacker, damage, var_e85e6e94, var_cbee50fe, var_1c83b4e4));
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 0, eflags: 0x0
// Checksum 0x36d18935, Offset: 0x34b8
// Size: 0xa4
function function_28fc62d1() {
    self endon(#"death");
    wait randomfloatrange(0.1, 0.7);
    self thread zombie_death::flame_death_fx();
    self playsound(#"evt_nuked");
    self dodamage(self.maxhealth * 0.25, self.origin);
}

// Namespace zm_ai_brutus/zm_ai_brutus
// Params 3, eflags: 0x0
// Checksum 0xa2ba7a1d, Offset: 0x3568
// Size: 0x38
function instakill_override(player, mod, shitloc) {
    if (self.archetype === "brutus") {
        return true;
    }
    return false;
}

