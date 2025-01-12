#using script_2c5daa95f8fec03c;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\archetype_mocomps_utility;
#using scripts\core_common\ai\archetype_stoker;
#using scripts\core_common\ai\archetype_stoker_interface;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\debug;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\burnplayer;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\trials\zm_trial_special_enemy;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;

#namespace zm_ai_stoker;

// Namespace zm_ai_stoker
// Method(s) 2 Total 2
class class_401a8de8 {

    var active;
    var health;
    var hitloc;
    var hittag;

    // Namespace class_401a8de8/zm_ai_stoker
    // Params 0, eflags: 0x8
    // Checksum 0xe9eb36b3, Offset: 0x1440
    // Size: 0x4c
    constructor() {
        active = 1;
        health = 0;
        hitloc = "";
        hittag = "";
        var_945eb73e = 0;
    }

}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 0, eflags: 0x2
// Checksum 0xd2bbcc08, Offset: 0x590
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_ai_stoker", &__init__, &__main__, undefined);
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 0, eflags: 0x0
// Checksum 0x4f618de6, Offset: 0x5e0
// Size: 0x33c
function __init__() {
    level.var_c594df6e = 0;
    zm_player::register_player_damage_callback(&function_ad481f6d);
    registerbehaviorscriptfunctions();
    init();
    /#
        execdevgui("<dev string:x30>");
        level thread function_ad50378a();
    #/
    spawner::add_archetype_spawn_function("stoker", &function_1d7b286f);
    zm_utility::function_81bbcc91("stoker");
    /#
        spawner::add_archetype_spawn_function("<dev string:x4e>", &zombie_utility::updateanimationrate);
    #/
    animationstatenetwork::registernotetrackhandlerfunction("coals_fire", &function_eeda011d);
    animationstatenetwork::registernotetrackhandlerfunction("stoker_death_gib", &function_8ee91282);
    if (ai::shouldregisterclientfieldforarchetype("stoker")) {
        clientfield::register("actor", "crit_spot_reveal_clientfield", 1, getminbitcountfornum(4), "int");
        clientfield::register("actor", "stoker_fx_start_clientfield", 1, 3, "int");
        clientfield::register("actor", "stoker_fx_stop_clientfield", 1, 3, "int");
        clientfield::register("actor", "stoker_death_explosion", 1, 2, "int");
    }
    function_776d5697();
    zm::register_actor_damage_callback(&function_2ef8b23e);
    zm_spawner::register_zombie_death_event_callback(&killed_callback);
    zm_trial_special_enemy::function_6e25f633(#"stoker", &function_25edafe);
    zm_utility::register_slowdown("stoker_undewater_slow_type", 0.8);
    zm_round_spawning::register_archetype("stoker", &function_d6862794, &round_spawn, undefined, 100);
    zm_round_spawning::function_1a28bc99("stoker", &function_f56566ae);
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x928
// Size: 0x4
function __main__() {
    
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 0, eflags: 0x0
// Checksum 0xdfc93c80, Offset: 0x938
// Size: 0xe4
function init() {
    level.a_sp_stoker = [];
    level thread aat::register_immunity("zm_aat_brain_decay", "stoker", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_frostbite", "stoker", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_kill_o_watt", "stoker", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_plasmatic_burst", "stoker", 1, 1, 1);
    function_1b8f4007();
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 0, eflags: 0x0
// Checksum 0x981b2cec, Offset: 0xa28
// Size: 0x9e4
function registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&function_fdd73484));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_11342039e49bb092", &function_fdd73484);
    assert(isscriptfunctionptr(&function_26dc6230));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_64bb85f17c6f0c26", &function_26dc6230);
    assert(isscriptfunctionptr(&function_5bb3ceea));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7abf56a70eea8824", &function_5bb3ceea);
    assert(isscriptfunctionptr(&function_79c37ddb));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7914389e526099c3", &function_79c37ddb);
    assert(isscriptfunctionptr(&function_d3f86041));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_69d99c802f94a161", &function_d3f86041);
    assert(isscriptfunctionptr(&function_c163e36));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_34979234c577e020", &function_c163e36);
    assert(isscriptfunctionptr(&function_211b1627));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2eda816d46284ecf", &function_211b1627);
    assert(isscriptfunctionptr(&function_d097fef0));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_62e8ff16b0eb8a2e", &function_d097fef0);
    assert(isscriptfunctionptr(&function_3463afb0));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_e3d43dd957e7586", &function_3463afb0);
    assert(isscriptfunctionptr(&function_6c21e821));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2d05a32b52fcaafd", &function_6c21e821);
    assert(isscriptfunctionptr(&function_d550c344));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7ed50d08e0e9bcfa", &function_d550c344);
    assert(isscriptfunctionptr(&function_40342b0f));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_58ce6baf23499b6f", &function_40342b0f);
    assert(isscriptfunctionptr(&function_501774fa));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3993bf34ab2531f0", &function_501774fa);
    assert(isscriptfunctionptr(&function_fffc1cef));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_25c4de2eb81f27cb", &function_fffc1cef);
    assert(isscriptfunctionptr(&function_2bc5cb12));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_389c07d3893e660", &function_2bc5cb12);
    assert(isscriptfunctionptr(&function_902e2137));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1607f20e814fb19b", &function_902e2137);
    assert(isscriptfunctionptr(&function_83e86365));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_173e1c9378200965", &function_83e86365);
    assert(isscriptfunctionptr(&function_f9df2d5a));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3e875851311be4e8", &function_f9df2d5a);
    assert(isscriptfunctionptr(&function_f19132a9));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4fe0c56f8cd42ad1", &function_f19132a9);
    assert(isscriptfunctionptr(&function_54e33fb));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_21f1387075571547", &function_54e33fb);
    assert(isscriptfunctionptr(&function_eb852bc0));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_771bfe8686d806d6", &function_eb852bc0);
    assert(isscriptfunctionptr(&function_3913b693));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_138db5b46aeab153", &function_3913b693);
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&function_eb160b2d) || isscriptfunctionptr(&function_eb160b2d));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    behaviortreenetworkutility::registerbehaviortreeaction(#"hash_4778faf1d75cc885", undefined, &function_eb160b2d, undefined);
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 0, eflags: 0x4
// Checksum 0xd94979c2, Offset: 0x1418
// Size: 0x1e
function private function_776d5697() {
    level.stokerdebug = 0;
    level.var_a98afcd4 = 0;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 0, eflags: 0x0
// Checksum 0x3887beb5, Offset: 0x1538
// Size: 0x5c8
function function_1d7b286f() {
    zm_score::function_c723805e("stoker", self ai::function_a0dbf10a().var_fbef0b7f);
    aiutility::addaioverridedamagecallback(self, &function_bc4607ea);
    self attach("c_t8_zmb_titanic_stoker_larm1");
    self attach("c_t8_zmb_titanic_stoker_lshoulder_cap1");
    self attach("c_t8_zmb_titanic_stoker_rshoulder_cap1");
    self attach("c_t8_zmb_titanic_stoker_head_cap1");
    self attach("c_t8_zmb_titanic_stoker_shovel1", "tag_weapon_right");
    self.armorinfo = [];
    self.armorinfo[#"left_arm_upper"] = new class_401a8de8();
    self.armorinfo[#"left_arm_upper"].shadervector = 4;
    self.armorinfo[#"left_arm_upper"].fxindex = 3;
    self.armorinfo[#"right_arm_upper"] = new class_401a8de8();
    self.armorinfo[#"right_arm_upper"].shadervector = 1;
    self.armorinfo[#"right_arm_upper"].fxindex = 4;
    self.armorinfo[#"head"] = new class_401a8de8();
    self.armorinfo[#"head"].shadervector = 3;
    self.armorinfo[#"head"].fxindex = 5;
    self.armorinfo[#"left_arm_lower"] = new class_401a8de8();
    self.armorinfo[#"left_arm_lower"].var_1b4e034b = 1;
    self.armorinfo[#"left_arm_lower"].var_c7128e64 = "j_wrist_le";
    self.armorinfo[#"left_arm_lower"].fxindex = 6;
    self.var_e30cb4ee = [];
    self.var_e30cb4ee[0] = "left_arm_upper";
    self.var_e30cb4ee[1] = "right_arm_upper";
    self.var_e30cb4ee[2] = "head";
    if (!isdefined(level.var_a9e3a7d6)) {
        level.var_a9e3a7d6 = 0;
    }
    self.var_8db91380 = self.var_e30cb4ee[level.var_a9e3a7d6];
    level.var_a9e3a7d6 = (level.var_a9e3a7d6 + 1) % self.var_e30cb4ee.size;
    self.var_ffb76486 = 0;
    self.var_ee64051 = 0;
    self.var_28a9ba84 = "locomotion_speed_run";
    if (level.var_a98afcd4) {
        self.var_28a9ba84 = "locomotion_speed_walk";
    }
    self setblackboardattribute("_locomotion_speed", self.var_28a9ba84);
    self.lastattacktime = gettime() + self ai::function_a0dbf10a().var_64a4a3fe - getdvarint(#"hash_3dfb66f92268c90f", self ai::function_a0dbf10a().var_5bfd9af0);
    self.var_58dad78d = "stoker_charge_attack";
    self.var_898a785c = 0;
    self.var_6f64ed38 = 0;
    self.var_b590f641 = 0;
    self.var_d6857fc = 0;
    self.var_bbd766ae = 0;
    self.ignore_nuke = 1;
    self.var_b6c9a295 = 0;
    self.should_zigzag = 0;
    self.var_e4ccc825 = 1;
    self.instakill_func = &zm_powerups::function_ef67590f;
    self.var_101fcd59 = 1;
    self.actor_killed_override = &function_2fe78cca;
    self.closest_player_override = &zm_utility::function_87d568c4;
    self.var_aaea343e = &function_a3104134;
    self.var_83103966 = &function_d9cde0cf;
    self.cant_move_cb = &zombiebehavior::function_6137e5da;
    self thread zm_audio::play_ambient_zombie_vocals();
    level.var_c594df6e++;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 0, eflags: 0x0
// Checksum 0x60be69a5, Offset: 0x1b08
// Size: 0x8c
function function_ff6c3008() {
    self.maxhealth = int(self zm_ai_utility::function_55a1bfd1(1, self._starting_round_number) * (isdefined(level.var_fff66c5c) ? level.var_fff66c5c : 1));
    self.health = self.maxhealth;
    namespace_9088c704::initweakpoints(self, #"c_t8_zmb_stoker_weakpoint_def");
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 0, eflags: 0x0
// Checksum 0xc76c216b, Offset: 0x1ba0
// Size: 0x130
function function_a3104134() {
    if (!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
        return true;
    }
    if (isdefined(level.var_e777f0b0)) {
        s_spawn_loc = [[ level.var_e777f0b0 ]]();
    } else if (level.zm_loc_types[#"stoker_location"].size > 0) {
        s_spawn_loc = array::random(level.zm_loc_types[#"stoker_location"]);
    }
    if (!isdefined(s_spawn_loc)) {
        return true;
    }
    self dontinterpolate();
    self forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
    self.completed_emerging_into_playable_area = 0;
    self playsound(#"hash_63299a75a97f9678");
    bhtnactionstartevent(self, "spawn");
    return true;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x691c95f, Offset: 0x1cd8
// Size: 0x4c
function private function_8ee91282(entity) {
    entity setmodel("c_t8_zmb_titanic_stoker_body1_gibbed");
    entity clientfield::set("stoker_death_explosion", 2);
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 8, eflags: 0x4
// Checksum 0x9883b8e6, Offset: 0x1d30
// Size: 0x9c
function private function_2fe78cca(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    self clientfield::set("stoker_fx_start_clientfield", 1);
    destructserverutils::destructnumberrandompieces(self);
    self clientfield::set("stoker_death_explosion", 1);
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 4, eflags: 0x4
// Checksum 0xc3761457, Offset: 0x1dd8
// Size: 0x74
function private function_d9cde0cf(entity, attribute, oldvalue, value) {
    if (value == "low") {
        entity thread zm_utility::function_447d3917("stoker_undewater_slow_type");
        return;
    }
    entity thread zm_utility::function_95398de5("stoker_undewater_slow_type");
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 12, eflags: 0x0
// Checksum 0xcb90352e, Offset: 0x1e58
// Size: 0x678
function function_bc4607ea(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
    if (self.archetype != "stoker") {
        return;
    }
    if (eattacker.archetype === "stoker") {
        return 0;
    }
    var_216599c5 = namespace_9088c704::function_abe2d1e7(self, shitloc, 1);
    if (!isdefined(var_216599c5)) {
        var_216599c5 = namespace_9088c704::function_4ef61202(self, vpoint, 1);
    }
    var_ce4361a0 = zm_ai_utility::function_9094ed69(self, eattacker, sweapon, boneindex, var_216599c5);
    damagedone = int(max(1, idamage * var_ce4361a0.damage_scale));
    var_a9ce36de = 0;
    var_503b241b = 0;
    if (zm_loadout::is_hero_weapon(sweapon)) {
        var_503b241b = 1;
        if (!isdefined(self.var_6f687f49) || self.var_6f687f49 >= 1000) {
            self.var_6f687f49 = 0;
        }
        self.var_6f687f49 += damagedone;
    }
    if (smeansofdeath != "MOD_PROJECTILE_SPLASH") {
        if (!var_503b241b) {
            var_216599c5 = var_ce4361a0.var_b750d1c8;
            var_a2040147 = var_ce4361a0.var_9c192fd2;
        } else {
            weakpoints = namespace_9088c704::function_6c1699d5(self);
            foreach (pointinfo in weakpoints) {
                if (namespace_9088c704::function_4abac7be(pointinfo) === 1 && pointinfo.type === #"armor" && pointinfo.hitloc !== "left_arm_lower") {
                    var_216599c5 = pointinfo;
                    var_a2040147 = 1;
                    break;
                }
            }
        }
        if (isdefined(var_216599c5)) {
            if (var_216599c5.type == #"armor") {
                if (var_a2040147) {
                    if (isdefined(var_216599c5.hitloc)) {
                        armorinfo = self.armorinfo[var_216599c5.hitloc];
                    }
                    if (isdefined(armorinfo)) {
                        self clientfield::set("stoker_fx_start_clientfield", armorinfo.fxindex);
                    }
                    namespace_9088c704::damageweakpoint(var_216599c5, damagedone);
                    var_a9ce36de = 1;
                    bhtnactionstartevent(self, "pain");
                    if (namespace_9088c704::function_4abac7be(var_216599c5) === 3 || var_503b241b && self.var_6f687f49 >= 1000) {
                        if (var_216599c5.var_a9732696) {
                            namespace_9088c704::function_305cc7a5(self, var_216599c5);
                        }
                        if (isdefined(armorinfo.var_1b4e034b) && armorinfo.var_1b4e034b) {
                            self.var_ee64051 = 1;
                            self.var_6f64ed38 = 1;
                        }
                        if (isdefined(armorinfo.var_c7128e64)) {
                            physicsexplosionsphere(self gettagorigin(armorinfo.var_c7128e64), 600, 0, 80, 1, 1);
                            self.var_bbd766ae = 1;
                        }
                        self destructserverutils::handledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, var_216599c5.hitloc, psoffsettime, boneindex, modelindex);
                        if (var_216599c5.hitloc === self.var_8db91380) {
                            if (isdefined(armorinfo.shadervector)) {
                                self clientfield::set("crit_spot_reveal_clientfield", armorinfo.shadervector);
                            }
                            var_fd6ca214 = namespace_9088c704::function_abe2d1e7(self, self.var_8db91380);
                            if (isdefined(var_fd6ca214)) {
                                namespace_9088c704::function_3ad01c52(var_fd6ca214, 1);
                            }
                        }
                    }
                }
            } else if (var_216599c5.hitloc === self.var_8db91380) {
                if (self.var_898a785c) {
                    self.var_ffb76486 += damagedone;
                }
                if (damagedone >= self.health) {
                    self.var_2719861 = 1;
                    self notify(#"hash_4651621237a54fc7");
                }
            }
        }
    }
    if (var_a9ce36de && !var_503b241b) {
        damagedone = 1;
    }
    /#
        function_6cfe460d("<dev string:x55>" + damagedone + "<dev string:x62>" + self.health);
    #/
    return damagedone;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 5, eflags: 0x4
// Checksum 0xffae0bd5, Offset: 0x24d8
// Size: 0xc0
function private function_577439c2(hitloc, point, location, var_945eb73e, tag) {
    var_bde3cd80 = 0;
    if (isdefined(hitloc) && hitloc != "none" && hitloc == location) {
        var_bde3cd80 = 1;
    } else {
        distsq = distancesquared(point, self gettagorigin(tag));
        if (distsq <= var_945eb73e) {
            var_bde3cd80 = 1;
        }
    }
    return var_bde3cd80;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 2, eflags: 0x4
// Checksum 0x6943ede8, Offset: 0x25a0
// Size: 0x86
function private function_b58fd51e(armorinfo, damage) {
    /#
        function_6cfe460d("<dev string:x55>" + damage + "<dev string:x82>" + armorinfo.position);
    #/
    armorinfo.health -= damage;
    if (armorinfo.health <= 0) {
        armorinfo.active = 0;
    }
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 4, eflags: 0x4
// Checksum 0x965ef928, Offset: 0x2630
// Size: 0x220
function private function_df48fbf5(zombie, target, predictedpos, var_3963aee7) {
    if (isdefined(zombie.knockdown) && zombie.knockdown || isdefined(zombie.pushed) && zombie.pushed) {
        return false;
    }
    if (gibserverutils::isgibbed(zombie, 384)) {
        return false;
    }
    checkpos = zombie.origin;
    if (!isactor(target)) {
        checkpos = zombie getcentroid();
        var_3963aee7 = 64;
    }
    var_1f92bfd3 = var_3963aee7 * var_3963aee7;
    distsq = distancesquared(predictedpos, checkpos);
    if (distsq > var_1f92bfd3) {
        return false;
    }
    origin = target.origin;
    facingvec = anglestoforward(target.angles);
    enemyvec = zombie.origin - origin;
    var_c960aec6 = (enemyvec[0], enemyvec[1], 0);
    var_ca23d7da = (facingvec[0], facingvec[1], 0);
    var_c960aec6 = vectornormalize(var_c960aec6);
    var_ca23d7da = vectornormalize(var_ca23d7da);
    enemydot = vectordot(var_ca23d7da, var_c960aec6);
    if (enemydot < 0) {
        return false;
    }
    return true;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0xa0f55d42, Offset: 0x2858
// Size: 0x2a6
function private function_5bb3ceea(behaviortreeentity) {
    if (behaviortreeentity getblackboardattribute("_locomotion_speed") === "locomotion_speed_sprint" || behaviortreeentity.var_bbd766ae) {
        var_9c88d71f = "knockdown";
    } else {
        var_9c88d71f = "push";
    }
    var_3963aee7 = behaviortreeentity ai::function_a0dbf10a().var_d2f7a3b;
    if (behaviortreeentity.var_bbd766ae) {
        var_3963aee7 = behaviortreeentity ai::function_a0dbf10a().var_a8fd3e76;
    }
    velocity = behaviortreeentity getvelocity();
    velocitymag = length(velocity);
    predicttime = 0.2;
    movevector = velocity * predicttime;
    predictedpos = behaviortreeentity.origin + movevector;
    zombiesarray = getaiarchetypearray("zombie");
    zombiesarray = arraycombine(zombiesarray, getaiarchetypearray("catalyst"), 0, 0);
    var_80122108 = array::filter(zombiesarray, 0, &function_df48fbf5, behaviortreeentity, predictedpos, var_3963aee7);
    if (var_80122108.size > 0) {
        foreach (zombie in var_80122108) {
            if (var_9c88d71f == "knockdown") {
                zombie zombie_utility::setup_zombie_knockdown(behaviortreeentity);
                zombie.knockdown_type = "knockdown_shoved";
                continue;
            }
            zombie zombie_utility::function_903ad164(behaviortreeentity);
        }
    }
    behaviortreeentity.var_bbd766ae = 0;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x361838bb, Offset: 0x2b08
// Size: 0x130
function private function_79c37ddb(entity) {
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (entity.var_b6c9a295 > gettime()) {
        return false;
    }
    meleedistsq = 4096;
    if (isdefined(entity.meleeweapon) && entity.meleeweapon !== level.weaponnone) {
        meleedistsq = entity.meleeweapon.aimeleerange * entity.meleeweapon.aimeleerange;
    }
    var_2f4cf7e8 = distancesquared(entity.origin, entity.enemy.origin);
    if (var_2f4cf7e8 <= meleedistsq) {
        return false;
    }
    if (var_2f4cf7e8 > entity ai::function_a0dbf10a().var_f33892b3 * entity ai::function_a0dbf10a().var_f33892b3) {
        return false;
    }
    return true;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0xab4f8f03, Offset: 0x2c40
// Size: 0x52
function private function_36dd6304(distance) {
    if (isdefined(self.enemy)) {
        return (distancesquared(self.origin, self.enemy.origin) > distance * distance);
    }
    return false;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x2626f023, Offset: 0x2ca0
// Size: 0x16
function private function_d3f86041(entity) {
    return entity.var_6f64ed38;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x563d584d, Offset: 0x2cc0
// Size: 0x3e
function private function_c163e36(entity) {
    /#
        if (entity.var_7412a25) {
            function_6cfe460d("<dev string:x93>");
        }
    #/
    return entity.var_7412a25;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0xe04503b6, Offset: 0x2d08
// Size: 0x2c
function private function_211b1627(entity) {
    return entity.var_b590f641 && function_7bc2031b(entity);
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x1c2331a9, Offset: 0x2d40
// Size: 0x44
function private function_d097fef0(entity) {
    return !entity.var_7412a25 && entity.var_b590f641 && function_7bc2031b(entity);
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x5b601ccd, Offset: 0x2d90
// Size: 0x2c
function private function_3463afb0(entity) {
    return entity.var_b590f641 && function_7bc2031b(entity);
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0xb1494e3, Offset: 0x2dc8
// Size: 0x2c
function private function_501774fa(entity) {
    /#
        function_6cfe460d("<dev string:xb8>");
    #/
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0xe9ee5c3, Offset: 0x2e00
// Size: 0x4c
function private function_2bc5cb12(entity) {
    /#
        function_6cfe460d("<dev string:xd9>");
    #/
    entity.var_6f64ed38 = 0;
    stokerchargeattack(entity);
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x3916a3bc, Offset: 0x2e58
// Size: 0x2c
function private function_83e86365(entity) {
    /#
        function_6cfe460d("<dev string:x115>");
    #/
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x7cd6b079, Offset: 0x2e90
// Size: 0x2c
function private function_902e2137(entity) {
    /#
        function_6cfe460d("<dev string:x12e>");
    #/
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x895471af, Offset: 0x2ec8
// Size: 0x2c
function private function_f9df2d5a(entity) {
    /#
        function_6cfe460d("<dev string:x14d>");
    #/
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x96e2a829, Offset: 0x2f00
// Size: 0x3a
function private function_f19132a9(entity) {
    /#
        function_6cfe460d("<dev string:x16c>");
    #/
    entity.var_b590f641 = 0;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x194303c6, Offset: 0x2f48
// Size: 0x3a
function private function_54e33fb(entity) {
    /#
        function_6cfe460d("<dev string:x184>");
    #/
    entity.var_7412a25 = 0;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0xc63edc16, Offset: 0x2f90
// Size: 0x1a
function private function_eb852bc0(entity) {
    entity.var_8da38a91 = 1;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x36d61e18, Offset: 0x2fb8
// Size: 0x16
function private function_3913b693(entity) {
    entity.var_8da38a91 = undefined;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x2a549ff5, Offset: 0x2fd8
// Size: 0x54
function private function_6c21e821(entity) {
    if (self.var_ffb76486 >= entity ai::function_a0dbf10a().var_d514dc5a) {
        /#
            function_6cfe460d("<dev string:x1a2>");
        #/
        return true;
    }
    return false;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 2, eflags: 0x4
// Checksum 0x3535e195, Offset: 0x3038
// Size: 0x38
function private function_eb160b2d(entity, asmstatename) {
    if (entity ai::is_stunned()) {
        return 5;
    }
    return 4;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0xc9af370f, Offset: 0x3078
// Size: 0x44
function private function_fffc1cef(entity) {
    /#
        function_6cfe460d("<dev string:x1d6>");
    #/
    function_3f86cdb(entity);
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x935057b9, Offset: 0x30c8
// Size: 0x74
function private function_3f86cdb(entity) {
    entity.var_898a785c = 0;
    entity.var_6f64ed38 = 0;
    entity.var_ffb76486 = 0;
    entity setblackboardattribute("_locomotion_speed", self.var_28a9ba84);
    entity clientfield::set("stoker_fx_stop_clientfield", 2);
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x7dee8669, Offset: 0x3148
// Size: 0x9c
function private stokerchargeattack(entity) {
    entity.var_898a785c = 1;
    if (entity.var_d6857fc) {
        entity.var_d6857fc = 0;
    } else {
        entity.var_58dad78d = "stoker_charge_attack";
    }
    entity.lastattacktime = gettime();
    entity setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
    entity clientfield::set("stoker_fx_start_clientfield", 2);
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0xee46c84c, Offset: 0x31f0
// Size: 0x46
function private stokerrangedattack(entity) {
    entity.var_7412a25 = 1;
    entity.var_b590f641 = 1;
    self.var_58dad78d = "stoker_ranged_attack";
    entity.lastattacktime = gettime();
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x6aeee1ab, Offset: 0x3240
// Size: 0x7e
function private function_832a2775(entity) {
    if (!isdefined(entity.enemy)) {
        return false;
    }
    return distancesquared(entity.origin, entity.enemy.origin) <= entity ai::function_a0dbf10a().var_c970e6f0 * entity ai::function_a0dbf10a().var_c970e6f0;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x7056b9df, Offset: 0x32c8
// Size: 0x82
function private function_7bc2031b(entity) {
    if (!isdefined(entity.enemy)) {
        return 0;
    }
    can_see = bullettracepassed(entity.origin + (0, 0, 36), entity.enemy.origin + (0, 0, 36), 0, undefined);
    return can_see;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x8a616aec, Offset: 0x3358
// Size: 0x3a
function private function_26dc6230(entity) {
    if (isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area) {
        return 1;
    }
    return zm_behavior::zombieenteredplayable(entity);
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0xaff7ac6f, Offset: 0x33a0
// Size: 0x28c
function private function_fdd73484(entity) {
    timeelapsed = gettime() - entity.lastattacktime;
    if (entity.var_898a785c && timeelapsed > entity ai::function_a0dbf10a().var_c14e3843) {
        /#
            function_6cfe460d("<dev string:x1ec>");
        #/
        function_3f86cdb(entity);
    }
    if (entity.var_d6857fc) {
        /#
            function_6cfe460d("<dev string:x21e>");
        #/
        entity.var_6f64ed38 = 1;
        return;
    }
    if (timeelapsed > getdvarint(#"hash_3dfb66f92268c90f", entity ai::function_a0dbf10a().var_5bfd9af0)) {
        if (timeelapsed > entity ai::function_a0dbf10a().var_328fa25c && entity.var_58dad78d == "stoker_ranged_attack" && isdefined(entity.var_abbcbd32) && entity.var_abbcbd32 <= entity ai::function_a0dbf10a().var_5e68cd78 * entity ai::function_a0dbf10a().var_5e68cd78) {
            entity.var_6f64ed38 = 1;
            return;
        }
        if (!entity.var_b590f641 && !entity.var_6f64ed38 && isdefined(entity getblackboardattribute("_locomotion_speed")) && entity getblackboardattribute("_locomotion_speed") != "locomotion_speed_sprint" && function_7bc2031b(entity) && !entity.var_ee64051 && function_832a2775(entity)) {
            /#
                function_6cfe460d("<dev string:x26e>");
            #/
            stokerrangedattack(entity);
        }
    }
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x0
// Checksum 0x391ffbe7, Offset: 0x3638
// Size: 0x466
function function_eeda011d(entity) {
    if (!isactor(entity) || !isdefined(entity.enemy)) {
        return;
    }
    targetpos = entity.enemy.origin;
    launchpos = entity gettagorigin("j_wrist_le");
    var_2d64b2a4 = entity ai::function_a0dbf10a().var_d59abbfd;
    if (distancesquared(targetpos, entity.origin) > entity ai::function_a0dbf10a().var_ea510b73 * entity ai::function_a0dbf10a().var_ea510b73) {
        velocity = entity.enemy getvelocity();
        targetpos += velocity * entity ai::function_a0dbf10a().var_a3de5dc5;
        var_e725c1db = math::randomsign() * randomint(var_2d64b2a4);
        var_c1234772 = math::randomsign() * randomint(var_2d64b2a4);
        targetpos += (var_e725c1db, var_c1234772, 0);
        speed = length(velocity);
        if (speed > 0) {
            var_2b54656 = vectornormalize((targetpos[0], targetpos[1], 0) - (launchpos[0], launchpos[1], 0));
            dot = vectordot(-1 * var_2b54656, velocity / speed);
            if (dot >= entity ai::function_a0dbf10a().var_f01ec28c) {
                targetpos += var_2b54656 * dot * speed * entity ai::function_a0dbf10a().var_63b1071b;
            }
        }
    }
    targetpos += (0, 0, entity ai::function_a0dbf10a().var_dda2fc1c);
    var_776a8e76 = vectortoangles(targetpos - launchpos);
    angles = function_79fc4987(launchpos, targetpos, entity ai::function_a0dbf10a().var_49724b5b, getdvarfloat(#"bg_lowgravity", 0));
    if (isdefined(angles) && angles[#"lowangle"] > 0) {
        dir = anglestoforward((-1 * angles[#"lowangle"], var_776a8e76[1], var_776a8e76[2]));
    } else {
        dir = anglestoforward(var_776a8e76);
    }
    velocity = dir * entity ai::function_a0dbf10a().var_49724b5b;
    grenade = entity magicgrenadetype(getweapon("stoker_coal_bomb"), launchpos, velocity);
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 10, eflags: 0x0
// Checksum 0xbf5dd4ee, Offset: 0x3aa8
// Size: 0x19e
function function_ad481f6d(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    if (isdefined(eattacker) && isai(eattacker) && eattacker.archetype == "stoker" && eattacker.team != self.team) {
        if (smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_BURNED") {
            eattacker.var_d6857fc = 1;
        }
        if (weapon == getweapon(#"stoker_melee") && isdefined(einflictor.var_8da38a91) && einflictor.var_8da38a91) {
            idamage = 150;
        }
        if (weapon == getweapon(#"stoker_coal_bomb")) {
            burnplayer::setplayerburning(1, 1, 1, eattacker, weapon);
        }
        return idamage;
    }
    return -1;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x23bf9f79, Offset: 0x3c50
// Size: 0x1a
function private function_d550c344(entity) {
    entity.var_196e66e2 = 1;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0xdb8d0378, Offset: 0x3c78
// Size: 0x3e
function private function_40342b0f(entity) {
    entity.var_196e66e2 = undefined;
    entity.var_b6c9a295 = gettime() + entity ai::function_a0dbf10a().var_7eefbbdc;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 3, eflags: 0x0
// Checksum 0x225b2d75, Offset: 0x3cc0
// Size: 0xa8
function function_d805e66c(spawner, s_spot, var_dd27ad33) {
    ai_stoker = zombie_utility::spawn_zombie(level.a_sp_stoker[0], "stoker", s_spot, var_dd27ad33);
    if (isdefined(ai_stoker)) {
        ai_stoker.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
        ai_stoker thread zombie_utility::round_spawn_failsafe();
        ai_stoker thread function_197bfd6b(s_spot);
    }
    return ai_stoker;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x0
// Checksum 0x552c96f0, Offset: 0x3d70
// Size: 0x54
function function_197bfd6b(s_spot) {
    if (isdefined(level.var_329735e3)) {
        self thread [[ level.var_329735e3 ]](s_spot);
    }
    if (isdefined(level.var_67132dac)) {
        self thread [[ level.var_67132dac ]]();
    }
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 0, eflags: 0x0
// Checksum 0xd3e75798, Offset: 0x3dd0
// Size: 0x100
function function_1b8f4007() {
    level.a_sp_stoker = getentarray("zombie_stoker_spawner", "script_noteworthy");
    if (level.a_sp_stoker.size == 0) {
        assertmsg("<dev string:x287>");
        return;
    }
    foreach (sp_stoker in level.a_sp_stoker) {
        sp_stoker.is_enabled = 1;
        sp_stoker.script_forcespawn = 1;
        sp_stoker spawner::add_spawn_function(&stoker_init);
    }
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 0, eflags: 0x0
// Checksum 0x56ee7218, Offset: 0x3ed8
// Size: 0x5c
function stoker_init() {
    self function_ff6c3008();
    self zm_score::function_c4374c52();
    self.var_f197caf2 = 3;
    level thread zm_spawner::zombie_death_event(self);
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 12, eflags: 0x4
// Checksum 0x6690d147, Offset: 0x3f40
// Size: 0xaa
function private function_2ef8b23e(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (isdefined(attacker) && attacker.archetype === "stoker" && self.team === attacker.team) {
        return 0;
    }
    return -1;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0xd50b3807, Offset: 0x3ff8
// Size: 0xac
function private killed_callback(e_attacker) {
    if (self.archetype != "stoker") {
        return;
    }
    self val::set(#"stoker_death", "takedamage", 0);
    if (!isplayer(e_attacker)) {
        return;
    }
    e_attacker util::delay(1.5, "death", &zm_audio::create_and_play_dialog, "kill", "stoker");
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 3, eflags: 0x0
// Checksum 0xda9c9c68, Offset: 0x40b0
// Size: 0x230
function spawn_single(b_force_spawn = 0, var_b7959229, var_dd27ad33) {
    if (!b_force_spawn && !function_cbf550e2()) {
        return undefined;
    }
    if (isdefined(var_b7959229)) {
        s_spawn_loc = var_b7959229;
    } else if (isdefined(level.var_e777f0b0)) {
        s_spawn_loc = [[ level.var_e777f0b0 ]]();
    } else if (level.zm_loc_types[#"stoker_location"].size > 0) {
        s_spawn_loc = array::random(level.zm_loc_types[#"stoker_location"]);
    }
    if (!isdefined(s_spawn_loc)) {
        /#
            if (getdvarint(#"hash_1f8efa579fee787c", 0)) {
                iprintlnbold("<dev string:x2cf>");
            }
        #/
        return undefined;
    }
    ai = function_d805e66c(level.a_sp_stoker[0], undefined, var_dd27ad33);
    if (isdefined(ai)) {
        ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
        if (isdefined(level.var_6d361192)) {
            ai thread [[ level.var_6d361192 ]](s_spawn_loc);
        }
        ai playsound(#"hash_63299a75a97f9678");
        bhtnactionstartevent(ai, "spawn");
        self util::delay(3, "death", &zm_audio::function_709246c9, "stoker", "cue_react");
    }
    return ai;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 0, eflags: 0x0
// Checksum 0xcbecf9c5, Offset: 0x42e8
// Size: 0xbc
function function_cbf550e2() {
    var_9a24812c = function_1c9d506();
    var_4aae053d = function_f60a715b();
    if (!(isdefined(level.var_2a40757c) && level.var_2a40757c) && (isdefined(level.var_ae44635d) && level.var_ae44635d || var_9a24812c >= var_4aae053d || !level flag::get("spawn_zombies"))) {
        return false;
    }
    return true;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 0, eflags: 0x0
// Checksum 0xd03623ac, Offset: 0x43b0
// Size: 0x8a
function function_f60a715b() {
    switch (level.players.size) {
    case 1:
        return 1;
    case 2:
        return 2;
    case 3:
        return 2;
    case 4:
        return 3;
    }
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x0
// Checksum 0x91fe5a34, Offset: 0x4448
// Size: 0x1aa
function function_f56566ae(n_round_number) {
    level endon(#"end_game");
    if (!isdefined(level.var_2e5ca0fa)) {
        level.var_2e5ca0fa = 0;
    }
    /#
        switch (level.round_number - n_round_number) {
        case 0:
            break;
        case 1:
        case 2:
            level.var_2e5ca0fa++;
            break;
        case 3:
        case 4:
            level.var_2e5ca0fa += 2;
            break;
        default:
            level.var_2e5ca0fa = undefined;
            return;
        }
    #/
    while (true) {
        level waittill(#"hash_5d3012139f083ccb");
        if (zm_round_spawning::function_f172115b("stoker")) {
            level.var_2e5ca0fa++;
            if (level.var_2e5ca0fa == 3) {
                level.var_2e5ca0fa = undefined;
                level.var_c1515e17 = undefined;
                return;
            }
            level.var_c1515e17 = level.round_number + randomintrangeinclusive(1, 2);
        }
    }
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x0
// Checksum 0xaa14d0c6, Offset: 0x4600
// Size: 0x1da
function function_d6862794(var_e14d9cae) {
    var_13385fd5 = int(floor(var_e14d9cae / 100));
    if (isdefined(level.var_c1515e17) && level.round_number < level.var_c1515e17) {
        return 0;
    }
    if (level.players.size == 1) {
        var_c33c4ac6 = 1 + max(0, floor((level.round_number - zombie_utility::get_zombie_var(#"hash_2374f3ef775ac2c3")) / 4));
    } else {
        var_c33c4ac6 = 1 + max(0, floor((level.round_number - zombie_utility::get_zombie_var(#"hash_3b4ad7449c039d1b")) / 3));
    }
    var_9a3561d4 = var_c33c4ac6 < 8 ? max(var_c33c4ac6 - 3, 0) : var_c33c4ac6 * 0.75;
    return randomintrangeinclusive(int(var_9a3561d4), int(min(var_13385fd5, var_c33c4ac6)));
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 0, eflags: 0x0
// Checksum 0x5ba098f1, Offset: 0x47e8
// Size: 0x3c
function round_spawn() {
    ai = spawn_single();
    if (isdefined(ai)) {
        level.zombie_total--;
        return true;
    }
    return false;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 0, eflags: 0x0
// Checksum 0x6c28e86, Offset: 0x4830
// Size: 0xb4
function function_1c9d506() {
    var_343e0bac = getaiarchetypearray("stoker");
    var_9a24812c = var_343e0bac.size;
    foreach (ai_stoker in var_343e0bac) {
        if (!isalive(ai_stoker)) {
            var_9a24812c--;
        }
    }
    return var_9a24812c;
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 0, eflags: 0x4
// Checksum 0x3919243e, Offset: 0x48f0
// Size: 0xc0
function private function_25edafe() {
    var_e827c152 = spawn_single(1);
    spawn_success = isdefined(var_e827c152);
    var_f5dd4ce8 = isdefined(level.var_831bfaed[#"stoker"]) && level.var_831bfaed[#"stoker"].size > 0;
    if (spawn_success && var_f5dd4ce8) {
        array::pop_front(level.var_831bfaed[#"stoker"], 1);
    }
    return spawn_success;
}

/#

    // Namespace zm_ai_stoker/zm_ai_stoker
    // Params 0, eflags: 0x4
    // Checksum 0x89964e28, Offset: 0x49b8
    // Size: 0x6c
    function private function_ad50378a() {
        level flagsys::wait_till("<dev string:x2fe>");
        zm_devgui::add_custom_devgui_callback(&function_bcdab63a);
        spawner::add_archetype_spawn_function("<dev string:x4e>", &function_df7bd084);
    }

    // Namespace zm_ai_stoker/zm_ai_stoker
    // Params 0, eflags: 0x4
    // Checksum 0xa6b1bb38, Offset: 0x4a30
    // Size: 0xb2
    function private function_df7bd084() {
        if (isdefined(level.var_4a79beaa) && level.var_4a79beaa) {
            return;
        }
        adddebugcommand("<dev string:x317>" + getdvarint(#"hash_3dfb66f92268c90f", self ai::function_a0dbf10a().var_5bfd9af0) + "<dev string:x33a>");
        adddebugcommand("<dev string:x344>");
        level.var_4a79beaa = 1;
    }

    // Namespace zm_ai_stoker/zm_ai_stoker
    // Params 1, eflags: 0x4
    // Checksum 0x2b5c2447, Offset: 0x4af0
    // Size: 0x270
    function private function_bcdab63a(cmd) {
        if (cmd == "<dev string:x389>") {
            player = level.players[0];
            v_direction = player getplayerangles();
            v_direction = anglestoforward(v_direction) * 8000;
            eye = player geteye();
            trace = bullettrace(eye, eye + v_direction, 0, undefined);
            var_feba5c63 = positionquery_source_navigation(trace[#"position"], 128, 256, 128, 20);
            s_spot = spawnstruct();
            if (isdefined(var_feba5c63) && var_feba5c63.data.size > 0) {
                s_spot.origin = var_feba5c63.data[0].origin;
            } else {
                s_spot.origin = player.origin;
            }
            s_spot.angles = (0, player.angles[1] - 180, 0);
            spawn_single(1, s_spot);
            return 1;
        }
        if (cmd == "<dev string:x396>") {
            stokers = getaiarchetypearray("<dev string:x4e>");
            foreach (stoker in stokers) {
                stoker kill();
            }
        }
    }

    // Namespace zm_ai_stoker/zm_ai_stoker
    // Params 0, eflags: 0x0
    // Checksum 0xbf26859b, Offset: 0x4d68
    // Size: 0x48
    function update_dvars() {
        while (true) {
            level.stokerdebug = getdvarint(#"scr_stokerdebug", 0);
            wait 1;
        }
    }

    // Namespace zm_ai_stoker/zm_ai_stoker
    // Params 1, eflags: 0x0
    // Checksum 0xf4334e5a, Offset: 0x4db8
    // Size: 0x44
    function function_6cfe460d(message) {
        if (isdefined(level.stokerdebug)) {
            println("<dev string:x3a6>" + message);
        }
    }

#/
