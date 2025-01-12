#using script_165beea08a63a243;
#using script_27347f09888ad15;
#using script_3357acf79ce92f4b;
#using script_340a2e805e35f7a2;
#using script_37aecc8eb906ed91;
#using script_6a4a2311f8a4697;
#using script_7464a3005f61a5f6;
#using scripts\abilities\gadgets\gadget_cymbal_monkey;
#using scripts\abilities\gadgets\gadget_homunculus;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_85745671;

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x6
// Checksum 0xfabb94fd, Offset: 0x390
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_74761c506cae8855", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x5 linked
// Checksum 0xbb7f8773, Offset: 0x3d8
// Size: 0x394
function private function_70a657d8() {
    level.var_91a15ec0 = #"world";
    level.zombie_team = #"axis";
    level.attackables = [];
    level.var_7fc48a1a = [];
    /#
        level thread function_b4f41a02();
    #/
    level.var_8a3036cc = 0;
    level.var_57a77bb = 0;
    level.var_d5cd88c2 = 0;
    level.var_2510617f = 0;
    level.var_6eb6193a = 0;
    level.var_7dff87f1 = 0;
    level.var_d0c8ad06 = ["ambush_zombie", "soul_capture_zombie"];
    if (is_true(getgametypesetting(#"hash_3109a8794543000f"))) {
        if (is_true(getgametypesetting(#"hash_42471cb0cbc19544"))) {
            level.zombie_itemlist = #"zombie_itemlist_ammo_close_quarters";
        } else {
            level.zombie_itemlist = #"zombie_itemlist_close_quarters";
        }
    } else if (is_true(getgametypesetting(#"hash_42471cb0cbc19544"))) {
        level.zombie_itemlist = #"zombie_itemlist_ammo";
    } else {
        level.zombie_itemlist = #"zombie_itemlist";
    }
    level.var_db43cbd7 = #"zombie_raygun_itemlist";
    level.var_1b7acd6d = #"cu12_list";
    level.var_72151997 = #"cu13_list";
    level.var_14364e26 = #"cu30_list";
    level.var_7d2bc89 = #"cu31_list";
    clientfield::register("scriptmover", "aizoneflag", 1, 2, "int");
    clientfield::register("scriptmover", "aizoneflag_tu14", 1, 3, "int");
    clientfield::register("scriptmover", "magicboxflag", 1, 3, "int");
    clientfield::register("actor", "zombie_died", 1, 1, "int");
    clientfield::register("toplayer", "zombie_vehicle_shake", 1, 1, "counter");
    namespace_df7b10e3::register_slowdown(#"hash_4ec13a63f7786c40", 0.5, 1.5);
    callback::on_ai_damage(&on_ai_damage);
}

/#

    // Namespace namespace_85745671/namespace_85745671
    // Params 0, eflags: 0x0
    // Checksum 0xa563102d, Offset: 0x778
    // Size: 0x540
    function function_b4f41a02() {
        level endon(#"game_ended");
        aitypes = function_19df1c1c();
        setdvar(#"hash_70cb00491d863294", "<dev string:x38>");
        setdvar(#"hash_209287456d55fca1", "<dev string:x38>");
        foreach (type in aitypes) {
            if (function_e949cfd7(type)) {
                util::add_debug_command("<dev string:x3c>" + function_9e72a96(type) + "<dev string:x5d>" + function_9e72a96(type) + "<dev string:x84>");
                util::add_debug_command("<dev string:x8a>" + function_9e72a96(type) + "<dev string:xb0>" + function_9e72a96(type) + "<dev string:x84>");
            }
        }
        util::add_debug_command("<dev string:xdc>");
        util::add_debug_command("<dev string:x121>");
        util::add_debug_command("<dev string:x168>");
        util::add_debug_command("<dev string:x18c>");
        while (true) {
            wait 0.1;
            cmd = getdvarstring(#"hash_209287456d55fca1", "<dev string:x38>");
            if (cmd == "<dev string:x38>") {
                continue;
            }
            cmd_tokens = strtok(cmd, "<dev string:x1ce>");
            switch (cmd_tokens[0]) {
            case #"hash_c0b89e8d4a71cff":
                player = level.players[0];
                direction = player getplayerangles();
                direction_vec = anglestoforward(direction);
                eye = player geteye();
                direction_vec = (direction_vec[0] * 8000, direction_vec[1] * 8000, direction_vec[2] * 8000);
                trace = bullettrace(eye, eye + direction_vec, 0, undefined);
                ai = spawnactor(cmd_tokens[1], trace[#"position"], (0, 0, 0), undefined, 1);
                break;
            case #"hash_deec03a3269d42":
                player = level.players[0];
                direction = player getplayerangles();
                direction_vec = anglestoforward(direction);
                eye = player geteye();
                direction_vec = (direction_vec[0] * 8000, direction_vec[1] * 8000, direction_vec[2] * 8000);
                trace = bullettrace(eye, eye + direction_vec, 0, undefined);
                spawner::add_ai_spawn_function(&function_df8d461e);
                ai = spawnactor(cmd_tokens[1], trace[#"position"], (0, 0, 0), "<dev string:x1d3>", 1);
                spawner::function_932006d1(&function_df8d461e);
                break;
            }
            setdvar(#"hash_209287456d55fca1", "<dev string:x38>");
        }
    }

    // Namespace namespace_85745671/namespace_85745671
    // Params 0, eflags: 0x4
    // Checksum 0x3e6a584d, Offset: 0xcc0
    // Size: 0x3c
    function private function_df8d461e() {
        if (self.targetname === "<dev string:x1d3>") {
            self.ignoreall = 1;
            awareness::pause(self);
        }
    }

    // Namespace namespace_85745671/namespace_85745671
    // Params 0, eflags: 0x0
    // Checksum 0x68b2cf72, Offset: 0xd08
    // Size: 0xdfe
    function debug_ai() {
        level endon(#"game_ended");
        level.var_b4702614 = [];
        level.var_b4702614[0] = "<dev string:x1e4>";
        level.var_b4702614[1] = "<dev string:x1f1>";
        level.var_b4702614[2] = "<dev string:x1fb>";
        level.var_b4702614[3] = "<dev string:x209>";
        level.var_b4702614[4] = "<dev string:x212>";
        level.var_b4702614[5] = "<dev string:x21b>";
        level.var_b4702614[6] = "<dev string:x226>";
        while (true) {
            if (is_true(level.var_e066667d) && isdefined(level.var_91a15ec0)) {
                var_1795ed47 = getaiteamarray(level.var_91a15ec0);
                foreach (entity in var_1795ed47) {
                    if (!isalive(entity)) {
                        continue;
                    }
                    org = entity.origin + (0, 0, 100);
                    if (isdefined(entity.aistate)) {
                        org = entity.origin + (0, 0, 90);
                        if (getdvarint(#"recorder_enablerec", 0)) {
                            record3dtext((isdefined(level.var_b4702614[entity.aistate]) ? level.var_b4702614[entity.aistate] : "<dev string:x235>") + "<dev string:x240>" + entity.health, entity.origin, (1, 0.5, 0), "<dev string:x245>", entity);
                        } else {
                            print3d(org, (isdefined(level.var_b4702614[entity.aistate]) ? level.var_b4702614[entity.aistate] : "<dev string:x235>") + "<dev string:x240>" + entity.health, (1, 0.5, 0), 1, 0.2);
                        }
                    }
                    ai_cansee = 0;
                    if (isdefined(entity.enemy) && entity cansee(entity.enemy)) {
                        ai_cansee = 1;
                    }
                    if (isdefined(entity.var_5a8f690)) {
                        org = entity.origin + (0, 0, 85);
                        if (getdvarint(#"recorder_enablerec", 0)) {
                            record3dtext("<dev string:x24f>" + entity.var_5a8f690 + "<dev string:x25a>" + ai_cansee + "<dev string:x25f>", entity.origin, (1, 0.5, 0), "<dev string:x245>", entity);
                        } else {
                            print3d(org, "<dev string:x24f>" + entity.var_5a8f690 + "<dev string:x25a>" + ai_cansee + "<dev string:x25f>", (1, 0.5, 0), 1, 0.2);
                        }
                    }
                    if (isdefined(entity.allowoffnavmesh)) {
                        org = entity.origin + (0, 0, 80);
                        if (getdvarint(#"recorder_enablerec", 0)) {
                            record3dtext("<dev string:x264>" + entity.allowoffnavmesh, entity.origin, (1, 0.5, 0), "<dev string:x245>", entity);
                        } else {
                            print3d(org, "<dev string:x264>" + entity.allowoffnavmesh, (1, 0.5, 0), 1, 0.2);
                        }
                    }
                    if (isdefined(entity.var_6e3313ab)) {
                        org = entity.origin + (0, 0, 75);
                        if (getdvarint(#"recorder_enablerec", 0)) {
                            record3dtext("<dev string:x26f>" + entity.var_6e3313ab, entity.origin, (1, 0.5, 0), "<dev string:x245>", entity);
                        } else {
                            print3d(org, "<dev string:x26f>" + entity.var_6e3313ab, (1, 0.5, 0), 1, 0.2);
                        }
                    }
                    if (isdefined(entity.var_ad26639d)) {
                        org = entity.origin + (0, 0, 70);
                        if (getdvarint(#"recorder_enablerec", 0)) {
                            record3dtext("<dev string:x27a>" + entity.var_ad26639d, entity.origin, (1, 0.5, 0), "<dev string:x245>", entity);
                        } else {
                            print3d(org, "<dev string:x27a>" + entity.var_ad26639d, (1, 0.5, 0), 1, 0.2);
                        }
                    }
                    if (isdefined(entity.var_9a79d89d)) {
                        origin = entity.var_9a79d89d;
                        if (!isvec(entity.var_9a79d89d)) {
                            origin = entity.var_9a79d89d.origin;
                        }
                        if (getdvarint(#"recorder_enablerec", 0)) {
                            record3dtext("<dev string:x286>", entity.origin, (0, 0, 1), "<dev string:x245>", entity);
                        } else {
                            print3d(entity.var_9a79d89d + (0, 0, 10), "<dev string:x286>", (0, 0, 1), 1, 1);
                        }
                    }
                    if (isdefined(entity.var_db912cfe) && isdefined(entity.surfacetype)) {
                        org = entity.origin + (0, 0, 70);
                        if (getdvarint(#"recorder_enablerec", 0)) {
                            record3dtext("<dev string:x295>" + entity.surfacetype + "<dev string:x2a1>" + entity.var_db912cfe, entity.origin, (1, 0.5, 0), "<dev string:x245>", entity);
                        } else {
                            print3d(org, "<dev string:x295>" + entity.surfacetype + "<dev string:x2a1>" + entity.var_db912cfe, (1, 0.5, 0), 1, 0.2);
                        }
                    }
                    if (isdefined(entity.is_special)) {
                        org = entity.origin + (0, 0, 200);
                        if (getdvarint(#"recorder_enablerec", 0)) {
                            record3dtext("<dev string:x2aa>" + entity.is_special + "<dev string:x25a>" + entity.is_special + "<dev string:x25f>", entity.origin, (1, 0.5, 0), "<dev string:x245>", entity);
                        } else {
                            print3d(org, "<dev string:x2aa>" + entity.is_special + "<dev string:x25a>" + entity.is_special + "<dev string:x25f>", (1, 0.5, 0), 1, 2);
                        }
                    }
                    if (isdefined(entity.movetime) && getdvarint(#"hash_1aebd3ffed21a22a", 0)) {
                        org = entity.origin + (0, 0, 90);
                        if (getdvarint(#"recorder_enablerec", 0)) {
                            record3dtext("<dev string:x2b6>" + gettime() - entity.movetime, entity.origin, (1, 0.5, 0), "<dev string:x245>", entity);
                        } else {
                            print3d(org, "<dev string:x2b6>" + gettime() - entity.movetime, (1, 0.5, 0), 1, 0.2);
                        }
                    }
                    if (isdefined(entity.idletime) && getdvarint(#"hash_1aebd3ffed21a22a", 0)) {
                        org = entity.origin + (0, 0, 95);
                        if (getdvarint(#"recorder_enablerec", 0)) {
                            record3dtext("<dev string:x2c3>" + gettime() - entity.idletime, entity.origin, (1, 0.5, 0), "<dev string:x245>", entity);
                        } else {
                            print3d(org, "<dev string:x2c3>" + gettime() - entity.idletime, (1, 0.5, 0), 1, 0.2);
                        }
                    }
                    if (isdefined(entity.attackable) && getdvarint(#"hash_6e5b3c35cb223a9d", 0)) {
                        recordline(entity.origin, entity.attackable_slot.origin, (0, 1, 0));
                        recordstar(entity.attackable_slot.origin, (0, 0, 1));
                        org = entity.origin + (0, 0, 100);
                        if (getdvarint(#"recorder_enablerec", 0)) {
                            record3dtext("<dev string:x2d0>" + distance2dsquared(entity.origin, entity.attackable_slot.origin), entity.origin, (1, 0.5, 0), "<dev string:x245>", entity);
                        } else {
                            print3d(org, "<dev string:x2d0>" + distance2dsquared(entity.origin, entity.attackable_slot.origin), (1, 0.5, 0), 1, 0.2);
                        }
                    }
                    if (isdefined(entity.var_6c408220)) {
                        entity [[ entity.var_6c408220 ]]();
                    }
                }
            }
            waitframe(1);
        }
    }

#/

// Namespace namespace_85745671/namespace_85745671
// Params 3, eflags: 0x1 linked
// Checksum 0xb9cb559c, Offset: 0x1b10
// Size: 0x12c
function function_55625f76(origin, angles, anim_name) {
    self endon(#"death");
    self ghost();
    self orientmode("face default");
    var_e14d27e8 = getanimlength(anim_name);
    self animscripted("rise_anim", origin, angles, anim_name, "normal");
    util::wait_network_frame();
    self show();
    self waittillmatchtimeout(var_e14d27e8, {#notetrack:"end"}, #"rise_anim");
    self setgoal(self.origin);
}

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x1 linked
// Checksum 0xb42782e9, Offset: 0x1c48
// Size: 0x16c
function function_2089690e() {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    if (is_true(self.var_83fa6083)) {
        return;
    }
    self show();
    var_90d0c0ff = isdefined(self.var_c9b11cb3) ? self.var_c9b11cb3 : self.var_90d0c0ff;
    spawn_anim = isdefined(self.var_d32d749d) ? self.var_d32d749d : self.spawn_anim;
    if (!isdefined(spawn_anim) && isdefined(var_90d0c0ff)) {
        spawn_anim = self animmappingsearch(var_90d0c0ff);
    }
    if (!isdefined(spawn_anim)) {
        return;
    }
    if (isdefined(self.var_f8df968e)) {
        [[ self.var_f8df968e ]](self.origin, self.angles, spawn_anim);
    } else {
        function_55625f76(self.origin, self.angles, spawn_anim);
    }
    self callback::callback(#"hash_790882ac8688cee5", {#spawn_anim:spawn_anim});
}

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x1 linked
// Checksum 0x738638a, Offset: 0x1dc0
// Size: 0xf2
function function_347f7d34() {
    a_valid_players = [];
    foreach (player in getplayers()) {
        if (is_player_valid(player)) {
            if (!isdefined(a_valid_players)) {
                a_valid_players = [];
            } else if (!isarray(a_valid_players)) {
                a_valid_players = array(a_valid_players);
            }
            a_valid_players[a_valid_players.size] = player;
        }
    }
    return a_valid_players;
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0xc74b0a96, Offset: 0x1ec0
// Size: 0x110
function is_player_valid(player) {
    if (!isdefined(player)) {
        return false;
    }
    if (!isalive(player)) {
        return false;
    }
    if (!isplayer(player) && !isdefined(player.var_d003d23c)) {
        return false;
    }
    if (isplayer(player)) {
        if (player.sessionstate == "spectator") {
            return false;
        }
        if (player.sessionstate == "intermission") {
            return false;
        }
        if (is_true(player.intermission)) {
            return false;
        }
        if (player laststand::player_is_in_laststand()) {
            return false;
        }
    }
    if (player.ignoreme || player isnotarget()) {
        return false;
    }
    return true;
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0xb733f39c, Offset: 0x1fd8
// Size: 0x78
function function_1b9ed9b0(companion) {
    if (!isalive(companion)) {
        return false;
    }
    if (!is_true(companion.var_d003d23c)) {
        return false;
    }
    if (companion.ignoreme || companion isnotarget()) {
        return false;
    }
    return true;
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0x5520437c, Offset: 0x2058
// Size: 0x2fc
function function_9fa1c215(ai_zone) {
    if (isdefined(level.var_18bf5e98)) {
        return [[ level.var_18bf5e98 ]]();
    }
    itemlist = level.zombie_itemlist;
    var_1130690 = 0;
    if (is_true(level.var_b4143320)) {
        var_d0c1e811 = 0;
        if (death_circle::is_active() && isdefined(level.deathcircleindex)) {
            if (level.deathcircleindex < level.var_1a35832e) {
                var_d0c1e811 = 1;
            }
        } else {
            var_d0c1e811 = 1;
        }
        if (var_d0c1e811 && isdefined(ai_zone) && ai_zone.var_c573acdd == ai_zone.var_ce8df1c9) {
            if (level.var_d5cd88c2 < level.var_acfc1745 && randomfloat(1) <= 0.3) {
                itemlist = level.var_1b7acd6d;
                level.var_d5cd88c2++;
                var_1130690 = 1;
                level.var_57a77bb = 1;
            }
            if (!level.var_2510617f < level.var_1b2f5c9d && randomfloat(1) <= 0.3) {
                itemlist = level.var_72151997;
                level.var_2510617f++;
                var_1130690 = 1;
                level.var_57a77bb = 0;
            }
            if (!level.var_6eb6193a < level.var_ad2edeba && randomfloat(1) <= 0.3) {
                itemlist = level.var_14364e26;
                level.var_6eb6193a++;
                var_1130690 = 1;
                level.var_57a77bb = 0;
            }
            if (!level.var_7dff87f1 < level.var_a71296ac && randomfloat(1) <= 0.3) {
                itemlist = level.var_7d2bc89;
                level.var_7dff87f1++;
                var_1130690 = 1;
                level.var_57a77bb = 0;
            }
        }
    }
    if (!var_1130690) {
        if (randomint(100) <= 2) {
            if (!level.var_8a3036cc) {
                itemlist = level.var_db43cbd7;
                level.var_8a3036cc = 1;
            }
        }
    }
    if (isdefined(ai_zone)) {
        ai_zone.var_c573acdd++;
    }
    return itemlist;
}

// Namespace namespace_85745671/namespace_85745671
// Params 2, eflags: 0x0
// Checksum 0x6c121bae, Offset: 0x2360
// Size: 0x424
function function_f311bd4c(ai_zone, var_ee6563f8 = 1) {
    self notify("50eeeb8c3ba0c11d");
    self endon("50eeeb8c3ba0c11d");
    if (var_ee6563f8) {
        waitresult = self waittill(#"death");
    } else {
        waitresult = spawnstruct();
        waitresult.attacker = function_a1ef346b()[0];
    }
    var_a98b31aa = isdefined(self.ai_zone) && isdefined(self.ai_zone.def);
    self.ai_zone = undefined;
    if (isdefined(self.fxent)) {
        self clientfield::set("zombie_has_microwave", 0);
        self.fxent delete();
    }
    if (isplayer(waitresult.attacker)) {
        if (is_true(self.quacknarok)) {
            self.quacknarok = 0;
            self detach(#"p8_zm_red_floatie_duck", "j_spinelower");
            self clientfield::set("zombie_died", 1);
        }
        scoreevents::processscoreevent(#"zombie_kills", waitresult.attacker, undefined, undefined);
        var_b25650ab = spawnstruct();
        var_b25650ab.origin = self.origin;
        var_b25650ab.archetype = self.archetype;
        if (isdefined(self.var_e575a1bb)) {
            var_b25650ab.var_e575a1bb = self.var_e575a1bb;
        }
        if (isdefined(self.var_40c895b9)) {
            var_b25650ab.var_40c895b9 = self.var_40c895b9;
        }
        if (isdefined(self.var_e154425f)) {
            var_b25650ab.var_e154425f = self.var_e154425f;
        }
        if (isdefined(self.var_4f53e075)) {
            var_b25650ab.var_4f53e075 = self.var_4f53e075;
        }
        if (isdefined(var_a98b31aa) || is_true(self.var_54f8158e)) {
            if (!level.inprematchperiod) {
                waitresult.attacker stats::function_d40764f3(#"kills_zombie", 1);
            }
            if (isdefined(self.var_2cee3556)) {
                var_b25650ab.var_2cee3556 = self.var_2cee3556;
                foreach (item_list, drop_count in var_b25650ab.var_2cee3556) {
                    var_b25650ab.var_6a7537d8 = drop_count;
                    var_b25650ab namespace_7da6f8ca::function_d92e3c5a(waitresult.attacker, ai_zone, item_list);
                }
                return;
            }
            if (isdefined(self.var_ef46cd4)) {
                self namespace_7da6f8ca::function_d92e3c5a(waitresult.attacker, ai_zone, self.var_ef46cd4);
                return;
            }
            itemlist = function_9fa1c215(ai_zone);
            if (isdefined(itemlist)) {
                self namespace_7da6f8ca::function_d92e3c5a(waitresult.attacker, ai_zone, itemlist);
            }
        }
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0x61817221, Offset: 0x2790
// Size: 0xb2
function function_9758722(speed) {
    if (self.zombie_move_speed === speed) {
        return;
    }
    self.zombie_move_speed = speed;
    if (!isdefined(self.zombie_arms_position)) {
        self.zombie_arms_position = math::cointoss() == 1 ? "up" : "down";
    }
    if (isdefined(level.var_9ee73630)) {
        self.variant_type = randomint(level.var_9ee73630[self.zombie_move_speed][self.zombie_arms_position]);
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x0
// Checksum 0x50d7a9be, Offset: 0x2850
// Size: 0x14c
function get_pathnode_path(pathnode) {
    path_struct = {#path:array(pathnode), #loops:0};
    var_592eaf7 = pathnode;
    while (isdefined(var_592eaf7.target)) {
        var_592eaf7 = getnode(var_592eaf7.target, "targetname");
        if (!isdefined(var_592eaf7)) {
            break;
        }
        if (isinarray(path_struct.path, var_592eaf7)) {
            path_struct.loops = 1;
            break;
        }
        if (!isdefined(path_struct.path)) {
            path_struct.path = [];
        } else if (!isarray(path_struct.path)) {
            path_struct.path = array(path_struct.path);
        }
        path_struct.path[path_struct.path.size] = var_592eaf7;
    }
    return path_struct;
}

// Namespace namespace_85745671/namespace_85745671
// Params 2, eflags: 0x1 linked
// Checksum 0xc1725f02, Offset: 0x29a8
// Size: 0xae
function function_9a5f0c0(startpt, endpt) {
    self endon(#"delete");
    self.origin = startpt + (0, 0, 10);
    time = self namespace_7da6f8ca::fake_physicslaunch(endpt, 100);
    self playsound(#"zmb_spawn_powerup");
    wait time;
    if (isdefined(self)) {
        self.origin = endpt;
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 2, eflags: 0x0
// Checksum 0xe08c95b9, Offset: 0x2a60
// Size: 0x102
function function_bf357ddf(spawnpt, itemlist) {
    waitresult = self waittill(#"death");
    if (isdefined(spawnpt.target)) {
        var_10508147 = struct::get(spawnpt.target, "targetname");
        items = self namespace_65181344::function_fd87c780(itemlist, 1);
        for (i = 0; i < items.size; i++) {
            item = items[i];
            if (isdefined(item)) {
                item thread function_9a5f0c0(self.origin, var_10508147.origin);
            }
            waitframe(1);
        }
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x0
// Checksum 0xe7ad1173, Offset: 0x2b70
// Size: 0x106
function function_f656f22e(ai_zone) {
    all_ai = getaiteamarray(#"world");
    if (isdefined(all_ai) && all_ai.size > 0) {
        foreach (ai in all_ai) {
            if (isdefined(ai.var_ea7e9b57) && ai.var_ea7e9b57 == ai_zone) {
                ai kill(undefined, undefined, undefined, undefined, 0, 1);
                waitframe(1);
            }
        }
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 6, eflags: 0x5 linked
// Checksum 0xcce535cb, Offset: 0x2c80
// Size: 0x206
function private function_ebf83b77(origin, entity, var_c83b605b, var_da1bc9fc, max_range, attackable) {
    var_c7089ecd = origin - attackable.origin;
    var_7e365edf = randomfloatrange(var_da1bc9fc, max_range);
    var_c7089ecd = vectornormalize(var_c7089ecd);
    var_b042e906 = var_c7089ecd * var_7e365edf;
    var_72e946f3 = getclosestpointonnavmesh(var_c83b605b + var_c7089ecd * entity getpathfindingradius() * 1.1, 128, entity getpathfindingradius());
    if (!isdefined(var_72e946f3)) {
        return undefined;
    }
    var_812bc6e0 = checknavmeshdirection(var_72e946f3, var_b042e906, var_7e365edf - entity getpathfindingradius() * 1.2, entity getpathfindingradius() * 1.1);
    /#
        recordline(var_c83b605b, var_c83b605b + var_b042e906, (0, 0, 1), "<dev string:x245>");
        recordline(var_c83b605b, var_812bc6e0, (1, 0.5, 0), "<dev string:x245>");
    #/
    if (distancesquared(var_812bc6e0, var_72e946f3) < function_a3f6cdac(var_da1bc9fc)) {
        return undefined;
    }
    if (!function_57816a50(var_812bc6e0, entity, attackable)) {
        return undefined;
    }
    return var_812bc6e0;
}

// Namespace namespace_85745671/namespace_85745671
// Params 3, eflags: 0x5 linked
// Checksum 0xbe462cbc, Offset: 0x2e90
// Size: 0x15c
function private function_57816a50(point, entity, attackable) {
    var_c76dd642 = entity getpathfindingradius();
    if (isdefined(attackable.var_b79a8ac7) && isdefined(attackable) && isdefined(attackable.var_b79a8ac7.var_3a3788af)) {
        foreach (attacker in attackable.var_b79a8ac7.var_3a3788af) {
            if (!isdefined(attacker.var_3f8ea75c)) {
                continue;
            }
            var_d0fcbffe = attacker getpathfindingradius();
            if (distancesquared(point, attacker.var_3f8ea75c) <= function_a3f6cdac(var_d0fcbffe + var_c76dd642)) {
                return false;
            }
        }
    }
    return true;
}

// Namespace namespace_85745671/namespace_85745671
// Params 4, eflags: 0x0
// Checksum 0x5a82ae8a, Offset: 0x2ff8
// Size: 0x14a
function function_12d90bae(entity, var_da1bc9fc, max_range, attackable) {
    var_c83b605b = getclosestpointonnavmesh(attackable.origin, 128, entity getpathfindingradius());
    if (!isdefined(var_c83b605b)) {
        return undefined;
    }
    spots = arraysortclosest(attackable.var_b79a8ac7.slots, entity.origin);
    foreach (spot in spots) {
        var_812bc6e0 = function_ebf83b77(spot.origin, entity, var_c83b605b, var_da1bc9fc, max_range, attackable);
        if (isdefined(var_812bc6e0)) {
            return var_812bc6e0;
        }
    }
    return undefined;
}

// Namespace namespace_85745671/namespace_85745671
// Params 3, eflags: 0x1 linked
// Checksum 0xfbd9d753, Offset: 0x3150
// Size: 0x244
function get_attackable(entity, var_83917763, var_bb6705b) {
    if (!is_true(var_83917763) && !isinarray(level.var_8de0b84e, entity getentitynumber())) {
        return undefined;
    }
    if (isdefined(level.attackables)) {
        arrayremovevalue(level.attackables, undefined);
        foreach (attackable in level.attackables) {
            if (is_true(entity.var_12af7864)) {
                return undefined;
            }
            if (!isdefined(attackable.var_b79a8ac7) || !isdefined(attackable.var_b79a8ac7.var_f019ea1a)) {
                continue;
            }
            dist = distancesquared(entity.origin, attackable.origin);
            if (dist < function_a3f6cdac(attackable.var_b79a8ac7.var_f019ea1a)) {
                if (attackable get_attackable_slot(entity)) {
                    return attackable;
                }
                if (is_true(var_bb6705b)) {
                    if (!isdefined(attackable.var_b79a8ac7.var_3a3788af)) {
                        attackable.var_b79a8ac7.var_3a3788af = [];
                    }
                    attackable.var_b79a8ac7.var_3a3788af[attackable.var_b79a8ac7.var_3a3788af.size] = entity;
                    return attackable;
                }
            }
        }
    }
    return undefined;
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0xffe04a2e, Offset: 0x33a0
// Size: 0x216
function get_attackable_slot(entity) {
    if (!isdefined(self.var_b79a8ac7)) {
        return false;
    }
    self clear_slots();
    var_4dbfc246 = [];
    var_34bcb139 = [];
    foreach (slot in self.var_b79a8ac7.slots) {
        if (!isdefined(slot.entity)) {
            var_34bcb139[var_34bcb139.size] = slot;
        }
    }
    if (var_34bcb139.size == 0) {
        return false;
    }
    var_754df93c = entity.origin;
    strteleportst = arraygetclosest(var_754df93c, var_34bcb139);
    if (strteleportst.on_navmesh) {
        var_acdc8d71 = getclosestpointonnavmesh(strteleportst.origin, entity getpathfindingradius(), entity getpathfindingradius());
        if (isdefined(var_acdc8d71)) {
            strteleportst.entity = entity;
            entity.var_b238ef38 = {#slot:strteleportst, #position:var_acdc8d71};
            return true;
        }
    } else {
        strteleportst.entity = entity;
        entity.var_b238ef38 = {#slot:strteleportst, #position:strteleportst.origin};
        return true;
    }
    return false;
}

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x1 linked
// Checksum 0x1cc64f86, Offset: 0x35c0
// Size: 0xee
function clear_slots() {
    if (!isdefined(self.var_b79a8ac7)) {
        return;
    }
    foreach (slot in self.var_b79a8ac7.slots) {
        if (!isalive(slot.entity)) {
            slot.entity = undefined;
            continue;
        }
        if (is_true(slot.entity.missinglegs)) {
            slot.entity = undefined;
        }
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0x32351090, Offset: 0x36b8
// Size: 0x78
function function_2b925fa5(entity) {
    if (isdefined(entity.attackable)) {
        entity.attackable = undefined;
    }
    if (isdefined(entity.var_b238ef38)) {
        entity.var_b238ef38.slot.entity = undefined;
        entity.var_b238ef38 = undefined;
    }
    entity.var_3f8ea75c = undefined;
    entity notify(#"hash_5114eb062d7568b6");
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0x7fad919e, Offset: 0x3738
// Size: 0x1b4
function function_b70e2a37(attackable) {
    if (!isdefined(attackable.var_b79a8ac7)) {
        return;
    }
    foreach (slot in attackable.var_b79a8ac7.slots) {
        if (!isalive(slot.entity)) {
            continue;
        }
        function_2b925fa5(slot.entity);
    }
    if (isdefined(attackable.var_b79a8ac7.var_3a3788af)) {
        foreach (attacker in attackable.var_b79a8ac7.var_3a3788af) {
            if (!isalive(attacker)) {
                continue;
            }
            function_2b925fa5(attacker);
        }
    }
    attackable.var_b79a8ac7 = undefined;
    arrayremovevalue(level.attackables, attackable);
}

// Namespace namespace_85745671/namespace_85745671
// Params 6, eflags: 0x1 linked
// Checksum 0x252e4616, Offset: 0x38f8
// Size: 0x39e
function function_bdb2b85b(entity, origin, angles, radius, num_spots, var_7a2632b5) {
    level endon(#"game_ended");
    slots = [];
    mins = (-10, -10, 0);
    maxs = (10, 10, 48);
    /#
        record3dtext("<dev string:x2e1>", origin, (0, 0, 1));
    #/
    for (i = 0; i < num_spots; i++) {
        t = mapfloat(0, num_spots, 0, 360, i);
        x = radius * cos(t + angles[1]);
        y = radius * sin(t + angles[1]);
        pos = (x, y, 0) + origin;
        if (!bullettracepassed(origin + (0, 0, 5), pos + (0, 0, 5), 0, entity)) {
            if (i % 2 == 1) {
                waitframe(1);
            }
            continue;
        }
        var_e07c7e8 = physicstrace(pos + (0, 0, 10), pos + (0, 0, -10), mins, maxs, self, 1);
        var_c060661b = var_e07c7e8[#"position"];
        var_3e98a413 = getclosestpointonnavmesh(var_c060661b, 64, 15);
        if (isdefined(var_3e98a413)) {
            /#
                recordstar(var_3e98a413, (0, 1, 0));
            #/
            slots[slots.size] = {#origin:var_3e98a413, #on_navmesh:1};
        } else if (isdefined(var_c060661b)) {
            if (isdefined(var_7a2632b5)) {
                var_acdc8d71 = getclosestpointonnavmesh(var_c060661b, var_7a2632b5, 15);
            }
            /#
                if (isdefined(var_acdc8d71)) {
                    recordstar(var_acdc8d71, (1, 0, 1));
                }
            #/
            /#
                recordstar(var_c060661b, (1, 0.5, 0));
            #/
            slots[slots.size] = {#origin:var_c060661b, #on_navmesh:0, #var_acdc8d71:var_acdc8d71};
        }
        if (i % 2 == 1) {
            waitframe(1);
        }
    }
    return slots;
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0xe9599d8a, Offset: 0x3ca0
// Size: 0x2c4
function function_16e2f075(params) {
    self.var_cd7665dd = gettime();
    if (isdefined(self.var_1b5e8136) && gettime() - self.var_1b5e8136 > 1000) {
        return;
    }
    if (!is_true(self.var_85c3882d)) {
        self.var_1b5e8136 = gettime();
    }
    self.var_85c3882d = 1;
    if (!is_true(self.var_a9d9d11b) || self.var_a9d9d11b < gettime()) {
        self.var_a9d9d11b = gettime() + 500;
        if (is_true(level.is_survival)) {
            switch (self.archetype) {
            case #"zombie":
                damageamount = randomintrange(20, 60);
                self thread namespace_df7b10e3::slowdown(#"hash_4ec13a63f7786c40");
                break;
            case #"zombie_dog":
                damageamount = self.health;
                break;
            case #"avogadro":
                damageamount = 5;
                break;
            }
            if (!isdefined(damageamount)) {
                damageamount = int(self.health * 0.1);
            }
        } else {
            damageamount = isdefined(level.var_87226c31.bundle.var_a9502662) ? level.var_87226c31.bundle.var_a9502662 : 0;
        }
        self dodamage(damageamount, self.origin, params.wire.owner, params.wire, undefined, "MOD_IMPACT", 0, level.var_87226c31.var_3e7344ee);
    }
    if (isdefined(level.var_f2e76de4)) {
        if (!isinarray(level.var_f2e76de4, self)) {
            level.var_f2e76de4[level.var_f2e76de4.size] = self;
        }
        return;
    }
    level.var_f2e76de4 = array(self);
    level thread function_7a87d2a7();
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0x931ef4e7, Offset: 0x3f70
// Size: 0x1fa
function function_7a87d2a7(*damageduration) {
    level endon(#"game_ended");
    self endon(#"death");
    while (true) {
        var_202d087b = [];
        foreach (ai in level.var_f2e76de4) {
            if (!isdefined(ai) || !isalive(ai)) {
                var_202d087b[var_202d087b.size] = ai;
                continue;
            }
            timesincestart = gettime() - ai.var_1b5e8136;
            if (timesincestart > 1000) {
                ai.var_85c3882d = undefined;
            }
            timesincelast = gettime() - ai.var_cd7665dd;
            if (timesincelast > 250) {
                ai.var_85c3882d = undefined;
                ai.var_1b5e8136 = undefined;
                var_202d087b[var_202d087b.size] = ai;
            }
        }
        foreach (ai in var_202d087b) {
            arrayremovevalue(level.var_f2e76de4, ai);
        }
        waitframe(1);
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x0
// Checksum 0x39bb628d, Offset: 0x4178
// Size: 0x24
function function_b7dc3ab4(var_45e5ae09) {
    level thread function_301d4089(var_45e5ae09);
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x5 linked
// Checksum 0x9e9bbbf9, Offset: 0x41a8
// Size: 0xa4
function private function_301d4089(var_45e5ae09) {
    level function_b0dc6ff2(var_45e5ae09);
    if (isdefined(getgametypesetting(#"hash_2d40f1434ed94a2b")) ? getgametypesetting(#"hash_2d40f1434ed94a2b") : 0) {
        level function_71578099();
        return;
    }
    level function_9caf8627();
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0x536b2fbd, Offset: 0x4258
// Size: 0x72
function function_d65d6079(targetname) {
    if (!isdefined(targetname)) {
        return undefined;
    }
    dynentarray = function_c79d31c4(targetname);
    if (isdefined(dynentarray) && dynentarray.size > 0) {
        return dynentarray[0];
    }
    return getent(targetname, "target");
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0x788cdc5d, Offset: 0x42d8
// Size: 0x296
function function_5a4a952a(node) {
    if (node.type === #"begin" || node.type === #"end") {
        return getothernodeinnegotiationpair(node);
    }
    if (node.type === #"volume") {
        var_41c9f1a0 = undefined;
        backwards = 0;
        if (isdefined(node.target)) {
            var_41c9f1a0 = getnodearray(node.target, "targetname");
        }
        if (!isdefined(var_41c9f1a0) && isdefined(node.targetname)) {
            backwards = 1;
            var_41c9f1a0 = getnodearray(node.targetname, "target");
        }
        if (isdefined(var_41c9f1a0) && var_41c9f1a0.size == 1) {
            foreach (othernode in var_41c9f1a0) {
                if (othernode.type === #"volume") {
                    return othernode;
                }
                if (othernode.type === #"mantle") {
                    if (backwards && isdefined(othernode.targetname)) {
                        var_6bf8a539 = getnodearray(othernode.targetname, "target");
                        if (isdefined(var_6bf8a539) && var_6bf8a539.size == 1) {
                            return var_6bf8a539[0];
                        }
                        continue;
                    }
                    if (isdefined(othernode.target)) {
                        var_6bf8a539 = getnodearray(othernode.target, "targetname");
                        if (isdefined(var_6bf8a539) && var_6bf8a539.size == 1) {
                            return var_6bf8a539[0];
                        }
                    }
                }
            }
        }
    }
    return undefined;
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0xe53fb690, Offset: 0x4578
// Size: 0x154
function function_7085a000(node) {
    var_59476739 = function_d65d6079(node.targetname);
    if (!isdefined(var_59476739)) {
        othernode = function_5a4a952a(node);
        if (isdefined(othernode)) {
            var_59476739 = function_d65d6079(othernode.targetname);
        }
    }
    if (!getdvarint(#"hash_397bf855bf5ab4de", 1) && isdefined(var_59476739) && (var_59476739.var_15d44120 === #"p8_fxanim_wz_rollup_door_medium_mod" || var_59476739.var_15d44120 === #"hash_30cb30fe79cd7bc0" || var_59476739.var_15d44120 === #"p8_fxanim_wz_rollup_door_small_mod" || var_59476739.var_15d44120 === #"p8_fxanim_wz_rollup_door_large_mod")) {
        function_dc0a8e61(node, 1);
        return undefined;
    }
    return var_59476739;
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0xe548720d, Offset: 0x46d8
// Size: 0x2e4
function function_b0dc6ff2(var_45e5ae09) {
    nodes = getallnodes();
    var_4c106ee3 = 0;
    var_8d594927 = undefined;
    if (isarray(var_45e5ae09) && var_45e5ae09.size > 0) {
        var_8d594927 = util::spawn_model("tag_origin");
    }
    var_fa527c6d = 0;
    foreach (node in nodes) {
        var_4c106ee3 = (var_4c106ee3 + 1) % 50;
        if (!(var_4c106ee3 % 50)) {
            waitframe(1);
        }
        if (node.type != #"begin" && node.type != #"end" && node.type != #"volume") {
            continue;
        }
        var_59476739 = function_7085a000(node);
        if (!isdefined(var_59476739)) {
            continue;
        }
        if (isdefined(var_8d594927)) {
            var_8d594927.origin = var_59476739.origin;
            is_touching = 0;
            foreach (ent in var_45e5ae09) {
                if (var_8d594927 istouching(ent)) {
                    is_touching = 1;
                    var_fa527c6d++;
                    break;
                }
            }
            if (!is_touching) {
                continue;
            }
        }
        function_1ede0cd3(node, var_59476739, 3);
    }
    println("<dev string:x2f1>" + var_fa527c6d);
    if (isdefined(var_8d594927)) {
        var_8d594927 delete();
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x1 linked
// Checksum 0x382069e4, Offset: 0x49c8
// Size: 0x1ce
function function_71578099() {
    nodes = getallnodes();
    foreach (node in nodes) {
        if (node.type != #"begin") {
            if (node.type === #"end" && getdvarint(#"hash_397bf855bf5ab4de", 1) && !isentity(node.var_597f08bf)) {
                function_dc0a8e61(node, 1);
            }
            continue;
        }
        if (isdefined(node.var_597f08bf)) {
            linktraversal(node);
            if (getdvarint(#"hash_397bf855bf5ab4de", 1) && !isentity(node.var_597f08bf)) {
                function_dc0a8e61(node, 1);
            }
            node.var_597f08bf.var_993e9bb0 = 1;
        }
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x1 linked
// Checksum 0xdb83fd68, Offset: 0x4ba0
// Size: 0x106
function function_9caf8627() {
    nodes = getallnodes();
    foreach (node in nodes) {
        if (node.type != #"begin" && node.type != #"end") {
            continue;
        }
        if (isdefined(node.var_597f08bf)) {
            function_dc0a8e61(node, 1);
            node.var_597f08bf.var_993e9bb0 = 1;
        }
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 3, eflags: 0x1 linked
// Checksum 0x9196c79c, Offset: 0x4cb0
// Size: 0x23c
function function_1ede0cd3(var_521b1043, var_59476739, var_be10591b) {
    if (!isdefined(var_521b1043)) {
        return;
    }
    var_e86e150a = undefined;
    if (ispathnode(var_521b1043)) {
        var_e86e150a = var_521b1043;
    } else {
        var_e86e150a = getnode(var_521b1043, "targetname");
    }
    if (!isdefined(var_e86e150a) || !isdefined(var_59476739)) {
        return;
    }
    var_76648d30 = array(var_e86e150a);
    var_c88f4455 = function_5a4a952a(var_e86e150a);
    if (isdefined(var_c88f4455)) {
        var_76648d30[var_76648d30.size] = var_c88f4455;
    }
    foreach (node in var_76648d30) {
        node.var_597f08bf = var_59476739;
        if (!isdefined(node.var_74785dff)) {
            node.var_74785dff = node.cost_modifier;
        }
        node.var_3e7103ff = isdefined(var_be10591b) ? var_be10591b : 4;
    }
    if (isdefined(var_59476739.var_993e9bb0)) {
        if (var_59476739.var_939413d0 === 1) {
            var_59476739 function_aa894590();
        }
        return;
    }
    var_59476739.var_993e9bb0 = 1;
    var_59476739.var_fa527c6d = var_76648d30;
    if (isentity(var_59476739)) {
        var_59476739 callback::on_death(&function_af978c79);
    }
    var_59476739 function_aa894590();
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0xec8c5028, Offset: 0x4ef8
// Size: 0x36
function function_af978c79(params) {
    if (!isdefined(self.var_fa527c6d)) {
        return;
    }
    function_a63a9610(params);
    self.var_fa527c6d = undefined;
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0x336d83d, Offset: 0x4f38
// Size: 0xb6
function function_a63a9610(*params) {
    if (!isdefined(self.var_fa527c6d)) {
        return;
    }
    self.var_939413d0 = undefined;
    foreach (node in self.var_fa527c6d) {
        if (!isdefined(node.var_74785dff)) {
            continue;
        }
        node.cost_modifier = node.var_74785dff;
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0x697f7f68, Offset: 0x4ff8
// Size: 0xca
function function_aa894590(*params) {
    if (!isdefined(self.var_fa527c6d)) {
        return;
    }
    self.var_939413d0 = 1;
    foreach (node in self.var_fa527c6d) {
        if (!isdefined(node) || !isdefined(node.var_3e7103ff)) {
            continue;
        }
        node.cost_modifier = node.var_3e7103ff;
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0x8dc5ffc5, Offset: 0x50d0
// Size: 0x46
function function_f4087909(blocker) {
    return isdefined(blocker.var_fa527c6d) && isdefined(blocker) && isdefined(blocker.var_939413d0) && blocker.var_939413d0 === 1;
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0x512891cd, Offset: 0x5120
// Size: 0x66
function function_142c3c86(entity) {
    if (is_true(entity.usingvehicle)) {
        vehicle = entity getvehicleoccupied();
        if (function_44a83b40(vehicle)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_85745671/event_9673dc9a
// Params 1, eflags: 0x40
// Checksum 0x28bd606c, Offset: 0x5190
// Size: 0x374
function event_handler[event_9673dc9a] function_3981d015(eventstruct) {
    if (isdefined(eventstruct.ent.target) && eventstruct.ent.target != "") {
        traversal_start_node = getnode(eventstruct.ent.target, "targetname");
        if (isdefined(traversal_start_node)) {
            var_c88f4455 = getothernodeinnegotiationpair(traversal_start_node);
            if (eventstruct.state == 0) {
                if ((isdefined(getgametypesetting(#"hash_2d40f1434ed94a2b")) ? getgametypesetting(#"hash_2d40f1434ed94a2b") : 0) && isdefined(traversal_start_node.var_597f08bf)) {
                    function_dc0a8e61(traversal_start_node, getdvarint(#"hash_397bf855bf5ab4de", 1));
                    if (isdefined(var_c88f4455)) {
                        function_dc0a8e61(var_c88f4455, getdvarint(#"hash_397bf855bf5ab4de", 1));
                    }
                    if (isdefined(traversal_start_node.ai_zone)) {
                        if (is_true(traversal_start_node.ai_zone.var_6411ebfb)) {
                            linktraversal(traversal_start_node);
                        } else {
                            unlinktraversal(traversal_start_node);
                        }
                    }
                    eventstruct.ent function_aa894590();
                } else {
                    unlinktraversal(traversal_start_node);
                }
                return;
            }
            if (isdefined(getgametypesetting(#"hash_2d40f1434ed94a2b")) ? getgametypesetting(#"hash_2d40f1434ed94a2b") : 0) {
                if (eventstruct.ent.health > 0) {
                    forward = anglestoforward(eventstruct.ent.angles);
                    if (eventstruct.state == 2) {
                        forward *= -1;
                    }
                    function_d9a69cf2(eventstruct.ent.origin, forward);
                }
                function_dc0a8e61(traversal_start_node, 1);
                if (isdefined(var_c88f4455)) {
                    function_dc0a8e61(var_c88f4455, 1);
                }
                eventstruct.ent function_a63a9610();
                linktraversal(traversal_start_node);
                return;
            }
            linktraversal(traversal_start_node);
        }
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 2, eflags: 0x1 linked
// Checksum 0xea63386a, Offset: 0x5510
// Size: 0x12e
function function_d9a69cf2(origin, forward) {
    var_8e1582ca = getentitiesinradius(origin, 50, 15);
    foreach (ent in var_8e1582ca) {
        if (!isdefined(forward) || vectordot(origin - ent.origin, forward) < 0) {
            var_43b3242 = 0;
            if (isdefined(ent.var_834b0770)) {
                var_43b3242 = 1;
            }
            ent zombie_utility::setup_zombie_knockdown(origin, var_43b3242);
            ent.knockdown_type = "knockdown_shoved";
        }
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0xb041ab37, Offset: 0x5648
// Size: 0x5a
function function_44a83b40(vehicle) {
    return isdefined(vehicle) && vehicle.scriptvehicletype !== "recon_wz" && vehicle.scriptvehicletype !== "dart_wz" && vehicle.scriptvehicletype !== "hawk";
}

// Namespace namespace_85745671/event_9e981c4
// Params 1, eflags: 0x44
// Checksum 0xe45eebd8, Offset: 0x56b0
// Size: 0x3c
function private event_handler[event_9e981c4] function_ff8b3908(eventstruct) {
    if (isdefined(eventstruct.ent.var_fa527c6d)) {
        eventstruct.ent function_af978c79();
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x1 linked
// Checksum 0x429b3696, Offset: 0x56f8
// Size: 0x1f0
function custom_melee_fire() {
    idflags = 0;
    if (isdefined(self.enemy) && is_true(self.enemy.armor)) {
        idflags |= 2048;
    }
    melee_dir = undefined;
    if (isdefined(self.attackable)) {
        melee_dir = anglestoforward(self.angles);
    }
    hitent = self melee(melee_dir, idflags);
    if (isdefined(hitent)) {
        if (self.attackable === hitent) {
            self function_924c0c6f(self.attackable);
        } else if (isvehicle(hitent)) {
            damage = self.var_a0193213;
            if (is_true(self.var_d8695234)) {
                damage = randomintrange(850, 1200);
            }
            self function_2713ff17(hitent, damage);
        }
    } else if (isdefined(self.var_b238ef38) && isdefined(self.attackable) && isdefined(self.var_b238ef38.position) && self isingoal(self.var_b238ef38.position)) {
        self function_924c0c6f(self.attackable);
    }
    return hitent;
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0xcf9524fd, Offset: 0x58f0
// Size: 0x16c
function function_924c0c6f(attackable) {
    var_8b4a973a = undefined;
    if (isdefined(attackable.startinghealth)) {
        var_8b4a973a = attackable.startinghealth;
    } else if (isdefined(attackable.maxhealth)) {
        var_8b4a973a = attackable.maxhealth;
    }
    if (isdefined(var_8b4a973a)) {
        if (is_true(self.var_d8695234)) {
            damage = int(var_8b4a973a / 2) + 1;
            attackable dodamage(damage, attackable.origin, self, self);
            return;
        }
        if (is_true(self.var_d003d23c)) {
            damage = int(145);
            attackable dodamage(damage, attackable.origin, self, self, "torso_upper");
            return;
        }
        damage = int(var_8b4a973a / 20) + 1;
        attackable dodamage(damage, attackable.origin, self, self);
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0x78c054d, Offset: 0x5a68
// Size: 0x13c
function function_68cc8bce(params) {
    owner = params.owner;
    turret = params.turret;
    owner endon(#"death");
    turret endon(#"death");
    wait 1;
    slots = function_bdb2b85b(turret, turret.origin, turret.angles, 30, 4, 300);
    if (!isdefined(slots) || slots.size <= 0) {
        return;
    }
    turret.var_b79a8ac7 = {#var_f019ea1a:500, #slots:slots};
    turret.var_ba721a2c = 20;
    if (!isdefined(level.attackables)) {
        level.attackables = [];
    }
    turret.is_active = 1;
    level.attackables[level.attackables.size] = turret;
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0x91961fdb, Offset: 0x5bb0
// Size: 0x4c
function on_turret_destroyed(params) {
    owner = params.owner;
    turret = params.turret;
    function_b70e2a37(turret);
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0x2e6d0538, Offset: 0x5c08
// Size: 0x17c
function function_cf065988(params) {
    owner = params.owner;
    cover = params.cover;
    owner endon(#"death");
    cover endon(#"death");
    slots = function_bdb2b85b(cover, owner.smartcover.lastvalid.origin, owner.smartcover.lastvalid.angles, owner.smartcover.lastvalid.width / 2 + 12, 6, level.smartcoversettings.bundle.var_b345c668);
    if (!isdefined(slots) || slots.size <= 0) {
        return;
    }
    cover.var_b79a8ac7 = {#slots:slots};
    cover.var_ba721a2c = 1;
    cover.var_d83d7db3 = 100;
    if (!isdefined(level.attackables)) {
        level.attackables = [];
    }
    level.attackables[level.attackables.size] = cover;
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0xc00369f, Offset: 0x5d90
// Size: 0x34
function function_b0503d98(params) {
    cover = params.cover;
    function_b70e2a37(cover);
}

// Namespace namespace_85745671/namespace_85745671
// Params 2, eflags: 0x1 linked
// Checksum 0x15987eff, Offset: 0x5dd0
// Size: 0x20c
function function_2713ff17(vehicle, damage_amount) {
    if (isdefined(vehicle)) {
        if (isdefined(damage_amount)) {
            vehicle dodamage(damage_amount, vehicle.origin);
        } else {
            /#
                iprintlnbold("<dev string:x304>" + (isdefined(self.archetype) ? self.archetype : "<dev string:x38>") + "<dev string:x314>");
            #/
        }
        org = vehicle.origin;
        nearby_players = getentitiesinradius(vehicle.origin, vehicle.radius, 1);
        foreach (player in nearby_players) {
            if (isdefined(vehicle getoccupantseat(player)) || player getgroundent() === vehicle || player getmoverent() === vehicle && player istouching(player getmoverent())) {
                player clientfield::increment_to_player("zombie_vehicle_shake", 1);
            }
        }
        playrumbleonposition("grenade_rumble", org);
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0x8e2577d, Offset: 0x5fe8
// Size: 0x564
function on_ai_damage(params) {
    if (isdefined(params.einflictor.scriptvehicletype) && isdefined(params.smeansofdeath) && isdefined(params.idamage)) {
        if (params.einflictor.classname === "script_vehicle" && params.smeansofdeath == "MOD_CRUSH") {
            var_80730518 = params.einflictor;
            switch (var_80730518.scriptvehicletype) {
            case #"player_motorcycle_2wd":
                n_damage = 200;
                n_slowdown = 0.05;
                break;
            case #"player_uaz":
                n_damage = 75;
                n_slowdown = 0.05;
                break;
            case #"hash_2212824fabcc986c":
                n_damage = 100;
                n_slowdown = 0.05;
                break;
            case #"player_fav_light":
                n_damage = 90;
                n_slowdown = 0.05;
                break;
            default:
                n_damage = 100;
                n_slowdown = 0.05;
                break;
            }
            if (isdefined(n_damage)) {
                if (isalive(self) && !isdefined(self.var_490b950e)) {
                    self.var_490b950e = 1;
                    v_forward = var_80730518.origin + vectornormalize(anglestoforward(var_80730518.angles)) * 110;
                    v_velocity = var_80730518 getvelocity();
                    v_launch = v_velocity * n_slowdown * -1;
                    v_hitloc = params.vpoint;
                    if (self.aitype === "spawner_bo5_mechz_sr" || self.aitype === #"hash_4f87aa2a203d37d0") {
                        v_launch = v_velocity * -1 * 0.8;
                        v_hitloc = var_80730518.origin;
                        n_damage = var_80730518.healthdefault * 0.5;
                    }
                    if (isdefined(var_80730518)) {
                        var_80730518 thread function_66c37f3b();
                        if (isdefined(v_forward) && !isdefined(var_80730518.b_launched)) {
                            var_80730518.b_launched = 1;
                            var_80730518 thread function_695f2040();
                            n_damage = int(n_damage);
                            var_80730518 launchvehicle(v_launch, v_hitloc, 0, 0);
                        }
                        if (params.idamage >= 40) {
                            if (params.idamage > 240) {
                                if (isdefined(self) && self.archetype === #"zombie") {
                                    if (math::cointoss(40) || isdefined(var_80730518.var_e955dfad)) {
                                        self thread zombie_utility::zombie_gut_explosion();
                                    } else {
                                        self thread zombie_utility::zombie_gib();
                                    }
                                }
                            } else if (params.idamage > 100) {
                                if (isdefined(self) && self.archetype === #"zombie") {
                                    if (math::cointoss(50)) {
                                        self thread zombie_utility::zombie_gib();
                                    }
                                }
                            }
                            if (isdefined(var_80730518.var_e955dfad)) {
                                var_80730518.var_e955dfad.health -= n_damage;
                                if (var_80730518.var_e955dfad.health < 1) {
                                    if (isdefined(params.vpoint) && isdefined(v_launch) && !isdefined(var_80730518.var_e955dfad.b_destroyed)) {
                                        var_80730518.var_e955dfad.b_destroyed = 1;
                                        var_80730518.var_e955dfad thread function_f741a120(params.vpoint, v_velocity);
                                    }
                                }
                                return;
                            }
                            var_80730518 dodamage(n_damage, var_80730518.origin, undefined, undefined, "", "MOD_IMPACT");
                        }
                    }
                }
            }
        }
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 2, eflags: 0x1 linked
// Checksum 0xb79d8bb5, Offset: 0x6558
// Size: 0x7c
function function_f741a120(v_org, v_velocity) {
    self unlink();
    wait 0.1;
    self physicslaunch(v_org, v_velocity * 6 + (0, 0, 20));
    wait 5;
    self delete();
}

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x1 linked
// Checksum 0x86e4f9b5, Offset: 0x65e0
// Size: 0x26
function function_695f2040() {
    self endon(#"death");
    waitframe(1);
    self.b_launched = undefined;
}

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x1 linked
// Checksum 0xdea3ac2b, Offset: 0x6610
// Size: 0x5c
function function_66c37f3b() {
    self endon(#"death");
    waitframe(1);
    self playrumbleonentity("sr_prototype_vehicle_run_over");
    self playsound(#"hash_7c72cea06ae4906c");
}

// Namespace namespace_85745671/namespace_85745671
// Params 5, eflags: 0x0
// Checksum 0x6c0d40d3, Offset: 0x6678
// Size: 0x132
function function_3cfa8bfe(str_model, v_offset, v_ang, n_forward, n_scale) {
    self setbrake(1);
    wait 0.5;
    v_forward = self.origin + vectornormalize(anglestoforward(self.angles)) * n_forward;
    var_6d29abb0 = util::spawn_model(str_model, v_forward + v_offset, v_ang);
    if (isdefined(var_6d29abb0)) {
        wait 0.1;
        var_6d29abb0.health = int(self.health * 0.4);
        var_6d29abb0 setscale(n_scale);
        var_6d29abb0 linkto(self);
        self.var_e955dfad = var_6d29abb0;
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0xa1872e5a, Offset: 0x67b8
// Size: 0xe4
function function_8f57dc52(dynent) {
    if (isdefined(dynent)) {
        dynentstate = function_ffdbe8c2(dynent);
        var_f3fec032 = function_489009c1(dynent);
        if (!dynent.destructible || !dynent.var_e76c7e9f || !isdefined(var_f3fec032) || !isdefined(var_f3fec032.destroyed) || dynentstate === var_f3fec032.destroyed || dynentstate === var_f3fec032.vehicledestroyed || is_true(dynent.var_993e9bb0)) {
            return false;
        }
        return true;
    }
    return false;
}

// Namespace namespace_85745671/namespace_85745671
// Params 3, eflags: 0x1 linked
// Checksum 0xcee6db45, Offset: 0x68a8
// Size: 0xea
function ee_head(entity, var_30ce4d1e = 1, forwardoffset) {
    if (!isactor(entity)) {
        return [];
    }
    if (!isdefined(forwardoffset)) {
        forwardoffset = anglestoforward(entity.angles) * entity getpathfindingradius();
    }
    return function_c3d68575(entity.origin + forwardoffset, (entity getpathfindingradius() * var_30ce4d1e, entity getpathfindingradius() * var_30ce4d1e, entity function_6a9ae71() * var_30ce4d1e));
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0xce1447c0, Offset: 0x69a0
// Size: 0x102
function function_b8eb5dea(*params) {
    var_d54999e4 = ee_head(self, 1.5);
    foreach (dynent in var_d54999e4) {
        if (function_8f57dc52(dynent)) {
            var_f3fec032 = function_489009c1(dynent);
            function_e2a06860(dynent, var_f3fec032.destroyed);
        }
    }
    self.var_4c85ebad = undefined;
}

// Namespace namespace_85745671/namespace_85745671
// Params 5, eflags: 0x1 linked
// Checksum 0xdceb9f8a, Offset: 0x6ab0
// Size: 0x174
function function_9d3ad056(var_7ecdee63, v_origin, v_angles, str_name, var_c427317f = 1) {
    n_percent = min(0.8, level.var_b48509f9 * 0.1 + 0.5);
    if (var_c427317f && getaiarray().size >= int(getailimit() * n_percent)) {
        function_904d21fd();
    }
    ai_spawned = spawnactor(var_7ecdee63, v_origin, v_angles, str_name, 1);
    if (isdefined(ai_spawned)) {
        if (ai_spawned.archetype === #"zombie") {
            ai_spawned.var_c9b11cb3 = #"hash_5d96e8e3ed203968";
        }
        if (isdefined(str_name) && !isinarray(level.var_d0c8ad06, str_name)) {
            ai_spawned.var_921627ad = 1;
        }
        return ai_spawned;
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x1 linked
// Checksum 0x2d74f199, Offset: 0x6c30
// Size: 0x324
function function_904d21fd() {
    var_808239f1 = getaiarchetypearray(#"zombie");
    max_dist = 0;
    var_202d087b = undefined;
    foreach (i, actor in var_808239f1) {
        if (is_true(actor.var_921627ad) || is_true(actor.var_a950813d) || is_true(actor.var_4df707f6)) {
            var_808239f1[i] = -1;
        }
    }
    arrayremovevalue(var_808239f1, -1);
    players = getplayers();
    foreach (player in players) {
        if (player.sessionstate === "spectator") {
            continue;
        }
        while (true) {
            var_3817a6b3 = arraygetfarthest(player.origin, var_808239f1);
            if (!isdefined(var_3817a6b3)) {
                return;
            }
            if (!player util::is_player_looking_at(var_3817a6b3 getcentroid(), undefined, 0)) {
                break;
            }
            arrayremovevalue(var_808239f1, var_3817a6b3);
            if (!var_808239f1.size) {
                return;
            }
            waitframe(1);
        }
        closest_player = arraygetclosest(var_3817a6b3.origin, players);
        dist = distancesquared(closest_player.origin, var_3817a6b3.origin);
        if (max_dist < dist) {
            max_dist = dist;
            var_202d087b = var_3817a6b3;
        }
    }
    if (!isdefined(var_202d087b)) {
        var_202d087b = array::random(var_808239f1);
    }
    if (isdefined(var_202d087b)) {
        var_202d087b callback::callback(#"hash_10ab46b52df7967a");
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 2, eflags: 0x0
// Checksum 0xc4ece7c3, Offset: 0x6f60
// Size: 0x196
function function_143a09ab(n_radius, v_loc) {
    level endon(#"hash_30fed423f5232678");
    self endon(#"death");
    if (!isdefined(v_loc)) {
        v_loc = self.origin;
    }
    a_ai_zombies = getaiarray();
    foreach (ai_zombie in a_ai_zombies) {
        if (isalive(ai_zombie) && !isdefined(ai_zombie.var_921627ad) && !isdefined(ai_zombie.var_4df707f6)) {
            if (distance2dsquared(v_loc, ai_zombie.origin) >= function_a3f6cdac(n_radius)) {
                ai_zombie callback::callback(#"hash_10ab46b52df7967a");
            } else {
                ai_zombie thread function_b7e28ade(v_loc, n_radius);
            }
        }
        waitframe(1);
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 2, eflags: 0x1 linked
// Checksum 0x5f168c0e, Offset: 0x7100
// Size: 0x184
function function_b7e28ade(v_loc, var_743fe0c8 = 2000) {
    self endon(#"death");
    self.b_visible = 0;
    foreach (player in getplayers()) {
        if (isdefined(var_743fe0c8) && isdefined(v_loc) && distance2dsquared(self.origin, v_loc) > function_a3f6cdac(var_743fe0c8) && player util::is_looking_at(self, 0.7, 1)) {
            self.b_visible = 1;
        }
        waitframe(1);
    }
    if (!self.b_visible && !isdefined(self.enemy) && !isdefined(self.var_b238ef38)) {
        self callback::callback(#"hash_10ab46b52df7967a");
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0xd39c1cb3, Offset: 0x7290
// Size: 0x20c
function function_5cb3181e(*params) {
    self endon(#"death");
    if (is_true(self.var_a950813d) || !isalive(self)) {
        return;
    }
    self.var_4df707f6 = 1;
    if (isdefined(self.attackable)) {
        function_2b925fa5(self);
    }
    despawn_anim = self.despawn_anim;
    if (!isdefined(despawn_anim) && isdefined(self.var_ecbef856)) {
        despawn_anim = self animmappingsearch(self.var_ecbef856);
    }
    if (isdefined(despawn_anim) && !self isragdoll()) {
        length = getanimlength(despawn_anim);
        self animscripted("despawn_anim", self.origin, self.angles, despawn_anim, "normal", undefined, 1, 0.2);
        self waittillmatchtimeout(length + 1, {#notetrack:"end"}, #"despawn_anim");
    }
    self util::stop_magic_bullet_shield();
    self ghost();
    self notsolid();
    waittillframeend();
    self.allowdeath = 1;
    self kill(undefined, undefined, undefined, undefined, 0, 1);
}

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x1 linked
// Checksum 0x4f3c4aba, Offset: 0x74a8
// Size: 0x72
function function_b67c088d() {
    enemy_override = undefined;
    if (self.archetype === #"zombie") {
        if (isdefined(level.zombielevelspecifictargetcallback)) {
            enemy_override = [[ level.zombielevelspecifictargetcallback ]]();
            return enemy_override;
        }
        enemy_override = self function_a9cfe717();
    }
    return enemy_override;
}

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x1 linked
// Checksum 0x775c5b95, Offset: 0x7528
// Size: 0x1c2
function function_a9cfe717() {
    var_158e7fe3 = undefined;
    var_2cbdcf68 = nightingale::function_29fbe24f(self);
    var_158e7fe3 = gadget_cymbal_monkey::function_4a5dff80(self);
    var_b26b6492 = gadget_homunculus::function_bd59a592(self);
    if (isdefined(var_b26b6492) && isdefined(var_2cbdcf68) && isdefined(var_158e7fe3)) {
        var_158e7fe3 = arraygetclosest(self.origin, array(var_158e7fe3, var_b26b6492, var_2cbdcf68));
    } else if (!isdefined(var_b26b6492) && isdefined(var_2cbdcf68) && isdefined(var_158e7fe3)) {
        var_158e7fe3 = arraygetclosest(self.origin, array(var_158e7fe3, var_2cbdcf68));
    } else if (isdefined(var_b26b6492) && !isdefined(var_2cbdcf68) && isdefined(var_158e7fe3)) {
        var_158e7fe3 = arraygetclosest(self.origin, array(var_158e7fe3, var_b26b6492));
    } else if (!isdefined(var_b26b6492) && isdefined(var_2cbdcf68) && !isdefined(var_158e7fe3)) {
        var_158e7fe3 = var_2cbdcf68;
    } else if (isdefined(var_b26b6492) && !isdefined(var_2cbdcf68) && !isdefined(var_158e7fe3)) {
        var_158e7fe3 = var_b26b6492;
    }
    return var_158e7fe3;
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0xed09b5bf, Offset: 0x76f8
// Size: 0xb4
function function_9456addc(var_fb09158c = 15) {
    if (isalive(self)) {
        a_players = array::get_all_closest(self.origin, laststand::function_7fb2bbfc());
        enemy = a_players[0];
        if (isalive(enemy)) {
            awareness::function_c241ef9a(self, enemy, var_fb09158c);
        }
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x1 linked
// Checksum 0xe5110204, Offset: 0x77b8
// Size: 0xc2
function function_744beb04(entity) {
    if (!isdefined(entity)) {
        return;
    }
    if (entity.team !== level.zombie_team || isdefined(entity.var_ff290a61) || isdefined(entity.enemy_override) || isdefined(entity.var_b238ef38) && !isdefined(entity.attackable)) {
        function_2b925fa5(entity);
        return;
    }
    if (!isdefined(entity.attackable)) {
        entity.attackable = get_attackable(entity, 1, entity.var_c11b8a5a);
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 6, eflags: 0x0
// Checksum 0x6860251b, Offset: 0x7888
// Size: 0x234
function function_caa890e2(origin, &spawn_points, var_79d43d2f, height, outer_radius, inner_radius) {
    var_31189d28 = isdefined(inner_radius) ? inner_radius : 0;
    queryresult = positionquery_source_navigation(origin, var_31189d28, outer_radius, height / 2, 20);
    var_c94c8429 = int(min(queryresult.data.size, var_79d43d2f));
    while (queryresult.data.size && spawn_points.size < var_c94c8429) {
        spawn_point = array::pop(queryresult.data, randomint(queryresult.data.size), 0);
        trace_start = (spawn_point.origin[0], spawn_point.origin[1], spawn_point.origin[2] + height);
        traceresult = physicstraceex(trace_start, spawn_point.origin, (-15, -15, 0), (15, 15, 72));
        var_d1a33279 = traceresult[#"position"];
        if (traceresult[#"fraction"] > 0 && abs(var_d1a33279[2] - spawn_point.origin[2]) < 32) {
            spawn_points[spawn_points.size] = var_d1a33279 - origin;
        }
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 4, eflags: 0x1 linked
// Checksum 0xfb036aa3, Offset: 0x7ac8
// Size: 0x242
function function_6b273d22(origin, var_1faf023a, outer_radius, inner_radius) {
    if (!isdefined(origin)) {
        return [];
    }
    var_4323e3c9 = (origin[0] + var_1faf023a[0], origin[1] + var_1faf023a[1], origin[2] + var_1faf023a[2]);
    var_acc2199d = (origin[0] + var_1faf023a[0], origin[1] + var_1faf023a[1], origin[2] - var_1faf023a[2]);
    traceresult = physicstraceex(var_4323e3c9, var_acc2199d, (-15, -15, 0), (15, 15, 72));
    var_d1a33279 = traceresult[#"position"];
    if (traceresult[#"fraction"] > 0 && isdefined(var_d1a33279)) {
        var_47efca42 = getclosestpointonnavmesh(var_d1a33279, 500, 32);
    }
    if (isdefined(var_47efca42) && abs(var_d1a33279[2] - var_47efca42[2]) < 32) {
        if (distance2dsquared(var_47efca42, origin) <= function_a3f6cdac(outer_radius) && (!isdefined(inner_radius) || distance2dsquared(var_47efca42, origin) >= function_a3f6cdac(inner_radius))) {
            var_a7a99675 = (var_47efca42[0], var_47efca42[1], max(var_d1a33279[2], var_47efca42[2]));
        }
    }
    return var_a7a99675;
}

// Namespace namespace_85745671/namespace_85745671
// Params 6, eflags: 0x1 linked
// Checksum 0x6c853cfe, Offset: 0x7d18
// Size: 0x26a
function function_5f4ef4d0(origin, angles, var_1faf023a, width, length, height) {
    var_4323e3c9 = (origin[0] + var_1faf023a[0], origin[1] + var_1faf023a[1], origin[2] + var_1faf023a[2]);
    var_acc2199d = (origin[0] + var_1faf023a[0], origin[1] + var_1faf023a[1], origin[2] - var_1faf023a[2]);
    traceresult = physicstraceex(var_4323e3c9, var_acc2199d, (-15, -15, 0), (15, 15, 72));
    var_d1a33279 = traceresult[#"position"];
    if (traceresult[#"fraction"] > 0 && isdefined(var_d1a33279)) {
        var_47efca42 = var_d1a33279;
    }
    if (isdefined(var_47efca42) && abs(var_d1a33279[2] - var_47efca42[2]) < 32) {
        rotated_offset = var_47efca42 - origin;
        var_1e98886a = function_72c0c267(rotated_offset, angles);
        mins = (-0.5 * width, -0.5 * length, -0.5 * height);
        maxs = mins * -1;
        if (function_fc3f770b(mins, maxs, var_1e98886a)) {
            var_a7a99675 = (var_47efca42[0], var_47efca42[1], max(var_d1a33279[2], var_47efca42[2]));
        }
    }
    return var_a7a99675;
}

// Namespace namespace_85745671/namespace_85745671
// Params 4, eflags: 0x1 linked
// Checksum 0x1956faa8, Offset: 0x7f90
// Size: 0x10a
function function_72c54d21(*origin, height, outer_radius, inner_radius) {
    theta = randomfloatrange(0, 360);
    var_9bdfd = 0.2;
    if (isdefined(inner_radius)) {
        var_9bdfd = inner_radius / outer_radius;
    }
    x = sin(theta) * outer_radius * randomfloatrange(var_9bdfd, 1);
    y = cos(theta) * outer_radius * randomfloatrange(var_9bdfd, 1);
    z = height;
    return (x, y, z);
}

// Namespace namespace_85745671/namespace_85745671
// Params 7, eflags: 0x1 linked
// Checksum 0xe14911e8, Offset: 0x80a8
// Size: 0xea
function function_4ed3741d(*origin, angles, height, outer_radius, inner_radius, min_angle = 0, max_angle = 180) {
    return rotatepoint((1, 0, height) * randomfloatrange(isdefined(inner_radius) ? inner_radius / outer_radius : 0, outer_radius), (0, (randomintrange(0, 2) ? -1 : 1) * randomfloatrange(min_angle, max_angle) + angles[1], 0));
}

// Namespace namespace_85745671/namespace_85745671
// Params 5, eflags: 0x1 linked
// Checksum 0x7951578e, Offset: 0x81a0
// Size: 0xf2
function function_81a53f3b(*origin, angles, width, length, height) {
    x = randomfloatrange(-0.5 * width, 0.5 * width);
    y = randomfloatrange(-0.5 * length, 0.5 * length);
    z = height;
    point = (x, y, z);
    point = rotatepoint(point, (0, angles[1], 0));
    return point;
}

// Namespace namespace_85745671/namespace_85745671
// Params 7, eflags: 0x1 linked
// Checksum 0xa397ce0d, Offset: 0x82a0
// Size: 0x1f6
function function_e4791424(origin, var_79d43d2f, height, outer_radius, inner_radius = 0, var_f0ee0fcd = 0, var_362d6269 = 1) {
    level endon(#"game_ended");
    if (!isdefined(origin)) {
        return [];
    }
    var_ec81389d = 0;
    spawn_points = [];
    for (i = 0; i < var_79d43d2f; i++) {
        var_8b63a38e = 0;
        var_a7a99675 = undefined;
        while (!isdefined(var_a7a99675) && var_8b63a38e < 5) {
            point = function_72c54d21(origin, height, outer_radius, inner_radius);
            var_a7a99675 = function_6b273d22(origin, point, outer_radius, inner_radius);
            if (isdefined(var_a7a99675)) {
                if (var_f0ee0fcd) {
                    spawn_points[spawn_points.size] = var_a7a99675 - origin;
                } else {
                    angles = origin - var_a7a99675;
                    spawn_points[spawn_points.size] = {#origin:var_a7a99675, #angles:(0, angles[1], 0)};
                }
            } else {
                var_8b63a38e++;
            }
            var_ec81389d++;
            if (var_362d6269 && var_ec81389d % 3 == 0) {
                waitframe(1);
            }
        }
    }
    return spawn_points;
}

// Namespace namespace_85745671/namespace_85745671
// Params 8, eflags: 0x1 linked
// Checksum 0xe0efc5ee, Offset: 0x84a0
// Size: 0x1e6
function function_7a1b21f6(origin, angles, var_79d43d2f, width, length, height, var_f0ee0fcd = 0, var_362d6269 = 1) {
    level endon(#"game_ended");
    var_ec81389d = 0;
    spawn_points = [];
    for (i = 0; i < var_79d43d2f; i++) {
        var_8b63a38e = 0;
        var_a7a99675 = undefined;
        while (!isdefined(var_a7a99675) && var_8b63a38e < 5) {
            point = function_81a53f3b(origin, angles, width, length, height);
            var_a7a99675 = function_5f4ef4d0(origin, angles, point, width, length, height);
            if (isdefined(var_a7a99675)) {
                if (var_f0ee0fcd) {
                    spawn_points[spawn_points.size] = var_a7a99675 - origin;
                } else {
                    var_6f386fda = origin - var_a7a99675;
                    spawn_points[spawn_points.size] = {#origin:var_a7a99675, #angles:(0, var_6f386fda[1], 0)};
                }
            } else {
                var_8b63a38e++;
            }
            var_ec81389d++;
            if (var_362d6269 && var_ec81389d % 3 == 0) {
                waitframe(1);
            }
        }
    }
    return spawn_points;
}

// Namespace namespace_85745671/namespace_85745671
// Params 5, eflags: 0x0
// Checksum 0xcfbcf01d, Offset: 0x8690
// Size: 0x122
function function_af5f7fc8(id, var_44f5a49b, origin, angles, targetname) {
    assert(isdefined(id) && isdefined(var_44f5a49b));
    if (!isdefined(level.var_754b2a4a)) {
        level.var_754b2a4a = [];
    }
    if (!isdefined(level.var_754b2a4a[id])) {
        level.var_754b2a4a[id] = namespace_679a22ba::function_77be8a83(var_44f5a49b);
    }
    spawn_info = namespace_679a22ba::function_ca209564(var_44f5a49b, level.var_754b2a4a[id]);
    if (!isdefined(spawn_info)) {
        return undefined;
    }
    var_944250d2 = spawnactor(spawn_info.var_990b33df, origin, angles, targetname, 1);
    if (isdefined(var_944250d2)) {
        var_944250d2.list_name = spawn_info.list_name;
    }
    return var_944250d2;
}

// Namespace namespace_85745671/namespace_85745671
// Params 1, eflags: 0x0
// Checksum 0x7e4dc5a4, Offset: 0x87c0
// Size: 0x38
function function_eb8e8b81(id) {
    if (!isdefined(level.var_754b2a4a)) {
        level.var_754b2a4a = [];
    }
    level.var_754b2a4a[id] = undefined;
}

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x1 linked
// Checksum 0x7141a554, Offset: 0x8800
// Size: 0x4c
function function_6c308e81() {
    if (is_true(level.is_survival)) {
        self thread function_625a781d();
        return;
    }
    self thread play_ambient_zombie_vocals();
}

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x1 linked
// Checksum 0x397b794b, Offset: 0x8858
// Size: 0x188
function play_ambient_zombie_vocals() {
    self endon(#"death");
    self thread function_b8c2c5cc();
    while (true) {
        type = "ambient";
        float = 3;
        if (isdefined(self.aistate)) {
            switch (self.aistate) {
            case 0:
            case 1:
            case 2:
            case 4:
                type = "ambient";
                float = 3;
                break;
            case 3:
                type = "sprint";
                float = 3;
                break;
            }
        }
        if (is_true(self.missinglegs)) {
            float = 2;
            type = "crawler";
        }
        bhtnactionstartevent(self, type);
        self notify(#"bhtn_action_notify", {#action:type});
        wait randomfloatrange(1, float);
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x1 linked
// Checksum 0x3ef0abd6, Offset: 0x89e8
// Size: 0x1b0
function function_625a781d() {
    self endon(#"death");
    self thread function_c2be61f2();
    while (true) {
        type = "ambient";
        float = 3;
        if (isdefined(self.current_state)) {
            switch (self.current_state.name) {
            case #"investigate":
            case #"wander":
                type = "ambient";
                float = 3;
                break;
            case #"chase":
                type = "sprint";
                float = 3;
                break;
            }
        }
        if (is_true(self.missinglegs)) {
            float = 2;
            type = "crawler";
        }
        bhtnactionstartevent(self, type);
        self notify(#"bhtn_action_notify", {#action:type});
        wait 0.1;
        while (is_true(self.talking)) {
            wait 0.1;
        }
        wait randomfloatrange(0.25, 1.5);
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x1 linked
// Checksum 0xa8bc03c9, Offset: 0x8ba0
// Size: 0x78
function function_b8c2c5cc() {
    self endon(#"death", #"disconnect");
    while (true) {
        self waittill(#"reset_pathing");
        if (self.aistate == 3) {
            bhtnactionstartevent(self, "chase_state_start");
        }
    }
}

// Namespace namespace_85745671/namespace_85745671
// Params 0, eflags: 0x1 linked
// Checksum 0x6279c718, Offset: 0x8c20
// Size: 0x98
function function_c2be61f2() {
    self endon(#"death", #"disconnect");
    while (true) {
        self waittill(#"state_changed");
        waitframe(1);
        if (isdefined(self.current_state) && self.current_state.name == #"chase") {
            bhtnactionstartevent(self, "chase_state_start");
        }
    }
}

