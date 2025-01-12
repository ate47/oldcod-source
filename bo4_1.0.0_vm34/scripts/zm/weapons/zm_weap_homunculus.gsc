#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_clone;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_weap_homunculus;

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x2
// Checksum 0x186badda, Offset: 0x358
// Size: 0x54
function autoexec __init__system__() {
    system::register(#"zm_weap_homunculus", &__init__, &__main__, #"zm_weapons");
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x0
// Checksum 0x630b7f67, Offset: 0x3b8
// Size: 0x9c
function __init__() {
    clientfield::register("scriptmover", "" + #"hash_2d49d2cf3d339e18", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_32c5838be960cfee", 1, 1, "int");
    zm_loadout::register_lethal_grenade_for_level("homunculus");
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x0
// Checksum 0xa3b237b1, Offset: 0x460
// Size: 0x114
function __main__() {
    level.var_9dcd2af2 = getweapon("homunculus");
    level.var_72b70a4d = getweapon("homunculus");
    if (!function_10e9398f()) {
        return;
    }
    level._effect[#"grenade_samantha_steal"] = #"zombie/fx_monkey_lightning_zmb";
    zm_weapons::register_zombie_weapon_callback(level.var_9dcd2af2, &function_549ac790);
    zm_weapons::register_zombie_weapon_callback(level.var_72b70a4d, &function_a505f3d3);
    level.a_homunculus = [];
    level scene::add_scene_func("aib_t8_zm_zod_homunculus_jump_up_01", &function_85701535);
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x0
// Checksum 0xccfbea01, Offset: 0x580
// Size: 0x24
function function_a505f3d3() {
    self function_549ac790("homunculus_upgraded");
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 1, eflags: 0x0
// Checksum 0x6dd8e7cb, Offset: 0x5b0
// Size: 0x34
function function_549ac790(str_weapon = "homunculus") {
    self thread function_52f93805();
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x0
// Checksum 0x821cb804, Offset: 0x5f0
// Size: 0x110
function function_52f93805() {
    self notify(#"hash_1be04d3f01032827");
    self endon(#"death", #"hash_1be04d3f01032827");
    var_d78038f4 = level.var_d9e0b39e;
    if (!isdefined(var_d78038f4)) {
        var_d78038f4 = 16;
    }
    num_attractors = level.num_monkey_attractors;
    if (!isdefined(num_attractors)) {
        var_1f293144 = 32;
    }
    max_attract_dist = level.monkey_attract_dist;
    if (!isdefined(max_attract_dist)) {
        var_b045a027 = 1024;
    }
    while (true) {
        e_grenade = function_86960ffe();
        if (isdefined(e_grenade)) {
            self thread function_f8725295(e_grenade, var_1f293144, var_b045a027, var_d78038f4);
        }
    }
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x0
// Checksum 0x19dd7796, Offset: 0x708
// Size: 0xfa
function function_86960ffe() {
    self endon(#"death", #"hash_1be04d3f01032827");
    while (true) {
        waitresult = self waittill(#"grenade_fire");
        if (waitresult.weapon == level.var_9dcd2af2 || waitresult.weapon == level.var_72b70a4d) {
            waitresult.projectile.use_grenade_special_long_bookmark = 1;
            waitresult.projectile.grenade_multiattack_bookmark_count = 1;
            waitresult.projectile.weapon = waitresult.weapon;
            waitresult.projectile.thrower = self;
            return waitresult.projectile;
        }
        waitframe(1);
    }
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 4, eflags: 0x0
// Checksum 0x4977425b, Offset: 0x810
// Size: 0x6fc
function function_f8725295(e_grenade, var_1f293144, var_b045a027, var_d78038f4) {
    self endon(#"death", #"hash_1be04d3f01032827");
    e_grenade endoncallback(&function_7382789f, #"death");
    e_grenade flag::init("stop_following_humonculus");
    if (self laststand::player_is_in_laststand()) {
        if (isdefined(e_grenade.damagearea)) {
            e_grenade.damagearea delete();
        }
        e_grenade delete();
        return;
    }
    var_5c0eff73 = e_grenade.weapon == level.var_72b70a4d;
    e_grenade ghost();
    e_grenade.angles = self.angles;
    e_grenade.mdl_anchor = util::spawn_model("c_t8_zmb_homunculus_fb1", e_grenade.origin, e_grenade.angles);
    e_grenade.mdl_anchor linkto(e_grenade);
    e_grenade.var_4b3efb6 = 0;
    if (math::cointoss() && math::cointoss()) {
        e_grenade thread function_b8bd483("vox_homu_homun_throw_" + randomintrangeinclusive(0, 5));
        e_grenade.var_4b3efb6 = 1;
    } else {
        e_grenade.mdl_anchor playsoundontag("vox_homu_homun_throw_exert_" + randomintrangeinclusive(0, 2), "j_head");
    }
    e_grenade.mdl_anchor thread scene::play("aib_t8_zm_zod_homunculus_throw_loop_01", e_grenade.mdl_anchor);
    waitresult = e_grenade waittill(#"stationary");
    e_grenade.var_2d563959 = 0;
    e_grenade.mdl_anchor clientfield::set("" + #"hash_32c5838be960cfee", 1);
    e_grenade resetmissiledetonationtime(30);
    e_grenade is_on_navmesh();
    var_bc1994bd = zm_utility::check_point_in_enabled_zone(e_grenade.origin, undefined, undefined);
    if (var_bc1994bd && e_grenade.var_4ff05f89) {
        if (math::cointoss() && math::cointoss() && !e_grenade.var_4b3efb6) {
            e_grenade thread function_b8bd483("vox_homu_homun_land_" + randomintrangeinclusive(0, 4));
            e_grenade.var_2d563959 = 1;
        } else {
            e_grenade.mdl_anchor playsoundontag("vox_homu_homun_land_exert_" + randomintrangeinclusive(0, 7), "j_head");
        }
        e_grenade.mdl_anchor unlink();
        e_grenade thread function_de09da63(e_grenade.mdl_anchor);
        e_grenade.mdl_anchor function_704217d1();
        wait 0.1;
        e_grenade zm_utility::create_zombie_point_of_interest(var_b045a027, var_1f293144, 10000);
        var_bc1994bd = e_grenade zm_utility::create_zombie_point_of_interest_attractor_positions(undefined, undefined, 128);
        if (var_bc1994bd) {
            e_grenade.var_edbeb246 = util::spawn_model("tag_origin", e_grenade.mdl_anchor.origin, e_grenade.mdl_anchor.angles);
            e_grenade.mdl_anchor linkto(e_grenade.var_edbeb246);
            e_grenade thread sndattackvox();
            e_grenade thread function_fd1e0f67();
            level.a_homunculus[level.a_homunculus.size] = e_grenade;
            if (!(isdefined(e_grenade.var_2d563959) && e_grenade.var_2d563959)) {
                e_grenade thread function_b6e2b3e8();
            }
            e_grenade function_cd84f4f8(1);
            e_grenade.mdl_anchor scene::stop();
            e_grenade.var_edbeb246 scene::play("aib_t8_zm_zod_homunculus_deploy_01", e_grenade.mdl_anchor);
            e_grenade.var_edbeb246 scene::stop();
            e_grenade notify(#"hash_3e410dbcd9e66000");
            e_grenade thread function_244e56b5(var_b045a027, var_1f293144, var_d78038f4);
        } else {
            e_grenade zm_utility::deactivate_zombie_point_of_interest();
            e_grenade.script_noteworthy = undefined;
            level thread grenade_stolen_by_sam(e_grenade);
        }
        return;
    }
    e_grenade.script_noteworthy = undefined;
    e_grenade function_b8bd483("vox_homu_homun_out_bounds_" + randomintrangeinclusive(0, 4));
    level thread grenade_stolen_by_sam(e_grenade);
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x0
// Checksum 0x70838804, Offset: 0xf18
// Size: 0x98
function function_b6e2b3e8() {
    self endon(#"death", #"hash_3e410dbcd9e66000");
    while (true) {
        waitresult = self.mdl_anchor waittill(#"snddeployvox");
        if (isdefined(waitresult.str_alias)) {
            self.mdl_anchor playsoundontag(waitresult.str_alias, "j_head");
        }
    }
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 1, eflags: 0x0
// Checksum 0x859ab5e1, Offset: 0xfb8
// Size: 0x5c
function function_7382789f(str_notify) {
    if (isdefined(self.mdl_anchor)) {
        self.mdl_anchor delete();
    }
    if (isdefined(self.var_edbeb246)) {
        self.var_edbeb246 delete();
    }
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 1, eflags: 0x0
// Checksum 0xf74ada99, Offset: 0x1020
// Size: 0x15e
function function_48d269e2(grenade) {
    mdl_anchor = grenade.mdl_anchor;
    while (!grenade flag::get("stop_following_humonculus")) {
        a_zombies = zombie_utility::get_zombie_array();
        foreach (zombie in a_zombies) {
            zombie.n_zombie_custom_goal_radius = 8;
            zombie.v_zombie_custom_goal_pos = mdl_anchor.origin;
        }
        waitframe(1);
    }
    a_zombies = zombie_utility::get_zombie_array();
    foreach (zombie in a_zombies) {
        zombie.v_zombie_custom_goal_pos = undefined;
    }
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x0
// Checksum 0x7654369f, Offset: 0x1188
// Size: 0x148
function get_zombie_targets() {
    self endon(#"death");
    a_ai_zombies = array::get_all_closest(self.origin, getaispeciesarray(level.zombie_team, "all"), undefined, 32, 175);
    var_272cc6d0 = [];
    foreach (ai_zombie in a_ai_zombies) {
        if (zm_utility::check_point_in_playable_area(ai_zombie.origin)) {
            if (!isdefined(var_272cc6d0)) {
                var_272cc6d0 = [];
            } else if (!isarray(var_272cc6d0)) {
                var_272cc6d0 = array(var_272cc6d0);
            }
            var_272cc6d0[var_272cc6d0.size] = ai_zombie;
        }
    }
    return var_272cc6d0;
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 1, eflags: 0x0
// Checksum 0xccceec6, Offset: 0x12d8
// Size: 0xfe
function function_477205e(ai_zombie) {
    self endon(#"death");
    ai_zombie endon(#"death");
    if (!zm_utility::check_point_in_playable_area(ai_zombie.origin) || isdefined(ai_zombie.var_d79ef6e3) && ai_zombie.var_d79ef6e3) {
        return false;
    }
    n_dist_sq = distancesquared(self.origin, ai_zombie.origin);
    if (n_dist_sq <= 30625) {
        if (bullettracepassed(self.mdl_anchor.origin, ai_zombie getcentroid(), 0, self.mdl_anchor, ai_zombie)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 3, eflags: 0x0
// Checksum 0x3b7dd02a, Offset: 0x13e0
// Size: 0x38e
function function_244e56b5(var_b045a027, var_1f293144, var_d78038f4) {
    self endon(#"death", #"explode");
    b_first_loop = 1;
    while (true) {
        b_attacked = 0;
        while (true) {
            a_ai_zombies = self get_zombie_targets();
            if (!a_ai_zombies.size) {
                if (b_attacked) {
                    b_first_loop = undefined;
                    wait 0.1;
                    self function_cd84f4f8();
                    break;
                } else if (isdefined(b_first_loop) && b_first_loop) {
                    b_first_loop = undefined;
                    break;
                } else {
                    wait 0.1;
                    continue;
                }
            }
            for (i = 0; i < a_ai_zombies.size; i++) {
                if (isalive(a_ai_zombies[i]) && self function_477205e(a_ai_zombies[i])) {
                    self function_ca53f6e(a_ai_zombies[i]);
                    if (!b_attacked) {
                        b_attacked = 1;
                        self.var_edbeb246 scene::stop();
                        if (math::cointoss() && math::cointoss()) {
                            self thread function_b8bd483("vox_homu_homun_jump_" + randomintrangeinclusive(0, 5));
                        }
                        self.var_edbeb246 scene::play("aib_t8_zm_zod_homunculus_jump_up_01", self.mdl_anchor);
                        self.var_edbeb246 thread scene::play("aib_t8_zm_zod_homunculus_attack_01", self.mdl_anchor);
                    }
                    if (isalive(a_ai_zombies[i])) {
                        n_dist = distancesquared(self.origin, a_ai_zombies[i].origin);
                        n_time = n_dist / 48400;
                        n_time *= 0.5;
                        self.var_edbeb246 function_bfe47c6c(a_ai_zombies[i], n_time, self.thrower, self);
                    }
                }
                waitframe(1);
            }
        }
        self.var_edbeb246 thread scene::play("aib_t8_zm_zod_homunculus_idle_01", self.mdl_anchor);
        self zm_utility::deactivate_zombie_point_of_interest();
        wait 0.1;
        self zm_utility::create_zombie_point_of_interest(var_b045a027, var_1f293144, 10000);
        self zm_utility::create_zombie_point_of_interest_attractor_positions(undefined, undefined, 128);
        waitframe(1);
    }
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 1, eflags: 0x0
// Checksum 0x8107e5fc, Offset: 0x1778
// Size: 0x9c
function function_ca53f6e(ai_zombie) {
    v_dir = vectornormalize(ai_zombie.origin - self.origin);
    v_dir = (v_dir[0], v_dir[1], 0);
    v_angles = vectortoangles(v_dir);
    self.var_edbeb246 rotateto(v_angles, 0.15);
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 1, eflags: 0x0
// Checksum 0xb4a5f4d8, Offset: 0x1820
// Size: 0xac
function function_85701535(var_8c4b44d4) {
    var_8c4b44d4[#"homunculus"] endon(#"death");
    var_8c4b44d4[#"homunculus"] waittill(#"jumped");
    var_edbeb246 = var_8c4b44d4[#"homunculus"] getlinkedent();
    var_edbeb246 movez(40, 0.35);
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 2, eflags: 0x0
// Checksum 0xc1fc1932, Offset: 0x18d8
// Size: 0x1a2
function function_acf8ebff(e_player, e_grenade) {
    switch (self.var_29ed62b2) {
    case #"popcorn":
    case #"basic":
        self function_c75436ca();
        self playsound(#"hash_3a99f739009a77fa");
        if (math::cointoss() && math::cointoss()) {
            e_grenade thread function_b8bd483("vox_homu_homun_kill_" + randomintrangeinclusive(0, 6));
        }
        self dodamage(self.health, self.origin, e_player, undefined, undefined, "MOD_UNKNOWN", 0, level.var_9dcd2af2);
        break;
    case #"heavy":
    case #"miniboss":
        n_damage = level.round_number * 100;
        self dodamage(n_damage, self.origin, e_player, undefined, undefined, "MOD_UNKNOWN", 0, level.var_9dcd2af2);
        break;
    }
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 4, eflags: 0x0
// Checksum 0x8877d9ed, Offset: 0x1a88
// Size: 0x15a
function function_bfe47c6c(ai_zombie, n_time, e_player, e_grenade) {
    self movez(16, n_time);
    self waittill(#"movedone");
    if (isalive(ai_zombie)) {
        ai_zombie.var_d79ef6e3 = 1;
        v_target = ai_zombie gettagorigin("j_head");
        if (!isdefined(v_target)) {
            v_target = ai_zombie getcentroid() + (0, 0, 16);
        }
        self moveto(v_target, n_time);
        self waittill(#"movedone");
        if (isalive(ai_zombie)) {
            ai_zombie function_acf8ebff(e_player, e_grenade);
        }
        if (isalive(ai_zombie)) {
            ai_zombie.var_d79ef6e3 = undefined;
        }
    }
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x0
// Checksum 0x5a524faf, Offset: 0x1bf0
// Size: 0x12a
function debug_draw_new_attractor_positions() {
    self endon(#"death");
    while (true) {
        foreach (attract in self.attractor_positions) {
            passed = bullettracepassed(attract + (0, 0, 24), self.origin + (0, 0, 24), 0, self);
            if (passed) {
                /#
                    debugstar(attract, 6, (0, 1, 0));
                #/
                continue;
            }
            /#
                debugstar(attract, 6, (1, 0, 0));
            #/
        }
        waitframe(1);
    }
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 1, eflags: 0x0
// Checksum 0xb2b8543e, Offset: 0x1d28
// Size: 0x78
function function_de09da63(e_parent) {
    self notify(#"fakelinkto");
    self endon(#"fakelinkto", #"death");
    while (true) {
        self.origin = e_parent.origin;
        self.angles = e_parent.angles;
        waitframe(1);
    }
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x0
// Checksum 0xd1324f8c, Offset: 0x1da8
// Size: 0x74
function function_c75436ca() {
    gibserverutils::gibhead(self);
    if (math::cointoss()) {
        gibserverutils::gibleftarm(self);
    } else {
        gibserverutils::gibrightarm(self);
    }
    gibserverutils::giblegs(self);
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x0
// Checksum 0xb7fca6bc, Offset: 0x1e28
// Size: 0x68
function sndattackvox() {
    self endon(#"explode");
    while (true) {
        self waittill(#"sndkillvox");
        wait 0.25;
        self playsound(#"wpn_octobomb_attack_vox");
        wait 2.5;
    }
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x0
// Checksum 0x614bc298, Offset: 0x1e98
// Size: 0x1a
function function_10e9398f() {
    return zm_weapons::is_weapon_included(level.var_9dcd2af2);
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x0
// Checksum 0x8728f21d, Offset: 0x1ec0
// Size: 0xfe
function is_on_navmesh() {
    self endon(#"death");
    if (ispointonnavmesh(self.origin, 60) == 1) {
        self.var_4ff05f89 = 1;
        return;
    }
    v_valid_point = getclosestpointonnavmesh(self.origin, 100);
    if (isdefined(v_valid_point)) {
        n_z_correct = 0;
        if (self.origin[2] > v_valid_point[2]) {
            n_z_correct = self.origin[2] - v_valid_point[2];
        }
        self.origin = v_valid_point + (0, 0, n_z_correct);
        self.var_4ff05f89 = 1;
        return;
    }
    self.var_4ff05f89 = 0;
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x0
// Checksum 0x40b4fe7a, Offset: 0x1fc8
// Size: 0x1ae
function function_704217d1() {
    v_orig = self.origin;
    var_88f4c2cc = self.angles;
    n_z_correct = 0;
    queryresult = positionquery_source_navigation(self.origin, 0, 200, 100, 2, 20);
    if (queryresult.data.size) {
        foreach (point in queryresult.data) {
            if (bullettracepassed(point.origin + (0, 0, 20), v_orig + (0, 0, 20), 0, self, undefined, 0, 0)) {
                if (self.origin[2] > queryresult.origin[2]) {
                    n_z_correct = self.origin[2] - queryresult.origin[2];
                }
                self.origin = point.origin + (0, 0, n_z_correct);
                self.angles = var_88f4c2cc;
                break;
            }
        }
    }
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 1, eflags: 0x0
// Checksum 0x68f93021, Offset: 0x2180
// Size: 0x2bc
function grenade_stolen_by_sam(e_grenade) {
    if (!isdefined(e_grenade)) {
        return;
    }
    direction = e_grenade.origin;
    direction = (direction[1], direction[0], 0);
    if (direction[1] < 0 || direction[0] > 0 && direction[1] > 0) {
        direction = (direction[0], direction[1] * -1, 0);
    } else if (direction[0] < 0) {
        direction = (direction[0] * -1, direction[1], 0);
    }
    if (!(isdefined(e_grenade.sndnosamlaugh) && e_grenade.sndnosamlaugh)) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (isalive(players[i])) {
                players[i] playlocalsound(level.zmb_laugh_alias);
            }
        }
    }
    playfxontag(level._effect[#"grenade_samantha_steal"], e_grenade, "tag_origin");
    e_grenade.mdl_anchor scene::stop();
    e_grenade.mdl_anchor unlink();
    e_grenade.mdl_anchor movez(60, 1);
    e_grenade.mdl_anchor vibrate(direction, 1.5, 2.5, 1);
    e_grenade.mdl_anchor waittill(#"movedone");
    e_grenade.mdl_anchor delete();
    if (isdefined(e_grenade)) {
        if (isdefined(e_grenade.damagearea)) {
            e_grenade.damagearea delete();
        }
        e_grenade delete();
    }
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 0, eflags: 0x0
// Checksum 0x691ae34e, Offset: 0x2448
// Size: 0x20c
function function_fd1e0f67() {
    wait 15;
    self.mdl_anchor notify(#"stopvox");
    self.mdl_anchor playsoundwithnotify("vox_homu_homun_death_" + randomintrangeinclusive(0, 6), "sounddone", "j_head");
    self.mdl_anchor waittill(#"sounddone");
    self notify(#"explode");
    self function_cd84f4f8();
    self.var_edbeb246 scene::stop();
    self.var_edbeb246 scene::play("aib_t8_zm_zod_homunculus_dth_01", self.mdl_anchor);
    mdl_anchor = self.mdl_anchor;
    mdl_anchor clientfield::set("" + #"hash_2d49d2cf3d339e18", 1);
    self flag::set("stop_following_humonculus");
    wait 0.1;
    mdl_anchor delete();
    for (i = 0; i < level.a_homunculus.size; i++) {
        if (!isdefined(level.a_homunculus[i])) {
            arrayremoveindex(level.a_homunculus, i);
            break;
        }
    }
    self.var_edbeb246 delete();
    self delete();
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 1, eflags: 0x0
// Checksum 0x4011f887, Offset: 0x2660
// Size: 0x21c
function function_cd84f4f8(b_immediate = 0) {
    self endon(#"death", #"explode");
    s_trace = groundtrace(self.mdl_anchor.origin + (0, 0, 16), self.mdl_anchor.origin + (0, 0, -1000), 0, self.mdl_anchor);
    var_a17ff4a7 = s_trace[#"position"];
    if (isdefined(s_trace[#"entity"])) {
        var_a17ff4a7 = (var_a17ff4a7[0], var_a17ff4a7[1], s_trace[#"entity"].origin[2]);
    }
    if (b_immediate) {
        self.var_edbeb246 moveto(var_a17ff4a7, 0.01);
        self.var_edbeb246 waittill(#"movedone");
        return;
    }
    if (abs(self.var_edbeb246.origin[2] - var_a17ff4a7[2]) > 1) {
        n_time = 0.25;
        self.var_edbeb246 scene::stop();
        self.var_edbeb246 moveto(var_a17ff4a7, 0.25);
        self.var_edbeb246 scene::play("aib_t8_zm_zod_homunculus_jump_down_01", self.mdl_anchor);
    }
}

// Namespace zm_weap_homunculus/zm_weap_homunculus
// Params 1, eflags: 0x0
// Checksum 0x2b5001c1, Offset: 0x2888
// Size: 0x13e
function function_b8bd483(str_alias) {
    self endon(#"death");
    self.mdl_anchor endon(#"death");
    if (!isdefined(self.istalking)) {
        self.istalking = 0;
        self.var_2854badd = "";
    }
    if (!self.istalking) {
        self.istalking = 1;
        self.var_2854badd = str_alias;
        str_notify = str_alias + "sounddone";
        self.mdl_anchor playsoundwithnotify(str_alias, str_notify, "j_head");
        waitresult = self.mdl_anchor waittill(str_notify, #"stopvox");
        if (waitresult._notify == "stopvox") {
            self.mdl_anchor stopsound(str_alias);
        }
        self.istalking = 0;
        self.var_2854badd = "";
    }
}

