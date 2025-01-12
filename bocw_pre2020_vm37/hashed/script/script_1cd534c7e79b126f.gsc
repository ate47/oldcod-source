#using script_165beea08a63a243;
#using script_19367cd29a4485db;
#using script_340a2e805e35f7a2;
#using script_3411bb48d41bd3b;
#using script_34ab99a4ca1a43d;
#using script_556e19065f09f8a2;
#using script_6a4a2311f8a4697;
#using script_7fc996fe8678852;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_utility;

#namespace namespace_63c7213c;

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 0, eflags: 0x6
// Checksum 0xea410597, Offset: 0x6a0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_3c43448fdb77ea73", &function_70a657d8, undefined, undefined, #"hash_f81b9dea74f0ee");
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 0, eflags: 0x1 linked
// Checksum 0xaba1ca10, Offset: 0x6f0
// Size: 0x15c
function function_70a657d8() {
    if (!zm_utility::is_survival()) {
        return;
    }
    clientfield::register("scriptmover", "soul_capture_zombie_tracker", 1, 2, "int");
    clientfield::register("actor", "soul_capture_zombie_fire", 1, 1, "int");
    clientfield::register("actor", "soul_capture_zombie_float", 1, 1, "int");
    clientfield::register("scriptmover", "soul_capture_crystal_leave", 1, 2, "int");
    clientfield::register("scriptmover", "soul_capture_crystal_timer", 1, 2, "int");
    namespace_8b6a9d79::function_b3464a7c(#"soul_capture", &spawn_callback);
    /#
        level thread namespace_420b39d3::function_2fab7a62("<dev string:x38>");
    #/
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 1, eflags: 0x1 linked
// Checksum 0x56253225, Offset: 0x858
// Size: 0x320
function function_fb6230f6(destination) {
    var_ba9835cd = [];
    foreach (s_location in destination.locations) {
        if (namespace_8b6a9d79::function_fe9fb6fd(s_location) && !getdvarint(#"hash_730311c63805303a", 0)) {
            continue;
        }
        s_instance = s_location.instances[#"soul_capture"];
        if (isdefined(s_instance)) {
            var_e7f5b3e0 = 1;
            if (isdefined(s_instance.var_501bc8c9)) {
                var_2685dd6d = strtok(s_instance.var_501bc8c9, ", ");
                foreach (var_a2593226 in var_2685dd6d) {
                    if (isdefined(destination.var_cd5ba489[var_a2593226])) {
                        var_e7f5b3e0 = 0;
                        break;
                    }
                }
            }
            if (var_e7f5b3e0) {
                if (!isdefined(var_ba9835cd)) {
                    var_ba9835cd = [];
                } else if (!isarray(var_ba9835cd)) {
                    var_ba9835cd = array(var_ba9835cd);
                }
                var_ba9835cd[var_ba9835cd.size] = s_instance;
            }
        }
    }
    if (getdvarint(#"hash_730311c63805303a", 0)) {
        n_to_spawn = 3;
    } else {
        n_to_spawn = randomintrangeinclusive(0, 1);
    }
    var_ba9835cd = array::randomize(var_ba9835cd);
    foreach (i, s_instance in var_ba9835cd) {
        if (i >= n_to_spawn) {
            return;
        }
        if (isdefined(s_instance)) {
            namespace_8b6a9d79::function_20d7e9c7(s_instance);
        }
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 1, eflags: 0x1 linked
// Checksum 0x9652f16b, Offset: 0xb80
// Size: 0x69c
function spawn_callback(s_instance) {
    if (!isdefined(level.var_8d314fbb)) {
        level.var_8d314fbb = &actor_damage_override;
    }
    s_instance callback::function_d8abfc3d(#"hash_345e9169ebba28fb", &function_149da5dd);
    s_instance flag::clear("eater_spawning");
    s_instance flag::clear("eater_active");
    s_instance flag::clear("eater_leaving");
    s_instance flag::clear("complete");
    s_instance flag::set("active");
    s_instance.var_94ca9760 = 1;
    s_instance.var_3f0d6dc1 = 0;
    s_instance.var_a1b91503 = 0;
    s_instance.var_dba85773 = [];
    s_instance.a_ai_zombies = [];
    s_instance.var_be8ed486 = [];
    s_capture_point = s_instance.var_fe2612fe[#"capture_point"][0];
    if (!isdefined(s_instance.var_934133c0)) {
        s_instance.var_934133c0 = {#origin:s_capture_point.origin, #angles:s_capture_point.angles};
    }
    if (is_true(s_instance.var_94ca9760)) {
        s_instance.var_ed23159a = "front";
        s_instance.var_934133c0.angles -= (0, 90, 0);
        s_instance.var_934133c0 scene::init("p9_fxanim_sr_dragon_statue");
        s_instance.var_dd06fc1c = s_instance.var_934133c0.scene_ents[#"hash_44d5576d6cc10d99"];
        s_instance.var_36e47091 = s_instance.var_934133c0.scene_ents[#"base"];
    }
    s_instance.var_80ee29f5 = [];
    var_27f4884b = isdefined(s_instance.var_fe2612fe[#"hash_4d27846c8a4b01a1"]) ? s_instance.var_fe2612fe[#"hash_4d27846c8a4b01a1"] : [];
    foreach (var_6d4038be in var_27f4884b) {
        var_650037c1 = namespace_8b6a9d79::spawn_script_model(var_6d4038be, var_6d4038be.model, 1);
        if (!isdefined(s_instance.var_80ee29f5)) {
            s_instance.var_80ee29f5 = [];
        } else if (!isarray(s_instance.var_80ee29f5)) {
            s_instance.var_80ee29f5 = array(s_instance.var_80ee29f5);
        }
        s_instance.var_80ee29f5[s_instance.var_80ee29f5.size] = var_650037c1;
        if (var_6d4038be.model == "p8_zm_red_dks_chaos_crystal_spire_lrg_02_02_sr") {
            s_instance.var_3128fb28 = var_650037c1;
            s_instance.var_3128fb28 thread function_7ae4c32b(s_instance);
        }
    }
    if (!isdefined(s_instance.var_3128fb28)) {
        s_instance.var_3128fb28 = util::spawn_model("tag_origin", s_instance.var_934133c0.origin, s_instance.var_934133c0.angles);
    }
    var_6881398b = s_instance.var_fe2612fe[#"hash_4cccee63908e50d3"][0];
    if (isdefined(var_6881398b)) {
        s_instance.var_f662374b = namespace_8b6a9d79::spawn_script_model(var_6881398b, var_6881398b.model, 0);
    }
    if (!isdefined(s_instance.var_f662374b)) {
        s_instance.var_f662374b = util::spawn_model("tag_origin", s_instance.var_934133c0.origin, s_instance.var_934133c0.angles);
    }
    namespace_60c38ce9::function_e3a05cb9(s_capture_point.origin, 2000);
    var_ee95cfc3 = s_instance.var_fe2612fe[#"hash_6b9f1d307da10b7b"][0];
    if (isdefined(var_ee95cfc3)) {
        var_ee95cfc3.spawn_points = [];
        var_ee95cfc3.var_9b178666 = 1000;
        var_ee95cfc3.var_48d0f926 = 64;
        var_ee95cfc3.var_783fc5e = 20;
        v_origin = getclosestpointonnavmesh(var_ee95cfc3.origin, 1000);
        var_ee95cfc3.spawn_points = namespace_85745671::function_e4791424(v_origin, var_ee95cfc3.var_783fc5e, var_ee95cfc3.var_48d0f926, var_ee95cfc3.var_9b178666);
        s_instance.var_1d03f645 = namespace_85745671::function_e4791424(v_origin, 20, 64, 1500, 700);
        s_instance thread function_5b6f8b42();
    }
    s_instance.n_obj_id = gameobjects::get_next_obj_id();
    objective_add(s_instance.n_obj_id, "active", s_capture_point.origin, "sr_obj_explore");
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 0, eflags: 0x1 linked
// Checksum 0xf2d18dbc, Offset: 0x1228
// Size: 0x2f4
function function_b37f93b7() {
    self endon(#"complete", #"cleanup");
    s_capture_point = self.var_fe2612fe[#"capture_point"][0];
    self.n_timer = 60;
    self.var_3128fb28 clientfield::set("soul_capture_crystal_timer", 1);
    while (self.n_timer > 0) {
        if (self flag::get("eater_active")) {
            a_ai = getaiarchetypearray(#"zombie", level.zombie_team);
            a_ai = arraysortclosest(a_ai, s_capture_point.origin, undefined, 0, 1000);
            foreach (ai in a_ai) {
                if (!is_true(ai.var_2e85cbf2) && distancesquared(ai.origin, s_capture_point.origin) <= function_a3f6cdac(800)) {
                    self function_bbc6c929(ai, 1);
                    continue;
                }
                if (is_true(ai.var_2e85cbf2) && distancesquared(ai.origin, s_capture_point.origin) > function_a3f6cdac(800)) {
                    self function_bbc6c929(ai, 0);
                }
            }
        } else {
            self.var_3128fb28 clientfield::set("soul_capture_crystal_timer", 2);
        }
        wait 1;
        self.n_timer--;
    }
    self thread function_39280c7a(1);
    self flag::set("complete");
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 1, eflags: 0x1 linked
// Checksum 0xd47f3a03, Offset: 0x1528
// Size: 0x33c
function function_7ae4c32b(s_instance) {
    self endon(#"death");
    s_instance endon(#"complete", #"cleanup");
    self.maxhealth = 5000;
    self.health = int(2250);
    s_instance flag::wait_till("eater_active");
    s_instance thread function_b37f93b7();
    self setcandamage(1);
    self thread function_73e00687();
    self thread function_bba01cff(s_instance);
    /#
        self thread function_2378f357(s_instance);
    #/
    while (true) {
        s_waitresult = self waittill(#"damage", #"hash_cfab9a5468a4911");
        if (!s_instance flag::get("eater_active")) {
            namespace_85745671::function_b70e2a37(self);
            s_instance flag::wait_till("eater_active");
            self thread function_73e00687();
            continue;
        }
        if (s_waitresult._notify == #"hash_cfab9a5468a4911") {
            self.health += int(750);
            self.health = math::clamp(self.health, 0, self.maxhealth);
        } else if (isplayer(s_waitresult.attacker)) {
            if (isdefined(s_waitresult.amount)) {
                self.health += s_waitresult.amount;
            }
        } else if (isactor(s_waitresult.attacker)) {
            if (s_waitresult.mod === "MOD_MELEE") {
                self playsound(#"hash_52e02ca86c5fa117");
            }
        }
        self thread function_bba01cff(s_instance);
        if (self.health >= self.maxhealth || self.health <= 0) {
            s_instance thread function_39280c7a(1);
            s_instance flag::set("complete");
            break;
        }
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 0, eflags: 0x1 linked
// Checksum 0x13ce71e8, Offset: 0x1870
// Size: 0x19c
function function_73e00687() {
    switch (getplayers().size) {
    case 1:
        var_72213a7c = 2;
        break;
    case 2:
        var_72213a7c = 3;
        break;
    case 3:
    case 4:
    default:
        var_72213a7c = 5;
        break;
    }
    a_s_slots = namespace_85745671::function_bdb2b85b(self, self.origin, self.angles, 150, var_72213a7c, 16);
    if (!isdefined(a_s_slots) || a_s_slots.size <= 0) {
        return;
    }
    self.var_b79a8ac7 = {#var_f019ea1a:3000, #slots:a_s_slots};
    if (!isdefined(level.attackables)) {
        level.attackables = [];
    } else if (!isarray(level.attackables)) {
        level.attackables = array(level.attackables);
    }
    level.attackables[level.attackables.size] = self;
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 1, eflags: 0x1 linked
// Checksum 0x1a4e9968, Offset: 0x1a18
// Size: 0x27c
function function_bba01cff(s_instance) {
    if (!isarray(self.var_12d1b199)) {
        var_45171486 = s_instance.var_f662374b.origin + (0, 0, 48);
        for (i = 0; i < 3; i++) {
            var_db1fc0b7 = util::spawn_model("tag_origin", var_45171486 + (0, 0, 40 * i), self.angles);
            if (!isdefined(self.var_12d1b199)) {
                self.var_12d1b199 = [];
            } else if (!isarray(self.var_12d1b199)) {
                self.var_12d1b199 = array(self.var_12d1b199);
            }
            self.var_12d1b199[self.var_12d1b199.size] = var_db1fc0b7;
        }
    }
    array::thread_all(self.var_12d1b199, &clientfield::set, "soul_capture_zombie_tracker", 0);
    util::wait_network_frame();
    if (self.health >= 4500) {
        for (i = 0; i < 3; i++) {
            self.var_12d1b199[i] clientfield::set("soul_capture_zombie_tracker", 1);
        }
        return;
    }
    if (self.health >= 2500) {
        for (i = 0; i < 2; i++) {
            self.var_12d1b199[i] clientfield::set("soul_capture_zombie_tracker", 1);
        }
        return;
    }
    if (self.health > 0) {
        for (i = 0; i < 1; i++) {
            self.var_12d1b199[i] clientfield::set("soul_capture_zombie_tracker", 1);
        }
    }
}

/#

    // Namespace namespace_63c7213c/namespace_63c7213c
    // Params 1, eflags: 0x0
    // Checksum 0x9ee4149c, Offset: 0x1ca0
    // Size: 0x27e
    function function_2378f357(s_instance) {
        self endon(#"death");
        s_instance endon(#"complete", #"cleanup");
        v_ground_pos = s_instance.var_934133c0.origin - (0, 0, 150);
        while (self.health > 0) {
            a_players = function_a1ef346b(undefined, self.origin, 1000);
            if (a_players.size && getdvarint(#"hash_65645feb77b22343", 0)) {
                var_7886ce7a = self.origin + anglestoright(self.angles) * -200 + (0, 0, 250);
                var_1ad0401b = self.health / self.maxhealth;
                print3d(var_7886ce7a, "<dev string:x48>" + self.health + "<dev string:x5c>" + self.maxhealth + "<dev string:x61>" + var_1ad0401b + "<dev string:x68>" + "<dev string:x6e>" + s_instance.n_timer, (0, 1, 0), undefined, 1);
                foreach (var_db1fc0b7 in self.var_12d1b199) {
                    circle(var_db1fc0b7.origin, 25, (0, 1, 0));
                }
                cylinder(v_ground_pos, v_ground_pos + (0, 0, 20), 800, (0, 1, 1));
            }
            waitframe(1);
        }
    }

#/

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 0, eflags: 0x1 linked
// Checksum 0xa47c7dd3, Offset: 0x1f28
// Size: 0x180
function function_23fcd9e1() {
    if (isdefined(self.var_9427911d)) {
        return;
    }
    switch (getplayers().size) {
    case 1:
        var_47d69eed = int(5);
        var_a4b9e38b = int(4);
        break;
    case 2:
        var_47d69eed = int(7);
        var_a4b9e38b = int(5.6);
        break;
    case 3:
    case 4:
    default:
        var_47d69eed = 10;
        var_a4b9e38b = 8;
        break;
    }
    self.var_e91573e1 = [];
    self.var_47d69eed = var_47d69eed;
    self.var_9427911d = var_47d69eed;
    self.var_a4b9e38b = var_a4b9e38b;
    for (i = 0; i < self.var_47d69eed; i++) {
        self.var_e91573e1[i] = 0;
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 12, eflags: 0x1 linked
// Checksum 0xfea3dcf5, Offset: 0x20b0
// Size: 0x836
function actor_damage_override(*inflictor, attacker, damage, *flags, *meansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *surfacetype) {
    var_9bcc82c8 = [];
    foreach (s_instance in struct::get_array("soul_capture", "content_script_name")) {
        if (s_instance flag::get("active")) {
            if (!isdefined(var_9bcc82c8)) {
                var_9bcc82c8 = [];
            } else if (!isarray(var_9bcc82c8)) {
                var_9bcc82c8 = array(var_9bcc82c8);
            }
            var_9bcc82c8[var_9bcc82c8.size] = s_instance;
        }
    }
    if (var_9bcc82c8.size <= 0 || self.archetype != #"zombie" || level flag::get("objective_locked") && !is_true(self.var_2e85cbf2)) {
        return surfacetype;
    }
    if (self.health - surfacetype <= 0 && isplayer(boneindex) && !boneindex laststand::player_is_in_laststand()) {
        var_ee56c5b = [];
        foreach (var_ab4a6bb5 in var_9bcc82c8) {
            if (!isdefined(var_ee56c5b)) {
                var_ee56c5b = [];
            } else if (!isarray(var_ee56c5b)) {
                var_ee56c5b = array(var_ee56c5b);
            }
            var_ee56c5b[var_ee56c5b.size] = var_ab4a6bb5.var_fe2612fe[#"capture_point"][0];
        }
        if (s_instance flag::get("eater_active")) {
            n_distance = 800;
        } else {
            n_distance = 1000;
        }
        var_8580c8fc = arraysortclosest(var_ee56c5b, self.origin, undefined, 0, n_distance);
        s_capture_point = var_8580c8fc[0];
        s_instance = s_capture_point.parent;
        if (isdefined(s_instance) && !s_instance flag::get("complete") && !s_instance flag::get("eater_leaving")) {
            if (!is_true(self.var_2e85cbf2)) {
                gibserverutils::annihilate(self);
                if (!s_instance flag::get("eater_spawning") && !s_instance flag::get("eater_active")) {
                    s_instance thread function_98382cc9();
                }
                return surfacetype;
            }
            s_instance.var_9427911d--;
            var_da0e5c76 = self;
            var_c4943182 = self;
            if (!s_instance flag::get("eater_active")) {
                if (isdefined(s_instance.var_dd06fc1c)) {
                    var_da0e5c76 = s_instance.var_dd06fc1c;
                }
                if (isdefined(s_instance.var_36e47091)) {
                    var_c4943182 = s_instance.var_36e47091;
                }
            } else if (isdefined(s_instance.var_562512bb)) {
                var_da0e5c76 = s_instance.var_562512bb;
            }
            if (!isdefined(var_da0e5c76) && isdefined(s_instance.var_80ee29f5[0])) {
                var_da0e5c76 = s_instance.var_80ee29f5[0];
            }
            if (!isdefined(var_c4943182) && isdefined(s_instance.var_80ee29f5[1])) {
                var_c4943182 = s_instance.var_80ee29f5[1];
            }
            var_32ae015c = s_instance.var_934133c0 math::get_dot_forward(self.origin) > 0;
            var_ca4c48f1 = s_instance.var_934133c0.origin + anglestoforward(s_instance.var_934133c0.angles) * 150;
            b_trace_passed = bullettracepassed(self util::get_eye(), var_ca4c48f1, 0, var_da0e5c76, var_c4943182);
            /#
                if (getdvarint(#"hash_65645feb77b22343", 0)) {
                    red = (0.9, 0.2, 0.2);
                    green = (0.2, 0.9, 0.2);
                    color = red;
                    if (b_trace_passed) {
                        color = green;
                    }
                    line(self util::get_eye(), var_ca4c48f1, color, undefined, undefined, 300);
                }
            #/
            var_f3a93cf1 = 0;
            if (var_32ae015c && b_trace_passed && !s_instance flag::get("eater_eating")) {
                s_instance flag::set("eater_eating");
                var_f3a93cf1 = 1;
            }
            self.var_a950813d = 1;
            self.var_98f1f37c = 1;
            self.no_powerups = 1;
            self val::set("soul_capture_allowdeath", "allowdeath", 0);
            self val::set("soul_capture_takedamage", "takedamage", 0);
            self val::set("soul_capture_ignoreme", "ignoreme", 1);
            self val::set("soul_capture_ignoreall", "ignoreall", 1);
            s_instance thread function_29db9d5f(self, boneindex, var_f3a93cf1);
            return (self.health - 1);
        }
    }
    return surfacetype;
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 0, eflags: 0x1 linked
// Checksum 0x7fc995af, Offset: 0x28f0
// Size: 0x430
function function_149da5dd() {
    self callback::function_52ac9652(#"hash_345e9169ebba28fb", &function_149da5dd);
    self notify(#"cleanup");
    self flag::clear("active");
    if (isdefined(self.n_obj_id)) {
        objective_delete(self.n_obj_id);
        gameobjects::release_obj_id(self.n_obj_id);
        self.n_obj_id = undefined;
    }
    namespace_58949729::function_ccf9be41(self);
    if (is_true(self.var_94ca9760)) {
        self.var_934133c0 scene::stop("aib_t9_zm_dragonhead", 1);
        self.var_934133c0 scene::stop("p9_fxanim_sr_dragon_statue", 1);
    }
    self thread function_789b3ddf(0);
    var_c3d060a6 = arraycombine(self.a_ai_zombies, self.var_be8ed486);
    function_1eaaceab(var_c3d060a6);
    foreach (ai_cleanup in var_c3d060a6) {
        ai_cleanup val::reset("soul_capture_allowdeath", "allowdeath");
        ai_cleanup val::reset("soul_capture_takedamage", "takedamage");
        ai_cleanup clientfield::set("soul_capture_zombie_float", 0);
        ai_cleanup clientfield::set("soul_capture_zombie_fire", 0);
        ai_cleanup kill(undefined, undefined, undefined, undefined, undefined, 1);
    }
    if (isdefined(self.var_f662374b)) {
        self.var_f662374b delete();
    }
    if (isdefined(self.var_3128fb28)) {
        arrayremovevalue(self.var_80ee29f5, self.var_3128fb28);
        if (isarray(self.var_3128fb28.var_12d1b199)) {
            array::delete_all(self.var_3128fb28.var_12d1b199);
            namespace_85745671::function_b70e2a37(self.var_3128fb28);
        }
        self.var_3128fb28 clientfield::set("soul_capture_crystal_leave", 0);
        self.var_3128fb28 thread util::delayed_delete(1);
    }
    arrayremovevalue(self.var_80ee29f5, undefined);
    foreach (var_650037c1 in self.var_80ee29f5) {
        var_650037c1 delete();
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 0, eflags: 0x1 linked
// Checksum 0x2b5aa9e1, Offset: 0x2d28
// Size: 0x79a
function function_5b6f8b42() {
    self endon(#"complete", #"cleanup");
    s_capture_point = self.var_fe2612fe[#"capture_point"][0];
    var_ee95cfc3 = self.var_fe2612fe[#"hash_6b9f1d307da10b7b"][0];
    self.var_68b209ac = arraycopy(var_ee95cfc3.spawn_points);
    self.var_68b209ac = array::randomize(self.var_68b209ac);
    while (true) {
        var_68298325 = 0;
        while (!var_68298325 || level flag::get("objective_locked")) {
            if (level flag::get("objective_locked") && self flag::get("eater_active")) {
                self thread function_39280c7a();
                var_5d6b53b = 1;
            }
            level flag::wait_till_clear("objective_locked");
            if (is_true(var_5d6b53b)) {
                self thread function_98382cc9();
                var_5d6b53b = undefined;
            }
            a_e_players = function_a1ef346b(undefined, s_capture_point.origin, 8000);
            foreach (e_player in a_e_players) {
                if (!e_player laststand::player_is_in_laststand()) {
                    var_68298325 = 1;
                    break;
                }
            }
            if (!var_68298325) {
                wait 1;
            }
        }
        self function_23fcd9e1();
        n_to_spawn = self.var_a4b9e38b;
        function_1eaaceab(self.a_ai_zombies);
        while (self.a_ai_zombies.size + n_to_spawn > self.var_a4b9e38b + 1) {
            n_to_spawn--;
            function_1eaaceab(self.a_ai_zombies);
        }
        if (n_to_spawn > 0 && !level flag::get("objective_locked")) {
            for (i = 0; i < n_to_spawn; i++) {
                if (self.var_68b209ac.size <= 0) {
                    self.var_68b209ac = arraycopy(var_ee95cfc3.spawn_points);
                    self.var_68b209ac = array::randomize(self.var_68b209ac);
                }
                v_spawn = self.var_68b209ac[0];
                arrayremoveindex(self.var_68b209ac, 0);
                v_spawn = v_spawn.origin;
                while (true) {
                    if (!isdefined(v_spawn)) {
                        break;
                    }
                    var_eea973b0 = namespace_85745671::function_9d3ad056(#"hash_7cba8a05511ceedf", v_spawn, (0, randomfloat(360), 0), "soul_capture_zombie");
                    if (isdefined(var_eea973b0)) {
                        if (!isdefined(self.a_ai_zombies)) {
                            self.a_ai_zombies = [];
                        } else if (!isarray(self.a_ai_zombies)) {
                            self.a_ai_zombies = array(self.a_ai_zombies);
                        }
                        if (!isinarray(self.a_ai_zombies, var_eea973b0)) {
                            self.a_ai_zombies[self.a_ai_zombies.size] = var_eea973b0;
                        }
                        var_eea973b0.var_4114a7c0 = 1;
                        var_eea973b0 callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_df7d32bc);
                        var_eea973b0.wander_radius = 1000;
                        if (self flag::get("eater_active")) {
                            var_eea973b0.var_8661adfc = 1;
                            var_eea973b0 thread namespace_85745671::function_9456addc(60);
                        }
                        break;
                    }
                    waitframe(1);
                }
                if (i + 1 < n_to_spawn) {
                    util::wait_network_frame();
                }
            }
        }
        self thread function_617d8ea6();
        while (true) {
            var_68298325 = 0;
            a_e_players = function_a1ef346b(undefined, s_capture_point.origin, 8000);
            foreach (e_player in a_e_players) {
                if (!e_player laststand::player_is_in_laststand()) {
                    var_68298325 = 1;
                    break;
                }
            }
            if (!var_68298325 || level flag::get("objective_locked")) {
                self notify(#"hash_3c93c17d2bec4686");
                function_1eaaceab(self.a_ai_zombies);
                foreach (ai_zombie in self.a_ai_zombies) {
                    if (!is_true(ai_zombie.var_a950813d)) {
                        gibserverutils::annihilate(ai_zombie);
                        ai_zombie kill(undefined, undefined, undefined, undefined, undefined, 1);
                    }
                }
                break;
            }
            wait 1;
        }
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 0, eflags: 0x1 linked
// Checksum 0xe5518fb9, Offset: 0x34d0
// Size: 0x30c
function function_617d8ea6() {
    self notify("28014aac2196e685");
    self endon("28014aac2196e685");
    self endon(#"complete", #"hash_3c93c17d2bec4686", #"cleanup");
    var_a9188e9b = arraycopy(self.var_1d03f645);
    while (true) {
        wait randomfloatrange(2, 5);
        function_1eaaceab(self.a_ai_zombies);
        if (self.a_ai_zombies.size < self.var_a4b9e38b + 1 && !level flag::get("objective_locked")) {
            if (var_a9188e9b.size <= 0) {
                var_a9188e9b = arraycopy(self.var_1d03f645);
                var_a9188e9b = array::randomize(var_a9188e9b);
            }
            v_spawn = var_a9188e9b[0];
            arrayremoveindex(var_a9188e9b, 0);
            v_spawn = v_spawn.origin;
            while (true) {
                if (!isdefined(v_spawn)) {
                    break;
                }
                var_eea973b0 = namespace_85745671::function_9d3ad056(#"hash_7cba8a05511ceedf", v_spawn, (0, randomfloat(360), 0), "soul_capture_zombie");
                if (isdefined(var_eea973b0)) {
                    if (!isdefined(self.a_ai_zombies)) {
                        self.a_ai_zombies = [];
                    } else if (!isarray(self.a_ai_zombies)) {
                        self.a_ai_zombies = array(self.a_ai_zombies);
                    }
                    if (!isinarray(self.a_ai_zombies, var_eea973b0)) {
                        self.a_ai_zombies[self.a_ai_zombies.size] = var_eea973b0;
                    }
                    var_eea973b0.var_4114a7c0 = 1;
                    var_eea973b0 callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_df7d32bc);
                    var_eea973b0.wander_radius = 1000;
                    if (self flag::get("eater_active")) {
                        var_eea973b0.var_8661adfc = 1;
                        var_eea973b0 thread namespace_85745671::function_9456addc(60);
                    }
                    break;
                }
                waitframe(1);
            }
        }
        waitframe(1);
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 2, eflags: 0x1 linked
// Checksum 0x3997705, Offset: 0x37e8
// Size: 0x364
function function_bbc6c929(ai_zombie, var_6be8a3b9 = 1) {
    function_1eaaceab(self.var_be8ed486);
    if (!is_true(ai_zombie.var_2e85cbf2) && var_6be8a3b9) {
        ai_zombie.var_2e85cbf2 = 1;
        ai_zombie.var_5d94c356 = self;
        ai_zombie thread util::delay(1, "death", &zombie_eye_glow::function_b43f92cd, 2);
        ai_zombie clientfield::set("soul_capture_zombie_fire", 1);
        if (!is_true(ai_zombie.var_4114a7c0)) {
            ai_zombie.var_4114a7c0 = 1;
            ai_zombie callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_df7d32bc);
        }
        if (!is_true(ai_zombie.var_8661adfc)) {
            ai_zombie.var_8661adfc = 1;
            ai_zombie thread namespace_85745671::function_9456addc(60);
        }
        if (!isdefined(self.a_ai_zombies)) {
            self.a_ai_zombies = [];
        } else if (!isarray(self.a_ai_zombies)) {
            self.a_ai_zombies = array(self.a_ai_zombies);
        }
        if (!isinarray(self.a_ai_zombies, ai_zombie)) {
            self.a_ai_zombies[self.a_ai_zombies.size] = ai_zombie;
        }
        if (!isdefined(self.var_be8ed486)) {
            self.var_be8ed486 = [];
        } else if (!isarray(self.var_be8ed486)) {
            self.var_be8ed486 = array(self.var_be8ed486);
        }
        if (!isinarray(self.var_be8ed486, ai_zombie)) {
            self.var_be8ed486[self.var_be8ed486.size] = ai_zombie;
        }
        return;
    }
    if (is_true(ai_zombie.var_2e85cbf2) && !var_6be8a3b9) {
        ai_zombie.var_2e85cbf2 = undefined;
        ai_zombie.var_5d94c356 = undefined;
        ai_zombie clientfield::set("soul_capture_zombie_fire", 0);
        ai_zombie.var_4114a7c0 = undefined;
        ai_zombie callback::function_52ac9652(#"hash_4afe635f36531659", &function_df7d32bc);
        ai_zombie.var_8661adfc = undefined;
        ai_zombie thread namespace_85745671::function_9456addc(60);
        arrayremovevalue(self.a_ai_zombies, ai_zombie);
        arrayremovevalue(self.var_be8ed486, ai_zombie);
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 0, eflags: 0x1 linked
// Checksum 0xfdb0ef27, Offset: 0x3b58
// Size: 0x2ec
function function_98382cc9() {
    self endon(#"cleanup");
    self flag::set("eater_spawning");
    wait 0.5;
    self flag::wait_till_clear("eater_active");
    self function_789b3ddf(1);
    if (is_true(self.var_94ca9760)) {
        str_scene = "aib_t9_zm_dragonhead";
        str_shot = "dragonhead_intro";
        self thread function_375271a1(1);
    }
    if (!isdefined(self.var_562512bb)) {
        self thread function_4a145301();
    } else {
        self.var_562512bb show();
    }
    self.var_934133c0 scene::play(str_scene, str_shot);
    self flag::set("eater_active");
    self flag::clear("eater_spawning");
    if (!self flag::get("looking_at_zombie")) {
        self thread function_21700f1d();
    }
    self thread function_39c91656();
    function_1eaaceab(self.a_ai_zombies);
    foreach (ai_zombie in self.a_ai_zombies) {
        ai_zombie thread namespace_85745671::function_9456addc(60);
    }
    /#
        if (getdvarint(#"hash_65645feb77b22343", 0)) {
            line(self.var_934133c0.origin, self.var_934133c0.origin + anglestoforward(self.var_934133c0.angles) * 150, undefined, undefined, undefined, 300);
        }
    #/
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 0, eflags: 0x1 linked
// Checksum 0x4f6f3809, Offset: 0x3e50
// Size: 0x88
function function_4a145301() {
    self notify("1a2232d18c5dd9fe");
    self endon("1a2232d18c5dd9fe");
    if (is_true(self.var_94ca9760)) {
        str_targetname = "dragon_head";
    }
    while (!isdefined(self.var_562512bb)) {
        self.var_562512bb = self.var_934133c0.scene_ents[str_targetname];
        waitframe(1);
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 2, eflags: 0x1 linked
// Checksum 0x42890218, Offset: 0x3ee0
// Size: 0xf4
function function_375271a1(b_hide = 1, n_delay = 0.5) {
    self endon(#"cleanup");
    if (n_delay > 0) {
        wait n_delay;
    }
    if (isdefined(self.var_dd06fc1c)) {
        if (b_hide) {
            self.var_dd06fc1c hide();
        } else {
            self.var_dd06fc1c show();
        }
    }
    if (isdefined(self.var_36e47091)) {
        if (b_hide) {
            self.var_36e47091 hide();
            return;
        }
        self.var_36e47091 show();
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 0, eflags: 0x1 linked
// Checksum 0x52ab6310, Offset: 0x3fe0
// Size: 0xcc
function function_df7d32bc() {
    if (self.current_state.name == #"chase" && self.archetype == #"zombie") {
        var_8c6394e3 = "sprint";
        var_481bf1b8 = isdefined(level.var_b48509f9) ? level.var_b48509f9 : 1;
        if (var_481bf1b8 > 1 && math::cointoss(25)) {
            var_8c6394e3 = "super_sprint";
        }
        self namespace_85745671::function_9758722(var_8c6394e3);
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 0, eflags: 0x1 linked
// Checksum 0x434ebe32, Offset: 0x40b8
// Size: 0x130
function function_21700f1d() {
    self endon(#"eater_leaving", #"looking_at_zombie", #"cleanup");
    if (is_true(self.var_94ca9760)) {
        self thread function_c57d25ff();
        str_scene = "aib_t9_zm_dragonhead";
        a_str_shots = array("dragonhead_idle", "dragonhead_idle_b", "dragonhead_idle_twitch_roar");
    }
    while (!self flag::get("eater_leaving") && !self flag::get("looking_at_zombie")) {
        str_shot = array::random(a_str_shots);
        self.var_934133c0 scene::play(str_scene, str_shot);
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 0, eflags: 0x1 linked
// Checksum 0x8ccc5462, Offset: 0x41f0
// Size: 0x11e
function function_c57d25ff() {
    self endon(#"eater_leaving", #"looking_at_zombie", #"cleanup");
    var_f9cc146 = self.var_562512bb;
    while (true) {
        s_waitresult = var_f9cc146 waittill(#"dragon_side_front", #"dragon_side_left", #"dragon_side_right");
        switch (s_waitresult._notify) {
        case #"dragon_side_front":
            self.var_ed23159a = "front";
            break;
        case #"dragon_side_left":
            self.var_ed23159a = "left";
            break;
        case #"dragon_side_right":
            self.var_ed23159a = "right";
            break;
        }
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 0, eflags: 0x1 linked
// Checksum 0x999231ea, Offset: 0x4318
// Size: 0x110
function function_39c91656() {
    self notify("5142618856b5f095");
    self endon("5142618856b5f095");
    self endon(#"eater_leaving", #"cleanup");
    self flag::wait_till_clear("eater_eating");
    wait 10;
    s_capture_point = self.var_fe2612fe[#"capture_point"][0];
    while (true) {
        a_e_players = function_a1ef346b(undefined, s_capture_point.origin, 1000);
        if (a_e_players.size <= 0 && !self flag::get("eater_eating")) {
            self thread function_39280c7a();
            return;
        }
        wait 1;
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 1, eflags: 0x1 linked
// Checksum 0xad82aefb, Offset: 0x4430
// Size: 0x57c
function function_39280c7a(b_complete = 0) {
    self endon(#"cleanup");
    if (b_complete) {
        self flag::clear("active");
        self.var_3128fb28 clientfield::set("soul_capture_crystal_timer", 0);
    }
    self flag::set("eater_leaving");
    self.var_3128fb28 setcandamage(0);
    self flag::wait_till_clear_all(array("eater_spawning", "eater_eating"));
    if (is_true(self.var_94ca9760)) {
        str_scene = "aib_t9_zm_dragonhead";
        str_shot = "dragonhead_outro";
        self thread function_375271a1(0, 4.5);
    }
    self.var_934133c0 scene::play(str_scene, str_shot);
    self.var_562512bb hide();
    self flag::clear("eater_active");
    self flag::clear("eater_leaving");
    function_1eaaceab(self.a_ai_zombies);
    var_fff98e50 = getaiarchetypearray(#"zombie", level.zombie_team);
    var_fff98e50 = arraysortclosest(var_fff98e50, self.var_934133c0.origin, undefined, 0, 800);
    var_fff98e50 = arraycombine(self.a_ai_zombies, var_fff98e50, 0, 0);
    foreach (ai_zombie in var_fff98e50) {
        if (!is_true(ai_zombie.var_a950813d)) {
            gibserverutils::annihilate(ai_zombie);
            ai_zombie kill(undefined, undefined, undefined, undefined, undefined, 1);
        }
    }
    if (b_complete) {
        objective_delete(self.n_obj_id);
        gameobjects::release_obj_id(self.n_obj_id);
        self.n_obj_id = undefined;
        if (self.var_3128fb28.health >= 4500) {
            var_cc1fb2d0 = "sr_explore_chest_large";
        } else if (self.var_3128fb28.health >= 2500) {
            var_cc1fb2d0 = "sr_explore_chest_medium";
        } else if (self.var_3128fb28.health > 0) {
            var_cc1fb2d0 = "sr_explore_chest_small";
        }
        var_6881398b = self.var_fe2612fe[#"hash_4cccee63908e50d3"][0];
        if (isdefined(var_6881398b)) {
            v_forward = anglestoforward(self.var_934133c0.angles);
            v_forward = vectornormalize(v_forward);
            v_forward *= 64;
            arrayremovevalue(self.var_dba85773, undefined);
            var_69fc8214 = int(min(5, self.var_3f0d6dc1));
            if (isdefined(var_cc1fb2d0) && var_69fc8214 > 0) {
                a_items = var_6881398b namespace_65181344::function_fd87c780(var_cc1fb2d0, var_69fc8214, 2);
            }
        } else {
            var_49089e5b = self.var_fe2612fe[#"hash_6b1e5d8f9e70a70e"][0];
            if (isdefined(var_49089e5b)) {
                var_49089e5b.var_cc1fb2d0 = var_cc1fb2d0;
                level thread namespace_58949729::function_25979f32(var_49089e5b, 0, self);
            }
        }
        self thread function_c97f9fb5(isdefined(var_cc1fb2d0));
    }
    self thread function_789b3ddf(0);
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 3, eflags: 0x1 linked
// Checksum 0xc5ab7f9, Offset: 0x49b8
// Size: 0x93c
function function_29db9d5f(ai_zombie, e_killer, var_f3a93cf1 = 0) {
    self endon(#"cleanup");
    ai_zombie endoncallback(&function_64107d05, #"death");
    v_death = ai_zombie.origin;
    ai_zombie disableaimassist();
    mdl_anchor = util::spawn_model("tag_origin", v_death, ai_zombie.angles);
    ai_zombie.var_c1a29994 = mdl_anchor;
    ai_zombie linkto(mdl_anchor);
    ai_zombie.script_animname = "zombie_eaten";
    ai_zombie.targetname = "zombie_eaten";
    ai_zombie.var_23ab2a9d = var_f3a93cf1;
    self thread function_fd47174(ai_zombie, mdl_anchor, var_f3a93cf1, e_killer);
    if (!self flag::get("eater_spawning") && !self flag::get("eater_active")) {
        self function_98382cc9();
    }
    if (!var_f3a93cf1) {
        return;
    }
    self flag::set("looking_at_zombie");
    s_capture_point = self.var_fe2612fe[#"capture_point"][0];
    var_7caa77 = vectordot(anglestoforward(self.var_934133c0.angles), vectornormalize(v_death - s_capture_point.origin));
    if (var_7caa77 > 0.85) {
        if (is_true(self.var_94ca9760)) {
            self.var_ed23159a = "right";
            var_a4fc6c63 = "dragonhead_pre_eat_f";
            var_51d51f4e = "dragonhead_consume_zombie_fwd";
        }
    } else {
        var_8ecbd20e = vectordot(anglestoright(self.var_934133c0.angles), v_death - s_capture_point.origin);
        if (var_8ecbd20e > 0) {
            if (is_true(self.var_94ca9760)) {
                if (self.var_ed23159a == "left") {
                    var_95663e8c = "dragonhead_pre_eat_l_2_r";
                }
                self.var_ed23159a = "right";
                var_a4fc6c63 = "dragonhead_pre_eat_r";
                var_51d51f4e = "dragonhead_consume_zombie_right";
            }
        } else if (is_true(self.var_94ca9760)) {
            if (self.var_ed23159a == "right") {
                var_95663e8c = "dragonhead_pre_eat_r_2_l";
            }
            self.var_ed23159a = "left";
            var_a4fc6c63 = "dragonhead_pre_eat_l";
            var_51d51f4e = "dragonhead_consume_zombie_left";
        }
    }
    if (is_true(self.var_94ca9760)) {
        var_d6a665db = "aib_t9_zm_dragonhead";
        if (isdefined(var_95663e8c)) {
            self.var_934133c0 scene::play(var_d6a665db, var_95663e8c);
        }
        var_ec3d3167 = gettime();
    }
    self.var_934133c0 thread scene::play(var_d6a665db, var_a4fc6c63);
    self flag::wait_till("zombie_ready");
    var_562512bb = self.var_562512bb;
    self thread function_b2c1743d(ai_zombie, var_562512bb);
    if (is_true(self.var_94ca9760)) {
        var_a4a440a3 = "tag_mouth_floor_fx";
    }
    var_6d57992d = var_562512bb gettagorigin(var_a4a440a3);
    var_462c2689 = vectortoangles(s_capture_point.origin - v_death);
    n_move_dist = distance(var_6d57992d, mdl_anchor.origin);
    n_move_time = n_move_dist / 500;
    if (is_true(self.var_94ca9760)) {
        var_f415f7b8 = float(gettime() - var_ec3d3167) / 1000;
        var_4dd8873d = scene::function_8582657c(var_d6a665db, var_a4fc6c63) - var_f415f7b8;
        n_move_time = min(var_4dd8873d, n_move_time);
        n_move_time = max(n_move_time, 0.1);
    }
    mdl_anchor moveto(var_6d57992d, n_move_time, n_move_time);
    mdl_anchor rotateto(var_462c2689, n_move_time, n_move_time);
    mdl_anchor waittilltimeout(n_move_time, #"movedone");
    ai_zombie notify(#"hash_4ecc58f239a5807a");
    self.var_3128fb28 notify(#"hash_cfab9a5468a4911");
    mdl_anchor scene::stop();
    ai_zombie scene::stop();
    mdl_anchor delete();
    ai_zombie clientfield::set("soul_capture_zombie_float", 0);
    self.var_934133c0 scene::play(var_d6a665db, var_51d51f4e, ai_zombie);
    if (is_true(ai_zombie.var_2e85cbf2)) {
        self function_3076bc0f(1);
    }
    self flag::clear("eater_eating");
    self flag::clear("looking_at_zombie");
    self flag::clear("zombie_ready");
    if (!self flag::get("complete")) {
        self thread function_21700f1d();
    }
    if (is_true(ai_zombie.var_2e85cbf2)) {
        ai_zombie clientfield::set("soul_capture_zombie_fire", 0);
    }
    if (is_true(self.var_94ca9760)) {
        ai_zombie ghost();
    }
    ai_zombie val::reset("soul_capture_allowdeath", "allowdeath");
    ai_zombie val::reset("soul_capture_takedamage", "takedamage");
    if (isplayer(e_killer)) {
        ai_zombie kill(ai_zombie.origin, e_killer, e_killer, undefined, undefined, 1);
        return;
    }
    ai_zombie kill(ai_zombie.origin, getplayers()[0], getplayers()[0], undefined, undefined, 1);
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 1, eflags: 0x1 linked
// Checksum 0xd07a7102, Offset: 0x5300
// Size: 0x34
function function_64107d05(*notifyhash) {
    if (isdefined(self.var_c1a29994)) {
        self.var_c1a29994 delete();
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 4, eflags: 0x1 linked
// Checksum 0xd9486a21, Offset: 0x5340
// Size: 0x364
function function_fd47174(ai_zombie, mdl_anchor, var_f3a93cf1 = 0, e_killer) {
    self endon(#"cleanup");
    ai_zombie endon(#"death");
    mdl_anchor scene::play("ai_zm_esc_zombie_dreamcatch_rise_sr", "Impact", ai_zombie);
    if (isdefined(ai_zombie gettagorigin("j_ankle_ri"))) {
        playfxontag("maps/zm_red/fx8_soul_red", ai_zombie, "j_ankle_ri");
    } else {
        playfxontag("maps/zm_red/fx8_soul_red", ai_zombie, "tag_origin");
    }
    ai_zombie clientfield::set("soul_capture_zombie_float", 1);
    self thread function_c2cda275(ai_zombie, mdl_anchor);
    s_capture_point = self.var_fe2612fe[#"capture_point"][0];
    var_1ace4b9e = s_capture_point.origin - mdl_anchor.origin;
    var_1ace4b9e = vectorscale(var_1ace4b9e, 0.2);
    n_move_time = scene::function_8582657c("ai_zm_esc_zombie_dreamcatch_rise_sr", "Rise");
    mdl_anchor moveto(mdl_anchor.origin + var_1ace4b9e, n_move_time, n_move_time);
    mdl_anchor waittilltimeout(n_move_time, #"movedone");
    if (var_f3a93cf1) {
        self flag::set("zombie_ready");
        return;
    }
    if (is_true(ai_zombie.var_2e85cbf2)) {
        self function_3076bc0f(0);
    }
    ai_zombie val::reset("soul_capture_allowdeath", "allowdeath");
    ai_zombie val::reset("soul_capture_takedamage", "takedamage");
    gibserverutils::annihilate(ai_zombie);
    if (isplayer(e_killer)) {
        ai_zombie kill(ai_zombie.origin, e_killer, e_killer, undefined, undefined, 1);
        return;
    }
    ai_zombie kill(ai_zombie.origin, getplayers()[0], getplayers()[0], undefined, undefined, 1);
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 2, eflags: 0x1 linked
// Checksum 0xe4735f13, Offset: 0x56b0
// Size: 0xa8
function function_c2cda275(ai_zombie, mdl_anchor) {
    self endon(#"cleanup");
    ai_zombie endon(#"death", #"hash_4ecc58f239a5807a");
    mdl_anchor scene::play("ai_zm_esc_zombie_dreamcatch_rise_sr", "Rise", ai_zombie);
    while (true) {
        mdl_anchor scene::play("ai_zm_esc_zombie_dreamcatch_rise_sr", "Shrink", ai_zombie);
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 2, eflags: 0x1 linked
// Checksum 0xc0b8ffe3, Offset: 0x5760
// Size: 0x18e
function function_b2c1743d(ai_zombie, *var_562512bb) {
    self endon(#"cleanup");
    var_562512bb endon(#"death");
    if (is_true(self.var_94ca9760)) {
        while (true) {
            s_waitresult = var_562512bb waittill(#"gib = head", #"gib = arm_left", #"gib = arm_right", #"gib = leg_left");
            switch (s_waitresult._notify) {
            case #"gib = head":
                var_562512bb gibserverutils::gibhead(var_562512bb);
                break;
            case #"gib = arm_left":
                var_562512bb gibserverutils::gibleftarm(var_562512bb);
                break;
            case #"gib = arm_right":
                var_562512bb gibserverutils::gibrightarm(var_562512bb);
                break;
            case #"gib = leg_left":
                var_562512bb gibserverutils::gibleftleg(var_562512bb);
                break;
            }
        }
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 1, eflags: 0x1 linked
// Checksum 0x3b3d995b, Offset: 0x58f8
// Size: 0x2cc
function function_c97f9fb5(var_42d9dc11 = 0) {
    var_3128fb28 = self.var_3128fb28;
    if (!isdefined(var_3128fb28)) {
        return;
    }
    var_3128fb28 endon(#"death");
    if (!self flag::get("cleanup")) {
        if (isarray(var_3128fb28.var_12d1b199)) {
            array::delete_all(var_3128fb28.var_12d1b199);
            namespace_85745671::function_b70e2a37(var_3128fb28);
        }
        if (is_true(self.var_94ca9760)) {
            self.var_934133c0 scene::stop("aib_t9_zm_dragonhead", 1);
            self.var_36e47091 linkto(self.var_3128fb28);
            self.var_36e47091.animname = "base";
            self.var_934133c0 thread scene::play("p9_fxanim_sr_dragon_statue", self.var_36e47091);
            wait 4;
        }
        if (var_42d9dc11) {
            var_aa549d2c = 8000;
            var_d53d7c96 = 3;
            var_3128fb28 clientfield::set("soul_capture_crystal_leave", 2);
            wait 3;
        } else {
            var_aa549d2c = -2000;
            var_d53d7c96 = 6;
            var_3128fb28 clientfield::set("soul_capture_crystal_leave", 1);
        }
        var_3128fb28 moveto(var_3128fb28.origin + (0, 0, var_aa549d2c), var_d53d7c96);
        var_3128fb28 waittilltimeout(var_d53d7c96, #"movedone");
        var_3128fb28 clientfield::set("soul_capture_crystal_leave", 0);
        wait 1;
    }
    var_3128fb28 delete();
    if (is_true(self.var_94ca9760)) {
        self.var_36e47091 scene::stop("p9_fxanim_sr_dragon_statue", 1);
        if (isdefined(self.var_36e47091)) {
            self.var_36e47091 delete();
        }
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 1, eflags: 0x1 linked
// Checksum 0xad6d128d, Offset: 0x5bd0
// Size: 0x4f0
function function_789b3ddf(b_enable = 0) {
    if (b_enable) {
        s_center = self.var_fe2612fe[#"hash_4cccee63908e50d3"][0];
        if (isdefined(s_center)) {
            v_angles = (s_center.angles[0], s_center.angles[1], 0);
            v_center = s_center.origin + anglestoup(v_angles) * 64;
            var_bf652bf7 = 90;
            var_5f920071 = 0;
            var_f3882141 = 90;
            n_radius = 28;
        } else {
            s_center = self.var_934133c0;
            v_angles = s_center.angles;
            v_center = s_center.origin + anglestoforward(v_angles) * 32;
            var_bf652bf7 = 0;
            var_5f920071 = 90;
            var_f3882141 = 0;
            n_radius = 64;
        }
        var_296670f2 = 0;
        var_e41dced6 = int(360 / self.var_47d69eed);
        for (i = 0; i < self.var_47d69eed; i++) {
            n_state = self.var_e91573e1[i];
            if (n_state < 2) {
                x = cos(var_296670f2) * n_radius;
                y = sin(var_296670f2) * n_radius;
                z = 0;
                v_point = rotatepoint((x, y, z), v_angles);
                if (var_bf652bf7 != 0) {
                    v_point = rotatepointaroundaxis(v_point, anglestoup(v_angles), var_bf652bf7);
                }
                if (var_5f920071 != 0) {
                    v_point = rotatepointaroundaxis(v_point, anglestoright(v_angles), var_5f920071);
                }
                if (var_f3882141 != 0) {
                    v_point = rotatepointaroundaxis(v_point, anglestoforward(v_angles), var_f3882141);
                }
                v_point += v_center;
                var_f662374b = util::spawn_model("tag_origin", v_point);
                self.var_dba85773[i] = var_f662374b;
                switch (n_state) {
                case 0:
                    break;
                case 1:
                    break;
                }
            }
            var_296670f2 += var_e41dced6;
        }
        return;
    }
    var_718deca3 = arraycopy(self.var_dba85773);
    self.var_dba85773 = [];
    arrayremovevalue(var_718deca3, undefined);
    foreach (var_f662374b in var_718deca3) {
        var_f662374b clientfield::set("soul_capture_zombie_tracker", 0);
    }
    wait 1;
    arrayremovevalue(var_718deca3, undefined);
    foreach (var_f662374b in var_718deca3) {
        var_f662374b delete();
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 1, eflags: 0x1 linked
// Checksum 0xef7385d, Offset: 0x60c8
// Size: 0xfc
function function_3076bc0f(var_f3a93cf1 = 0) {
    n_index = self.var_a1b91503;
    self.var_a1b91503++;
    if (var_f3a93cf1) {
        n_state = 1;
        self.var_3f0d6dc1++;
    } else {
        n_state = 2;
    }
    self.var_e91573e1[n_index] = n_state;
    var_f662374b = self.var_dba85773[n_index];
    if (isdefined(var_f662374b)) {
        if (var_f3a93cf1) {
            var_f662374b clientfield::set("soul_capture_zombie_tracker", 2);
            return;
        }
        var_f662374b clientfield::set("soul_capture_zombie_tracker", 0);
        var_f662374b thread util::delayed_delete(1);
    }
}

