#using script_196ac4df8101fb82;
#using script_219d0307e97d9219;
#using script_335d0650ed05d36d;
#using script_3819e7a1427df6d2;
#using script_3e196d275a6fb180;
#using script_536d1d6b28995087;
#using script_556e19065f09f8a2;
#using script_7d00e836ba35c990;
#using script_be0dc8f3d715242;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\powerup\zm_powerup_nuke;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_sq;

#namespace namespace_51f64aa9;

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x17671cbc, Offset: 0x5c0
// Size: 0x57c
function function_2ce126c4() {
    death_circle::function_c156630d();
    level.var_50c8366e = 0;
    level.var_bc2071f = 0;
    level flag::init("rounds_started");
    level flag::init("onslaught_round_logic_inprogress");
    level flag::init("onslaught_round_logic_complete");
    callback::on_spawned(&function_e8535657);
    callback::on_connect(&function_8b930ad1);
    callback::on_start_gametype(&function_6071bedf);
    callback::on_game_playing(&function_bfd2a58b);
    level.graceperiod = 0;
    level.var_b82a5c35 = 1;
    level.var_3d1e480e = 1;
    level.var_3a701785 = 1;
    level.var_d25999d7 = getdvarint(#"hash_5bc5d75f3e9a5aae", 0);
    level.var_4614c421 = &function_a3e209ba;
    level.var_3566a062 = 1;
    level.var_2b37d0dd = 0;
    level.var_e5a890d7 = 0;
    level.var_bc79322a = 0;
    level.var_58c95941 = 0;
    level.var_9dfa1a1e = 1;
    spawner::add_archetype_spawn_function(#"zombie", &zombiespawnsetup);
    spawner::function_89a2cd87(#"zombie", &function_a9b7dc57);
    level.mp_gamemode_onslaught_bossalert_msg = mp_gamemode_onslaught_bossalert_msg::register();
    level.var_40bf73ee = namespace_40bf73ee::register();
    level.var_a9c3c455 = namespace_a9c3c455::register();
    level.mp_gamemode_onslaught_score_msg = mp_gamemode_onslaught_score_msg::register();
    level.var_cb513044 = namespace_cb513044::register();
    level.var_d4c0ef1a = getentarray("koth_zone_center", "targetname");
    foreach (zone in level.var_d4c0ef1a) {
        zone.usecount = 0;
        othervisuals = getentarray(zone.target, "targetname");
        for (j = 0; j < othervisuals.size; j++) {
            if (othervisuals[j].classname == "script_brushmodel") {
                othervisuals[j] notsolid();
                othervisuals[j] hide();
            }
        }
    }
    level._effect[#"hash_f122d8967f599a"] = "zm_ai/fx8_avo_elec_teleport_flash";
    level._effect[#"hash_70915e6d17793425"] = "zm_ai/fx8_dog_lightning_spawn";
    level._effect[#"hash_7a06e7dd7e64b880"] = "zm_ai/fx8_avo_elec_teleport_appear";
    level._effect[#"hash_5fa0154f4b01ba02"] = "zombie/fx9_powerup_nuke";
    /#
        if (getdvarint(#"hash_61dfb5be7263ab36", 0) == 1) {
            level.var_2b37d0dd = 1;
            level.var_e5a890d7 = 0;
            level.var_bc79322a = 0;
            level.var_bc0b4b46 = 1;
        }
        if (getdvarint(#"hash_61dfb5be7263ab36", 0) == 2) {
            level.var_e5a890d7 = 1;
            level.var_9725eb4a = 1;
        }
        if (getdvarint(#"hash_61dfb5be7263ab36", 0) == 3) {
            level.var_e5a890d7 = 1;
            level.var_58c95941 = 1;
        }
    #/
    level thread function_c1d511f6();
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xb96188a8, Offset: 0xb48
// Size: 0xc8
function function_c1d511f6() {
    level endon(#"end_game");
    level flag::wait_till("rounds_started");
    wait 2;
    while (true) {
        waitresult = level waittill(#"hash_5731a6df491c37c7");
        var_c2f7b1a3 = waitresult.location;
        zm_sq::objective_set(#"hash_641e9c4d20df5950", var_c2f7b1a3, undefined, #"hash_2ecde6d705d1052b");
        level waittill(#"hash_1b8264e950c01344");
    }
}

/#

    // Namespace namespace_51f64aa9/namespace_51f64aa9
    // Params 0, eflags: 0x0
    // Checksum 0xa651f974, Offset: 0xc18
    // Size: 0x2ca
    function debug_spawns() {
        var_da0b6672 = 50;
        checkdist = 1000;
        while (true) {
            player1 = getplayers()[0];
            var_273a84a9 = [];
            if (!isdefined(var_273a84a9)) {
                var_273a84a9 = [];
            } else if (!isarray(var_273a84a9)) {
                var_273a84a9 = array(var_273a84a9);
            }
            var_273a84a9[var_273a84a9.size] = "<dev string:x38>";
            if (!isdefined(var_273a84a9)) {
                var_273a84a9 = [];
            } else if (!isarray(var_273a84a9)) {
                var_273a84a9 = array(var_273a84a9);
            }
            var_273a84a9[var_273a84a9.size] = "<dev string:x3f>";
            var_8fb1964e = spawning::function_d400d613(#"mp_spawn_point", var_273a84a9);
            spawns = var_8fb1964e[#"tdm"];
            if (!isdefined(spawns)) {
                spawns = var_8fb1964e[#"ctf"];
            }
            foreach (spawnpt in spawns) {
                var_b3dbfd56 = spawnpt.origin;
                circle(var_b3dbfd56, var_da0b6672, (1, 0, 0), 1, 1, 1);
                if (is_true(spawnpt.used)) {
                    drawcross(var_b3dbfd56 + (0, 0, 10), (1, 0, 0), 1);
                    drawcross(var_b3dbfd56 + (0, 0, 40), (1, 0, 0), 1);
                    drawcross(var_b3dbfd56 + (0, 0, 80), (1, 0, 0), 1);
                }
            }
            waitframe(1);
        }
    }

#/

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xa201e14, Offset: 0xef0
// Size: 0xc2
function function_ec2b3302() {
    if (is_true(level.var_3566a062)) {
        var_8314a02e = 0;
        if (level.var_9b7bd0e8 > 0 || level.var_50c8366e > 5) {
            var_8314a02e = 20;
        } else {
            return #"hash_5f22ecce894282fa";
        }
        rand = randomint(100);
        if (rand <= var_8314a02e) {
            return #"hash_12a17ab3df5889eb";
        } else {
            return #"hash_5f22ecce894282fa";
        }
    }
    return #"hash_5f22ecce894282fa";
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x4bf47e81, Offset: 0xfc0
// Size: 0x3a
function function_2f6706d2() {
    if (is_true(level.var_3566a062)) {
        return #"spawner_zm_steiner";
    }
    return #"hash_4e14acd183d6d3eb";
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xd8e15d26, Offset: 0x1008
// Size: 0x24
function swampslashersounds() {
    level.var_40bf73ee namespace_40bf73ee::open(self, 1);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x262ae7b9, Offset: 0x1038
// Size: 0x2e
function function_1bb93418() {
    level.var_40bf73ee namespace_40bf73ee::close(self);
    self.var_c5598268 = undefined;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xf6024427, Offset: 0x1070
// Size: 0x22
function function_a7540094() {
    return level.var_40bf73ee namespace_40bf73ee::is_open(self);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0x6284f75, Offset: 0x10a0
// Size: 0x2c
function function_d09d6958(value) {
    level.var_40bf73ee namespace_40bf73ee::set_objectivetext(self, value);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 2, eflags: 0x0
// Checksum 0xdbe20440, Offset: 0x10d8
// Size: 0x8c
function function_61c3d59c(str_text, var_a920f1d6) {
    if (level.var_40bf73ee namespace_40bf73ee::is_open(self) == 0) {
        self swampslashersounds();
    }
    self function_d09d6958(str_text);
    self.var_c5598268 = str_text;
    wait var_a920f1d6;
    self function_1bb93418();
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xb8017340, Offset: 0x1170
// Size: 0x24
function function_5b184b61() {
    level.mp_gamemode_onslaught_bossalert_msg mp_gamemode_onslaught_bossalert_msg::open(self, 1);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x347f08ae, Offset: 0x11a0
// Size: 0x2e
function function_b4b2715d() {
    level.mp_gamemode_onslaught_bossalert_msg mp_gamemode_onslaught_bossalert_msg::close(self);
    self.var_e87137f6 = undefined;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x66d93f7f, Offset: 0x11d8
// Size: 0x22
function function_9e88b6b7() {
    return level.mp_gamemode_onslaught_bossalert_msg mp_gamemode_onslaught_bossalert_msg::is_open(self);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0x92adc5d5, Offset: 0x1208
// Size: 0x2c
function function_22d0bd07(value) {
    level.mp_gamemode_onslaught_bossalert_msg mp_gamemode_onslaught_bossalert_msg::function_b73d2d7c(self, value);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 2, eflags: 0x0
// Checksum 0xd728122d, Offset: 0x1240
// Size: 0x8c
function function_f9b8bf44(str_text, var_a920f1d6) {
    if (level.mp_gamemode_onslaught_bossalert_msg mp_gamemode_onslaught_bossalert_msg::is_open(self) == 0) {
        self function_5b184b61();
    }
    self function_22d0bd07(str_text);
    self.var_e87137f6 = str_text;
    wait var_a920f1d6;
    self function_b4b2715d();
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x4d2f03bb, Offset: 0x12d8
// Size: 0x24
function function_55a48e7c() {
    level.var_a9c3c455 namespace_a9c3c455::open(self, 1);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xa9057073, Offset: 0x1308
// Size: 0x2e
function function_a77694e() {
    level.var_a9c3c455 namespace_a9c3c455::close(self);
    self.var_c8adf4e2 = undefined;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x402c8dfd, Offset: 0x1340
// Size: 0x22
function function_591bda97() {
    return level.var_a9c3c455 namespace_a9c3c455::is_open(self);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0x2f551d62, Offset: 0x1370
// Size: 0x2c
function function_f0e74135(value) {
    level.var_a9c3c455 namespace_a9c3c455::function_9c1c0811(self, value);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 2, eflags: 0x0
// Checksum 0xc3fec0ad, Offset: 0x13a8
// Size: 0x8c
function function_4b12e9e4(str_text, var_a920f1d6) {
    if (level.var_a9c3c455 namespace_a9c3c455::is_open(self) == 0) {
        self function_55a48e7c();
    }
    self function_f0e74135(str_text);
    self.var_c8adf4e2 = str_text;
    wait var_a920f1d6;
    self function_a77694e();
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xad0f0b05, Offset: 0x1440
// Size: 0x24
function function_a094baea() {
    level.mp_gamemode_onslaught_score_msg mp_gamemode_onslaught_score_msg::open(self, 1);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xeb144c15, Offset: 0x1470
// Size: 0x36
function function_2617d862() {
    level.mp_gamemode_onslaught_score_msg mp_gamemode_onslaught_score_msg::close(self);
    self.var_ce3d2dd4 = undefined;
    self.var_6344c21a = undefined;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x4c5ac50e, Offset: 0x14b0
// Size: 0x22
function function_c2344cef() {
    return level.mp_gamemode_onslaught_score_msg mp_gamemode_onslaught_score_msg::is_open(self);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0x25ac1dec, Offset: 0x14e0
// Size: 0x2c
function function_dd5ae397(value) {
    level.mp_gamemode_onslaught_score_msg mp_gamemode_onslaught_score_msg::function_4b560c24(self, value);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0xd49cbf20, Offset: 0x1518
// Size: 0x2c
function function_961ff123(value) {
    level.mp_gamemode_onslaught_score_msg mp_gamemode_onslaught_score_msg::function_fc075317(self, value);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0x4d7c4af4, Offset: 0x1550
// Size: 0x2c
function function_813aaa72(value) {
    level.mp_gamemode_onslaught_score_msg mp_gamemode_onslaught_score_msg::function_2a0b1f84(self, value);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x680d1262, Offset: 0x1588
// Size: 0xcc
function function_da556d60() {
    if (level.mp_gamemode_onslaught_score_msg mp_gamemode_onslaught_score_msg::is_open(self) == 0) {
        self function_a094baea();
    }
    self function_dd5ae397(#"hash_7606f925c1043de7");
    self.var_ce3d2dd4 = #"hash_7606f925c1043de7";
    self function_961ff123(#"hash_3ed49baf7733f7f");
    self.var_6344c21a = #"hash_3ed49baf7733f7f";
    self function_813aaa72(level.var_2c4a44aa);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xff61fb08, Offset: 0x1660
// Size: 0x24
function function_90a36be1() {
    level.var_cb513044 namespace_cb513044::open(self, 1);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x63165dbd, Offset: 0x1690
// Size: 0x36
function function_251073e9() {
    level.var_cb513044 namespace_cb513044::close(self);
    self.var_1aab885a = undefined;
    self.var_d0987305 = undefined;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xf618871f, Offset: 0x16d0
// Size: 0x22
function function_4fe0ea51() {
    return level.var_cb513044 namespace_cb513044::is_open(self);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0xf0204f6c, Offset: 0x1700
// Size: 0x2c
function function_8557ce1d(value) {
    level.var_cb513044 namespace_cb513044::function_4b560c24(self, value);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0x347e4961, Offset: 0x1738
// Size: 0x2c
function function_c04f382c(value) {
    level.var_cb513044 namespace_cb513044::function_fc075317(self, value);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xfeb3da15, Offset: 0x1770
// Size: 0xaa
function function_cf4e42ea() {
    if (level.var_cb513044 namespace_cb513044::is_open(self) == 0) {
        self function_90a36be1();
    }
    self function_8557ce1d(#"hash_53f5869338825e6b");
    self.var_1aab885a = #"hash_53f5869338825e6b";
    self function_c04f382c(#"hash_7db28efbde35ec48");
    self.var_d0987305 = #"hash_7db28efbde35ec48";
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x4
// Checksum 0x3f2d803f, Offset: 0x1828
// Size: 0x2e
function private function_a3e209ba() {
    if (level flag::get("rounds_started")) {
        return true;
    }
    return false;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x62ff9c3d, Offset: 0x1860
// Size: 0x1c
function function_6071bedf() {
    level thread function_69e5b9b();
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xf44da10b, Offset: 0x1888
// Size: 0x184
function function_bfd2a58b() {
    level waittill(#"initial_fade_in_complete");
    while (getplayers().size < 0) {
        wait 1;
    }
    music::setmusicstate("onslaught_main");
    wait 1;
    /#
        if (is_true(level.var_bc0b4b46)) {
            level thread debug_spawns();
        }
    #/
    level thread function_81c192d();
    players = getplayers();
    foreach (player in players) {
        player thread function_61c3d59c(#"hash_974629be3cf5e84", 12);
    }
    wait 2;
    level flag::set("rounds_started");
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1a18
// Size: 0x4
function function_8b930ad1() {
    
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x6d305890, Offset: 0x1a28
// Size: 0x3c
function function_e8535657() {
    self endon(#"disconnect");
    self setclientuivisibilityflag("g_compassShowEnemies", 1);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0xed28c680, Offset: 0x1a70
// Size: 0x4c
function function_b0eba88e(player) {
    self endon(#"death");
    player waittill(#"disconnect");
    self delete();
}

/#

    // Namespace namespace_51f64aa9/namespace_51f64aa9
    // Params 3, eflags: 0x0
    // Checksum 0xd73f15b9, Offset: 0x1ac8
    // Size: 0xec
    function drawcross(origin, color, duration) {
        r = 6;
        forward = (r, 0, 0);
        left = (0, r, 0);
        up = (0, 0, r);
        line(origin - forward, origin + forward, color, 1, 0, duration);
        line(origin - left, origin + left, color, 1, 0, duration);
        line(origin - up, origin + up, color, 1, 0, duration);
    }

#/

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0x1b564702, Offset: 0x1bc0
// Size: 0x146
function function_fcbdc8f4(duration) {
    milliseconds = int(duration % 1000) / 10;
    seconds = int(duration / 1000) % 60;
    minutes = int(duration / 60000) % 60;
    hours = int(duration / 3600000) % 24;
    if (hours < 10) {
        hours = "0" + hours;
    }
    if (minutes < 10) {
        minutes = "0" + minutes;
    }
    if (seconds < 10) {
        seconds = "0" + seconds;
    }
    if (milliseconds < 10) {
        milliseconds = "0" + milliseconds;
    }
    return minutes + ":" + seconds + ":" + milliseconds;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0x14d05918, Offset: 0x1d10
// Size: 0x26
function function_b5c27e32(*var_3b720eb2) {
    if (isdefined(self)) {
        self notify(#"risen");
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x26fa9cb6, Offset: 0x1d40
// Size: 0x24
function function_a9b7dc57() {
    self pathmode("move allowed");
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x1252bdca, Offset: 0x1d70
// Size: 0x1f2
function zombiespawnsetup() {
    self.overrideactordamage = &aidamage;
    self clientfield::set("enemy_on_radar", 1);
    self.custom_location = &function_b5c27e32;
    self zm_behavior::function_57d3b5eb();
    self.script_string = "find_flesh";
    self notify(#"risen", "find_flesh");
    self zm_spawner::zombie_complete_emerging_into_playable_area();
    rand = randomint(100);
    if (rand <= 35) {
        zombie_utility::set_zombie_run_cycle("walk");
    } else if (rand <= 70) {
        zombie_utility::set_zombie_run_cycle("run");
    } else if (level.var_50c8366e < 3) {
        zombie_utility::set_zombie_run_cycle("run");
    } else {
        zombie_utility::set_zombie_run_cycle("sprint");
    }
    self.zombie_think_done = 1;
    self.b_ignore_cleanup = 0;
    self.var_8d1d18aa = 0;
    self.var_2e948547 = 0;
    self clientfield::set("enemy_on_radar", 1);
    self.health = 100 + (level.var_50c8366e - 1) * 50 * getplayers().size;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xf4bd9b00, Offset: 0x1f70
// Size: 0x214
function function_6c40ff50() {
    aiutility::addaioverridedamagecallback(self, &aidamage);
    self.health = (3000 + level.var_9b7bd0e8 * 500) * getplayers().size;
    self.goalradius = 1024;
    self.zombie_think_done = 1;
    self.completed_emerging_into_playable_area = 1;
    self.b_ignore_cleanup = 1;
    self pathmode("move allowed");
    self.var_2e948547 = 1;
    self clientfield::set("enemy_on_radar", 1);
    self.var_8d1d18aa = 1;
    all_ai = getaiarray();
    foreach (ai in all_ai) {
        foreach (var_e0b78f9f in all_ai) {
            if (var_e0b78f9f != ai) {
                var_e0b78f9f setignoreent(ai, 1);
                ai setignoreent(var_e0b78f9f, 1);
            }
        }
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 12, eflags: 0x0
// Checksum 0xfb225823, Offset: 0x2190
// Size: 0xfc
function aidamage(inflictor, *attacker, damage, *dflags, *mod, *weapon, *point, *dir, *hitloc, *offsettime, *boneindex, *modelindex) {
    if (isdefined(boneindex) && isactor(boneindex) && boneindex.archetype == #"zombie") {
        return 0;
    }
    if (is_true(self.var_2e948547) && is_true(self.var_8d1d18aa)) {
        if (self.health - modelindex < 1) {
            return 0;
        }
    }
    return modelindex;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x9e0f4a58, Offset: 0x2298
// Size: 0x6e
function hide_pop() {
    self endon(#"death");
    self ghost();
    wait 0.5;
    if (isdefined(self)) {
        self show();
        waitframe(1);
        if (isdefined(self)) {
            self.create_eyes = 1;
        }
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 3, eflags: 0x0
// Checksum 0x595282fc, Offset: 0x2310
// Size: 0x2da
function function_1495c8c(v_origin, v_angles, anim_name) {
    self endon(#"death");
    origin = self gettagorigin("j_spine4");
    playfx(level._effect[#"hash_f122d8967f599a"], origin);
    if (is_true(level.var_3566a062)) {
        self.in_the_ground = 1;
        if (isdefined(self.anchor)) {
            self.anchor delete();
        }
        self.anchor = spawn("script_origin", self.origin);
        self.anchor.angles = self.angles;
        self linkto(self.anchor);
        if (!isdefined(v_angles)) {
            v_angles = (0, 0, 0);
        }
        anim_org = v_origin;
        anim_ang = v_angles;
        anim_org += (0, 0, 0);
        self ghost();
        self.anchor moveto(anim_org, 0.05);
        self.anchor waittill(#"movedone");
        self unlink();
        if (isdefined(self.anchor)) {
            self.anchor delete();
        }
        self thread hide_pop();
        self orientmode("face default");
        self animscripted("rise_anim", self.origin, v_angles, anim_name, "normal");
    }
    if (self.health > 0) {
        playfx(level._effect[#"hash_7a06e7dd7e64b880"], origin);
        playrumbleonposition("zm_nova_phase_exit_rumble", self.origin);
    }
    self notify(#"rise_anim_finished");
    self.in_the_ground = 0;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x253b3ff0, Offset: 0x25f8
// Size: 0x154
function function_3fd720cc() {
    self endon(#"death");
    origin = self.origin;
    self val::set(#"boss_spawn", "takedamage", 0);
    self val::set(#"boss_spawn", "ignoreall", 1);
    for (var_760da554 = 14; var_760da554 > 0; var_760da554 -= 1) {
        playfx(level._effect[#"hash_70915e6d17793425"], origin);
        playrumbleonposition("zm_nova_phase_exit_rumble", origin);
        wait 0.5;
    }
    self val::set(#"boss_spawn", "takedamage", 1);
    self val::set(#"boss_spawn", "ignoreall", 0);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 3, eflags: 0x0
// Checksum 0x8b097df4, Offset: 0x2758
// Size: 0xd2
function function_b5ba566b(*v_origin, *v_angles, *anim_name) {
    self endon(#"death");
    if (self.health > 0) {
        origin = self gettagorigin("j_spine4");
        playfx(level._effect[#"hash_7a06e7dd7e64b880"], origin);
        playrumbleonposition("zm_nova_phase_exit_rumble", self.origin);
    }
    self notify(#"rise_anim_finished");
    self.in_the_ground = 0;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xea93c563, Offset: 0x2838
// Size: 0xba
function function_6fcd98c5() {
    all_ai = getaiarray();
    foreach (ai in all_ai) {
        if (!is_true(ai.var_1cc135b3)) {
            ai.zombie_move_speed = "sprint";
        }
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xa415d08c, Offset: 0x2900
// Size: 0xd8
function function_73297fa() {
    all_ai = getaiarray();
    foreach (ai in all_ai) {
        if (isai(ai) && isalive(ai)) {
            ai kill();
        }
        wait 0.1;
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x4c737a16, Offset: 0x29e0
// Size: 0x170
function function_46ff5efa() {
    playfx(level._effect[#"hash_5fa0154f4b01ba02"], level.var_df7b46d1.origin);
    lui::screen_flash(0.2, 0.5, 1, 0.8, "white", undefined, 1);
    all_ai = getaiarray();
    foreach (ai in all_ai) {
        if (isai(ai) && isalive(ai) && !is_true(ai.var_2e948547)) {
            ai kill();
        }
        wait 0.1;
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x8835306b, Offset: 0x2b58
// Size: 0x1bc
function function_d6ad49c2() {
    waitresult = self waittill(#"death");
    attacker = waitresult.attacker;
    if (!isplayer(attacker)) {
        return;
    }
    level.var_d1876457 = self.origin;
    if (self.type == #"hash_12a17ab3df5889eb") {
        level.var_bc2071f = min(100, level.var_bc2071f + 20);
    } else {
        level.var_bc2071f = min(100, level.var_bc2071f + level.var_3a23a27);
    }
    level.var_1fd7c9b7 = gettime();
    players = getplayers();
    foreach (player in players) {
        level.mp_gamemode_onslaught_score_msg mp_gamemode_onslaught_score_msg::function_94b2b0bd(player);
    }
    self clientfield::set("orb_soul_capture_fx", 1);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x149a4e55, Offset: 0x2d20
// Size: 0x7a
function function_1e521615() {
    if (!isdefined(self.var_9fde8624)) {
        return 0;
    }
    var_6f8997fc = array(#"hash_5605f3a585b3ef9f", #"hash_3498fb1fbfcd0cf", #"hash_12fa854f3a7721b9");
    return isinarray(var_6f8997fc, self.var_9fde8624);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x400d14af, Offset: 0x2da8
// Size: 0x294
function function_c08eb1c4() {
    level endon(#"hash_1b8264e950c01344");
    self endon(#"death");
    if (!is_true(self.var_8d1d18aa)) {
        return;
    }
    waitresult = self waittill(#"spawned_split_ai");
    var_9f7c58e6 = #"spawner_zm_steiner_split_radiation_blast";
    var_a0024591 = #"spawner_zm_steiner_split_radiation_bomb";
    if (self function_1e521615()) {
        var_9f7c58e6 = #"hash_7f957e36b4f6160f";
        var_a0024591 = #"hash_6904f5c7bef64405";
    }
    all_ai = getaiarray();
    foreach (ai in all_ai) {
        if (ai.aitype == var_9f7c58e6) {
            level.blast_ai = ai;
            level.blast_ai.var_2e948547 = 1;
            level.blast_ai.b_ignore_cleanup = 1;
            level.blast_ai clientfield::set("enemy_on_radar", 1);
            continue;
        }
        if (ai.aitype == var_a0024591) {
            level.var_4bbd72b6 = ai;
            level.var_4bbd72b6.var_2e948547 = 1;
            level.var_4bbd72b6.b_ignore_cleanup = 1;
            level.var_4bbd72b6 clientfield::set("enemy_on_radar", 1);
        }
    }
    level.var_4bbd72b6 thread function_b33a5cf4(level.blast_ai);
    level.blast_ai thread function_b33a5cf4(level.var_4bbd72b6);
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0xef898807, Offset: 0x3048
// Size: 0x1c0
function function_b33a5cf4(var_ba65b6cb) {
    level endon(#"hash_1b8264e950c01344");
    waitresult = self waittill(#"death");
    attacker = waitresult.attacker;
    if (isdefined(var_ba65b6cb) && isalive(var_ba65b6cb)) {
        self thread zm_powerups::specific_powerup_drop("full_ammo", self.origin);
        return;
    }
    level.var_1c376a62 = self.origin;
    if (!isplayer(attacker)) {
        return;
    }
    self thread zm_powerups::specific_powerup_drop("free_perk", self.origin);
    level.var_9b7bd0e8++;
    players = getplayers();
    foreach (player in players) {
        player clientfield::set_player_uimodel("hudItems.onslaught.bosskill_count", level.var_9b7bd0e8);
    }
    level notify(#"hash_1b8264e950c01344");
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xc4e82690, Offset: 0x3210
// Size: 0x1b0
function function_a371376() {
    waitresult = self waittill(#"death");
    attacker = waitresult.attacker;
    if (is_true(self.var_8d1d18aa)) {
        self thread zm_powerups::specific_powerup_drop("full_ammo", self.origin);
        return;
    }
    level notify(#"hash_1b8264e950c01344");
    level.var_1c376a62 = self.origin;
    if (!isplayer(attacker)) {
        return;
    }
    self thread zm_powerups::specific_powerup_drop("free_perk", self.origin);
    level.var_bc2071f = 100;
    level.var_9b7bd0e8++;
    players = getplayers();
    foreach (player in players) {
        player clientfield::set_player_uimodel("hudItems.onslaught.bosskill_count", level.var_9b7bd0e8);
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x1fd3cc1b, Offset: 0x33c8
// Size: 0x24
function function_8f93a196() {
    level.var_a1cb219c = 25;
    level.var_2c4a44aa = 10;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0xa75ac37e, Offset: 0x33f8
// Size: 0x1c8
function function_c50adb68(var_50c8366e) {
    level.var_50c8366e = var_50c8366e;
    if (var_50c8366e == 1) {
        level.var_3a23a27 = 10 / getplayers().size;
        level.var_6693a0b6 = 4 * getplayers().size;
    } else {
        level.var_3a23a27 = max(level.var_3a23a27 - 1, 1);
        level.var_6693a0b6 = min(24, level.var_6693a0b6 + 2 * getplayers().size);
    }
    level.var_56e32823 = 0;
    level.run_timer = 0;
    level flag::clear("onslaught_round_logic_complete");
    players = getplayers();
    foreach (player in players) {
        player clientfield::set_player_uimodel("hudItems.onslaught.wave_number", level.var_50c8366e);
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x41a3cf1f, Offset: 0x35c8
// Size: 0x29e
function function_453afff4() {
    /#
    #/
    while (true) {
        var_88f09c5 = level.var_3a23a27;
        players = getplayers();
        foreach (player in players) {
            player function_813aaa72(int(level.var_bc2071f));
        }
        /#
            if (is_true(level.var_2b37d0dd)) {
                debug2dtext((670, 160, 0), "<dev string:x46>" + level.var_50c8366e, (1, 1, 1), 1, (0, 0, 0), 0.5, 2.8, 1);
                debug2dtext((670, 220, 0), "<dev string:x55>" + var_88f09c5 + "<dev string:x5e>" + var_88f09c5, (1, 1, 1), 1, (0, 0, 0), 0.5, 2.8, 1);
                debug2dtext((670, 280, 0), "<dev string:x63>" + level.total_zombies_killed, (1, 1, 1), 1, (0, 0, 0), 0.5, 2.8, 1);
                debug2dtext((670, 340, 0), "<dev string:x71>" + level.var_9b7bd0e8, (1, 1, 1), 1, (0, 0, 0), 0.5, 2.8, 1);
                debug2dtext((670, 400, 0), "<dev string:x81>" + level.var_bc2071f, (1, 1, 1), 1, (0, 0, 0), 0.5, 2.8, 1);
            }
        #/
        waitframe(1);
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xafb0a59b, Offset: 0x3870
// Size: 0x36
function game_over() {
    level._supress_survived_screen = 1;
    level.var_ea32773 = &function_ea32773;
    level.var_94048a02 = undefined;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0x152b302c, Offset: 0x38b0
// Size: 0x430
function function_ea32773(waitresult) {
    var_de1d6cbf = waitresult.reason;
    players = getplayers();
    foreach (player in players) {
        player clientfield::set_player_uimodel("hudItems.onslaught.wave_number", level.var_50c8366e);
        player val::set(#"gameobjects", "freezecontrols");
        player val::set(#"gameobjects", "disable_weapons");
    }
    wait 1;
    players = getplayers();
    foreach (player in players) {
        player clientfield::set_player_uimodel("hudItems.onslaught.wave_number", level.var_50c8366e);
        if (isdefined(var_de1d6cbf)) {
            if (var_de1d6cbf == #"hash_202cd290462b445b") {
                player thread function_61c3d59c(#"hash_52600c7f01373411", 10);
            } else if (var_de1d6cbf == #"last_player_died") {
                player thread function_61c3d59c(#"hash_11bdf336f5affc7f", 10);
            } else if (var_de1d6cbf == #"all_players_dead") {
                player thread function_61c3d59c(#"hash_11bdf336f5affc7f", 10);
            }
        }
        player thread function_2617d862();
    }
    level thread function_73297fa();
    if (isdefined(level.deathcircle.var_5c54ab33)) {
        level.deathcircle.var_5c54ab33 delete();
    }
    wait 2;
    players = getplayers();
    foreach (player in players) {
        player thread function_cf4e42ea();
    }
    wait 10;
    players = getplayers();
    foreach (player in players) {
        player thread function_251073e9();
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3ce8
// Size: 0x4
function run_timer() {
    
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0x496df2aa, Offset: 0x3cf8
// Size: 0x96
function function_334be69a(tacpoint) {
    navmeshpoint = getclosestpointonnavmesh(tacpoint.origin, 64, 32);
    if (!isdefined(navmeshpoint)) {
        return true;
    }
    if (!tracepassedonnavmesh(tacpoint.origin, navmeshpoint, 32)) {
        return true;
    }
    if (!ispointonnavmesh(tacpoint.origin, 32)) {
        return true;
    }
    return false;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xc9f0ff00, Offset: 0x3d98
// Size: 0xb8c
function function_7f501c21() {
    level endon(#"end_game");
    while (level.var_bc2071f < 100 && level.var_df7b46d1.state == 1) {
        var_c5eed04e = array::random(function_a1ef346b());
        var_e5c52b73 = var_c5eed04e.origin;
        player_angles = var_c5eed04e getplayerangles();
        var_c4c03968 = randomintrange(-80, 80);
        /#
            if (is_true(level.var_9725eb4a)) {
                var_c4c03968 = 0;
            }
        #/
        player_angles += (0, var_c4c03968, 0);
        player_dir = anglestoforward(player_angles);
        var_78da6163 = getclosesttacpoint(var_c5eed04e.origin);
        if (!isdefined(var_78da6163) && isdefined(var_c5eed04e.last_valid_position)) {
            /#
                if (is_true(level.var_bc79322a)) {
                    circle(var_c5eed04e.last_valid_position, 150, (1, 0, 0), 1, 1, 400);
                }
            #/
            var_78da6163 = getclosesttacpoint(var_c5eed04e.last_valid_position);
        }
        /#
            if (is_true(level.var_bc79322a)) {
                circle(var_e5c52b73, 500, (1, 1, 0), 1, 1, 400);
                circle(var_e5c52b73, 1000, (0, 1, 1), 1, 1, 400);
            }
        #/
        var_3c69a222 = tacticalquery("onslaught_tacticalquery", var_e5c52b73, var_c5eed04e);
        var_d23463ac = undefined;
        var_3ab48a16 = undefined;
        var_5bfbb8b9 = [];
        if (isdefined(var_3c69a222)) {
            var_99b8deb8 = [];
            var_c377abe7 = [];
            var_e28e2aaf = [];
            for (i = 0; i < var_3c69a222.size; i++) {
                tacpoint = var_3c69a222[i];
                if (!isdefined(tacpoint.var_356cbbd9)) {
                    /#
                        if (is_true(level.var_58c95941)) {
                            circle(tacpoint.origin, 20, (0, 0, 1), 1, 1, 400);
                        }
                    #/
                    tacpoint.var_356cbbd9 = function_334be69a(tacpoint);
                }
                /#
                    if (is_true(level.var_58c95941)) {
                        if (is_true(tacpoint.var_356cbbd9)) {
                            circle(tacpoint.origin, 10, (1, 0, 0), 1, 1, 400);
                        } else {
                            circle(tacpoint.origin, 10, (0, 1, 0), 1, 1, 400);
                        }
                    }
                #/
                if (is_true(tacpoint.var_356cbbd9)) {
                    continue;
                }
                var_3acd7553 = 0;
                if (is_true(tacpoint.used_time)) {
                    current_time = gettime();
                    if (current_time < tacpoint.used_time + 10000) {
                        var_3acd7553 = 1;
                    }
                }
                if (is_true(var_3acd7553)) {
                    continue;
                }
                tacpoint.used_time = undefined;
                var_5bfbb8b9[var_5bfbb8b9.size] = tacpoint;
                var_99b8deb8[i] = 0;
                var_c377abe7[i] = 0;
                var_e28e2aaf[i] = 0;
                var_d32308ac = 0;
                if (isdefined(var_78da6163)) {
                    if (tacpoint.region == var_78da6163.region) {
                        var_d32308ac = 1;
                    } else {
                        var_1c28df18 = function_b507a336(var_78da6163.region);
                        foreach (neighbor in var_1c28df18.neighbors) {
                            if (tacpoint.region == neighbor) {
                                var_d32308ac = 1;
                            }
                        }
                    }
                }
                if (!var_d32308ac) {
                    continue;
                }
                dist_sq = distancesquared(var_c5eed04e.origin, tacpoint.origin);
                var_99b8deb8[i] = dist_sq / 1000 * 1000;
                var_152be849 = vectornormalize(tacpoint.origin - var_e5c52b73);
                dotproduct = vectordot(var_152be849, player_dir);
                var_c377abe7[i] = dotproduct;
                var_e28e2aaf[i] = var_99b8deb8[i] + var_c377abe7[i];
                if (!isdefined(var_d23463ac) || var_3ab48a16 < var_e28e2aaf[i]) {
                    var_d23463ac = var_3c69a222[i];
                    var_3ab48a16 = var_e28e2aaf[i];
                }
            }
            for (i = 0; i < var_3c69a222.size; i++) {
                tacpoint = var_3c69a222[i];
                /#
                    color = (0, 1, 0);
                    if (is_true(level.var_bc79322a)) {
                        drawcross(tacpoint.origin, color, 400);
                        if (is_true(tacpoint.used_time)) {
                            sphere(tacpoint.origin + (0, 0, 10), 6, (1, 0, 0), 1, 0, 8, 400);
                        }
                    }
                #/
            }
        }
        if (isdefined(var_78da6163)) {
            /#
                println("<dev string:x8b>" + var_78da6163.region);
                var_1c28df18 = function_b507a336(var_78da6163.region);
                foreach (neighbor in var_1c28df18.neighbors) {
                    println("<dev string:xa0>" + neighbor);
                }
            #/
        }
        if (!isdefined(var_d23463ac) && var_5bfbb8b9.size > 0) {
            randindex = randomintrange(0, var_5bfbb8b9.size - 1);
            var_d23463ac = var_5bfbb8b9[randindex];
        }
        if (isdefined(var_d23463ac)) {
            /#
                if (is_true(level.var_bc79322a)) {
                    sphere(var_d23463ac.origin + (0, 0, 30), 10, color, 1, 0, 8, 400);
                    println("<dev string:xae>" + var_3ab48a16 + "<dev string:xc0>" + var_d23463ac.region);
                }
            #/
            var_d23463ac.used_time = gettime();
            var_83959d6f = vectornormalize(var_c5eed04e.origin - var_d23463ac.origin);
            var_61187803 = vectortoangles(var_83959d6f);
            var_78da6163 = getclosesttacpoint(var_c5eed04e.origin);
            var_b434916b = function_ec2b3302();
            ai = spawnactor(var_b434916b, var_d23463ac.origin + (0, 0, 10), var_61187803);
            if (isdefined(ai)) {
                ai.no_powerups = 0;
                ai.type = var_b434916b;
                ai clientfield::set("enemy_on_radar", 1);
                ai thread function_d6ad49c2();
                if (var_b434916b == #"hash_5f22ecce894282fa") {
                    ai thread function_1495c8c(ai.origin, ai.angles, "ai_t9_zm_zombie_base_traverse_ground_climbout_fast");
                } else {
                    ai thread function_1495c8c(ai.origin, ai.angles, "ai_t9_zm_zombie_dog_spawn_air_plaguehound_01");
                }
            }
        }
        while (function_5ded2774() >= level.var_6693a0b6) {
            waitframe(1);
        }
        wait level.var_3e67b08d;
    }
    level flag::clear("onslaught_round_logic_inprogress");
    level flag::set("onslaught_round_logic_complete");
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0x66b6b8e3, Offset: 0x4930
// Size: 0x20e
function function_6d6a276c(var_da0b6672) {
    while (true) {
        var_b3dbfd56 = level.var_d5dc0bf2;
        /#
            if (is_true(level.var_2b37d0dd)) {
                circle(var_b3dbfd56, var_da0b6672, (1, 1, 0), 1, 1, 1);
                circle(var_b3dbfd56 + (0, 0, 20), var_da0b6672, (0, 1, 1), 1, 1, 1);
                circle(var_b3dbfd56 + (0, 0, 40), var_da0b6672, (0, 1, 1), 1, 1, 1);
                circle(var_b3dbfd56 + (0, 0, 60), var_da0b6672, (0, 1, 1), 1, 1, 1);
                circle(var_b3dbfd56 + (0, 0, 80), var_da0b6672, (0, 1, 1), 1, 1, 1);
            }
        #/
        /#
            drawcross(var_b3dbfd56 + (0, 0, 10), (1, 0, 0), 1);
            drawcross(var_b3dbfd56 + (0, 0, 20), (0, 1, 0), 1);
            drawcross(var_b3dbfd56 + (0, 0, 30), (0, 0, 1), 1);
        #/
        waitframe(1);
    }
}

/#

    // Namespace namespace_51f64aa9/namespace_51f64aa9
    // Params 0, eflags: 0x0
    // Checksum 0xe349af42, Offset: 0x4b48
    // Size: 0xb2
    function function_54fc66c6() {
        while (true) {
            foreach (point in self) {
                circle(point.origin, 30, (1, 1, 0), 1, 1, 1);
            }
            waitframe(1);
        }
    }

    // Namespace namespace_51f64aa9/namespace_51f64aa9
    // Params 1, eflags: 0x0
    // Checksum 0x11700f7a, Offset: 0x4c08
    // Size: 0x156
    function function_33824ce9(maxpoint) {
        while (true) {
            foreach (var_d13f3ba2 in self) {
                foreach (point in var_d13f3ba2) {
                    circle(point.origin, 5, (1, 0, 0), 1, 1, 1);
                }
            }
            circle(maxpoint.origin, 3, (1, 1, 0), 1, 1, 1);
            waitframe(1);
        }
    }

    // Namespace namespace_51f64aa9/namespace_51f64aa9
    // Params 0, eflags: 0x0
    // Checksum 0xac465d5b, Offset: 0x4d68
    // Size: 0xb2
    function function_122d85c7() {
        while (true) {
            foreach (point in self) {
                circle(point.origin, 6, (0, 0, 1), 1, 1, 1);
            }
            waitframe(1);
        }
    }

#/

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x20e8a51a, Offset: 0x4e28
// Size: 0x4dc
function function_26667466() {
    self endon(#"death");
    while (true) {
        switch (self.state) {
        case 0:
            level.var_a7bd1c53 = (0, 0, 0);
            players = getplayers();
            if (isdefined(players) && players.size > 0) {
                foreach (player in players) {
                    if (isalive(player)) {
                        level.var_a7bd1c53 += player.origin;
                    }
                }
                level.var_a7bd1c53 /= players.size;
                level.var_a7bd1c53 += (0, 0, 100);
            }
            level.var_df7b46d1 clientfield::set("bot_claim_fx", 1);
            wait 5;
            self.state = 1;
            break;
        case 1:
            break;
        case 2:
            level.var_a7bd1c53 = (0, 0, 0);
            players = getplayers();
            if (isdefined(players) && players.size > 0) {
                foreach (player in players) {
                    if (isalive(player)) {
                        level.var_a7bd1c53 += player.origin;
                    }
                }
                level.var_a7bd1c53 /= players.size;
                level.var_a7bd1c53 += (0, 0, 100);
            }
            var_e4547143 = vectornormalize(level.var_a7bd1c53 - self.origin);
            var_531130b2 = distance2dsquared(level.var_a7bd1c53, self.origin);
            var_bf58cac7 = level.circle_radius * 0.5;
            if (var_531130b2 > var_bf58cac7 * var_bf58cac7) {
                self.origin += var_e4547143 * 20;
            }
            break;
        case 3:
            if (isdefined(level.var_d4c0ef1a[level.var_b92db9a8].objectiveanchor)) {
                level.var_a7bd1c53 = level.var_d4c0ef1a[level.var_b92db9a8].objectiveanchor.origin;
                level.var_a7bd1c53 += (0, 0, 100);
            }
            if (isdefined(level.var_a7bd1c53)) {
                var_e4547143 = vectornormalize(level.var_a7bd1c53 - self.origin);
                var_531130b2 = distance2dsquared(level.var_a7bd1c53, self.origin);
                var_bf58cac7 = 10;
                if (var_531130b2 > var_bf58cac7 * var_bf58cac7) {
                    self.origin += var_e4547143 * 10;
                } else {
                    self.state = 4;
                    level.var_bc2071f = 0;
                }
            }
            break;
        case 4:
            break;
        default:
            break;
        }
        waitframe(1);
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x43ef9d39, Offset: 0x5310
// Size: 0xf6
function function_86d134a1() {
    level endon(#"end_game");
    level.deathcircle.var_5c54ab33 = death_circle::function_a8749d88(self.origin, 1000, 5, 1);
    level thread death_circle::function_dc15ad60(level.deathcircle.var_5c54ab33);
    while (true) {
        level.circle_radius = 1000;
        if (isdefined(level.deathcircle.var_5c54ab33)) {
            death_circle::function_9229c3b3(level.deathcircle.var_5c54ab33, level.circle_radius, self.origin, 0);
        }
        waitframe(1);
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x202d37a0, Offset: 0x5410
// Size: 0x15c
function function_81c192d() {
    if (isdefined(level.var_df7b46d1)) {
        return;
    }
    players = getplayers();
    var_bb96c5ab = players[0].origin;
    var_f21608fd = players[0].angles;
    fwdvec = anglestoforward(var_f21608fd);
    level.var_df7b46d1 = spawn("script_model", var_bb96c5ab + fwdvec * 300 + (0, 0, 100));
    level.var_df7b46d1 setmodel("tag_origin");
    level.var_df7b46d1 clientfield::set("orb_spawn", 1);
    level.var_df7b46d1.state = 0;
    level.var_df7b46d1 thread function_26667466();
    level.var_df7b46d1 thread function_86d134a1();
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0x26dbd37c, Offset: 0x5578
// Size: 0x264
function function_3be471a2(var_78664f9a) {
    circle_radius = 1000;
    if (!level.deathcircle.enabled) {
        return;
    }
    level thread function_6d6a276c(circle_radius);
    if (is_true(var_78664f9a)) {
        if (!isdefined(level.var_d4c0ef1a) || level.var_d4c0ef1a.size > 0) {
            level.var_df7b46d1.state = 3;
            while (level.var_bc2071f > 0) {
                level.var_bc2071f = max(0, level.var_bc2071f - 1);
                players = getplayers();
                foreach (player in players) {
                    level.mp_gamemode_onslaught_score_msg mp_gamemode_onslaught_score_msg::function_94b2b0bd(player);
                }
                wait 0.1;
            }
        }
        if (level.var_df7b46d1.state != 4) {
            level.var_df7b46d1.state = 1;
            players = getplayers();
            foreach (player in players) {
                player thread function_61c3d59c(#"hash_974629be3cf5e84", 12);
            }
        }
        level.var_bc2071f = 0;
    }
}

/#

    // Namespace namespace_51f64aa9/namespace_51f64aa9
    // Params 0, eflags: 0x0
    // Checksum 0x45a7256f, Offset: 0x57e8
    // Size: 0x34a
    function function_6ea2e9fa() {
        level endon(#"end_game");
        color = (0, 1, 0);
        var_457e9ab8 = (1, 0, 0);
        var_3045d5d6 = (0, 0, 1);
        duration = 1;
        while (true) {
            var_d1803e09 = level.var_df7b46d1.origin;
            for (i = 0; i < 10; i++) {
                drawcross(var_d1803e09 + (0, 0, i * 10), var_3045d5d6, duration);
            }
            foreach (var_2d5745a8 in level.var_d4c0ef1a) {
                if (is_true(level.var_2b37d0dd)) {
                    var_188f8bf = distance2d(var_d1803e09, var_2d5745a8.origin);
                    print3d(var_2d5745a8.origin + (0, 0, 200), var_188f8bf, var_3045d5d6, 1, 4, duration, 1);
                    print3d(var_2d5745a8.origin + (0, 0, 240), var_2d5745a8.usecount, var_3045d5d6, 1, 2, duration, 1);
                    if (isdefined(level.var_771d8317)) {
                        if (var_188f8bf > level.var_771d8317) {
                            print3d(var_2d5745a8.origin + (0, 0, 300), "<dev string:xcc>", var_3045d5d6, 1, 2, duration, 1);
                        }
                    }
                    if (is_true(var_2d5745a8.is_active)) {
                        for (i = 0; i < 20; i++) {
                            drawcross(var_2d5745a8.origin + (0, 0, i * 10), var_457e9ab8, duration);
                        }
                        continue;
                    }
                    for (i = 0; i < 10; i++) {
                        drawcross(var_2d5745a8.origin + (0, 0, i * 10), color, duration);
                    }
                }
            }
            waitframe(1);
        }
    }

#/

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x4a15f9fe, Offset: 0x5b40
// Size: 0x164
function setup_zones() {
    if (!isdefined(level.var_d4c0ef1a)) {
        return undefined;
    }
    for (i = 0; i < level.var_d4c0ef1a.size; i++) {
        zone = level.var_d4c0ef1a[i];
        nodes = tacticalquery("onslaught_boss_spawn_tacticalquery", zone.origin, zone);
        if (nodes.size == 0) {
            continue;
        }
        zone.objectiveanchor = spawn("script_model", nodes[0].origin);
        zone.objectiveanchor setmodel("tag_origin");
        zone.objectiveanchor clientfield::set("boss_zone_on_radar", 0);
    }
    if (isdefined(level.var_d4c0ef1a) && level.var_d4c0ef1a.size > 0) {
        level thread function_f19e31a2();
        /#
            level thread function_6ea2e9fa();
        #/
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0x2b99a747, Offset: 0x5cb0
// Size: 0x108
function function_10986874(var_c2f7b1a3) {
    level endon(#"end_game");
    level notify(#"hash_5731a6df491c37c7", {#location:var_c2f7b1a3});
    players = getplayers();
    foreach (player in players) {
        player thread function_f9b8bf44(#"hash_2ecde6d705d1052b", 4);
    }
    wait 0.5;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xc88c2c7f, Offset: 0x5dc0
// Size: 0x6ee
function function_f19e31a2() {
    level endon(#"end_game");
    level.var_90295a46 = -1;
    level.var_771d8317 = 1500;
    while (true) {
        level flag::wait_till("onslaught_round_logic_complete");
        level.var_b92db9a8 = 0;
        var_d1803e09 = level.var_df7b46d1.origin;
        var_e08e369 = [];
        for (i = 0; i < level.var_d4c0ef1a.size; i++) {
            var_2d5745a8 = level.var_d4c0ef1a[i];
            var_80f42676 = distance2d(var_d1803e09, var_2d5745a8.origin);
            if (var_80f42676 > level.var_771d8317) {
                var_e08e369[var_e08e369.size] = i;
            }
        }
        level.var_b92db9a8 = var_e08e369[randomint(var_e08e369.size)];
        level.var_d4c0ef1a[level.var_b92db9a8].is_active = 1;
        level.var_d4c0ef1a[level.var_b92db9a8].usecount = level.var_d4c0ef1a[level.var_b92db9a8].usecount + 1;
        level.var_d4c0ef1a[level.var_b92db9a8].objectiveanchor clientfield::set("boss_zone_on_radar", 1);
        var_c2f7b1a3 = level.var_d4c0ef1a[level.var_b92db9a8].objectiveanchor.origin;
        level thread function_10986874(var_c2f7b1a3);
        while (level.var_df7b46d1.state != 4) {
            waitframe(1);
        }
        /#
            debug2dtext((1000, 700, 0), "<dev string:xd4>", (1, 1, 1), 1, (0, 0, 0), 0.5, 2.8, 200);
        #/
        var_9cf0f18d = getclosesttacpoint(var_c2f7b1a3);
        if (!isdefined(var_9cf0f18d)) {
            continue;
        }
        /#
            debug2dtext((1000, 700, 0), "<dev string:xe4>", (1, 1, 1), 1, (0, 0, 0), 0.5, 2.8, 200);
        #/
        level.var_d4c0ef1a[level.var_b92db9a8].objectiveanchor clientfield::set("boss_zone_on_radar", 2);
        level.var_df7b46d1 clientfield::set("bot_claim_fx", 0);
        wait 2;
        var_9cf0f18d thread function_3fd720cc();
        wait 4;
        /#
            debug2dtext((1000, 700, 0), "<dev string:x102>", (1, 1, 1), 1, (0, 0, 0), 0.5, 2.8, 200);
        #/
        level.var_d4c0ef1a[level.var_b92db9a8].objectiveanchor clientfield::set("boss_zone_on_radar", 3);
        zm_sq::objective_complete(#"hash_641e9c4d20df5950");
        level.var_4095f78b = spawnactor(function_2f6706d2(), var_9cf0f18d.origin, (0, 0, 0));
        level.var_4095f78b function_6c40ff50();
        level.var_4095f78b thread function_c08eb1c4();
        level.var_4095f78b thread function_a371376();
        level.var_4095f78b thread function_b5ba566b(level.var_4095f78b.origin, level.var_4095f78b.angles, "ai_t9_zm_steiner_base_com_stn_pain_ww_idle_loop_01");
        players = getplayers();
        foreach (player in players) {
            player thread function_4b12e9e4(#"hash_716b685adb4ee97e", 5);
        }
        level waittill(#"hash_1b8264e950c01344");
        players = getplayers();
        foreach (player in players) {
            player thread function_f9b8bf44(#"hash_510efedaf583adae", 5);
        }
        level.var_90295a46 = level.var_b92db9a8;
        level.var_d4c0ef1a[level.var_b92db9a8].is_active = 0;
        level.var_d4c0ef1a[level.var_b92db9a8].objectiveanchor clientfield::set("boss_zone_on_radar", 0);
        wait 1;
        level.var_df7b46d1 clientfield::set("bot_claim_fx", 1);
        level.var_df7b46d1.state = 1;
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x8a74de52, Offset: 0x64b8
// Size: 0xfc
function function_b504f826() {
    level endon(#"end_game");
    while (true) {
        if (isdefined(level.var_bc2071f) && level.var_bc2071f < 10) {
            players = getplayers();
            foreach (player in players) {
                level.mp_gamemode_onslaught_score_msg mp_gamemode_onslaught_score_msg::function_d74c17ab(player);
            }
        }
        wait 0.5;
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x4592298e, Offset: 0x65c0
// Size: 0xfc
function function_31add0ec() {
    level endon(#"end_game");
    while (true) {
        if (isdefined(level.var_bc2071f) && level.var_bc2071f > 99) {
            players = getplayers();
            foreach (player in players) {
                level.mp_gamemode_onslaught_score_msg mp_gamemode_onslaught_score_msg::function_4bfdafeb(player);
            }
        }
        wait 0.5;
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x1750cf94, Offset: 0x66c8
// Size: 0x3e8
function function_69e5b9b() {
    level endon(#"end_game");
    level.var_d5dc0bf2 = (0, 0, 0);
    level thread function_b504f826();
    level thread function_31add0ec();
    level flag::wait_till("rounds_started");
    level setup_zones();
    level.var_3e67b08d = 3;
    level.var_5bc110b3 = 4;
    level.var_d2a573c6 = 4;
    level.var_b4b52d95 = 3;
    level.total_zombies_killed = 0;
    level.var_9b7bd0e8 = 0;
    function_8f93a196();
    function_c50adb68(1);
    level thread function_453afff4();
    level thread run_timer();
    level thread game_over();
    level thread function_3be471a2(0);
    while (true) {
        players = getplayers();
        foreach (player in players) {
            player thread function_da556d60();
        }
        wait level.var_d2a573c6;
        while (level.var_df7b46d1.state == 4) {
            waitframe(1);
        }
        level.run_timer = 1;
        level flag::set("onslaught_round_logic_inprogress");
        self thread function_7f501c21();
        level flag::wait_till("onslaught_round_logic_complete");
        level.run_timer = 0;
        level.var_df7b46d1 clientfield::set("bot_claim_fx", 2);
        level thread function_46ff5efa();
        waitframe(1);
        players = getplayers();
        foreach (player in players) {
            player thread function_61c3d59c(#"hash_45c805c821004d91", 8);
        }
        wait 2;
        level function_3be471a2(1);
        wait level.var_b4b52d95;
        function_c50adb68(level.var_50c8366e + 1);
    }
}

// Namespace namespace_51f64aa9/bhtn_action_start
// Params 1, eflags: 0x40
// Checksum 0xa02f6012, Offset: 0x6ab8
// Size: 0x2c2
function event_handler[bhtn_action_start] function_320145f7(eventstruct) {
    if (isdefined(self.var_b467f3a1)) {
        self thread [[ self.var_b467f3a1 ]](eventstruct);
        return;
    }
    notify_string = eventstruct.action;
    switch (notify_string) {
    case #"death":
        if (is_true(self.bgb_tone_death)) {
            level thread zmbaivox_playvox(self, "death_whimsy", 1, 4);
        } else if (is_true(self.bgb_quacknarok)) {
            level thread zmbaivox_playvox(self, "death_quack", 1, 4);
        } else {
            level thread zmbaivox_playvox(self, notify_string, 1, 4);
        }
        break;
    case #"pain":
        level thread zmbaivox_playvox(self, notify_string, 1, 3);
        break;
    case #"behind":
        level thread zmbaivox_playvox(self, notify_string, 1, 3);
        break;
    case #"electrocute":
        level thread zmbaivox_playvox(self, notify_string, 1, 3);
        break;
    case #"attack_melee_notetrack":
        level thread zmbaivox_playvox(self, "attack_melee", 1, 2, 1);
        break;
    case #"sprint":
    case #"ambient":
    case #"crawler":
    case #"teardown":
    case #"taunt":
        level thread zmbaivox_playvox(self, notify_string, 0, 1);
        break;
    case #"attack_melee":
        break;
    default:
        level thread zmbaivox_playvox(self, notify_string, 0, 2);
        break;
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x635df636, Offset: 0x6d88
// Size: 0x64
function zmbaivox_notifyconvert() {
    self endon(#"death", #"disconnect");
    level endon(#"game_ended");
    self thread zmbaivox_playdeath();
    self thread zmbaivox_playelectrocution();
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 5, eflags: 0x0
// Checksum 0xa0f62db6, Offset: 0x6df8
// Size: 0x38a
function zmbaivox_playvox(zombie, type, override, priority, delayambientvox = 0) {
    zombie endon(#"death");
    if (!isdefined(zombie)) {
        return;
    }
    if (!isdefined(zombie.voiceprefix)) {
        return;
    }
    if (!isdefined(priority)) {
        priority = 1;
    }
    if (!isdefined(zombie.talking)) {
        zombie.talking = 0;
    }
    if (!isdefined(zombie.currentvoxpriority)) {
        zombie.currentvoxpriority = 1;
    }
    if (!isdefined(self.delayambientvox)) {
        self.delayambientvox = 0;
    }
    if (is_true(zombie.var_e8920729)) {
        return;
    }
    if ((type == "ambient" || type == "sprint" || type == "crawler") && is_true(self.delayambientvox)) {
        return;
    }
    if (delayambientvox) {
        self.delayambientvox = 1;
        self thread zmbaivox_ambientdelay();
    }
    alias = "zmb_vocals_" + zombie.voiceprefix + "_" + type;
    if (sndisnetworksafe()) {
        if (is_true(override)) {
            if (isdefined(zombie.currentvox) && priority > zombie.currentvoxpriority) {
                zombie stopsound(zombie.currentvox);
                waitframe(1);
            }
            if (type == "death" || type == "death_whimsy" || type == "death_nohead") {
                zombie playsound(alias);
                return;
            }
        }
        if (zombie.talking === 1 && (priority < zombie.currentvoxpriority || priority === 1)) {
            return;
        }
        if (is_true(zombie.head_gibbed)) {
            return;
        }
        zombie.talking = 1;
        zombie.currentvox = alias;
        zombie.currentvoxpriority = priority;
        zombie playsoundontag(alias, "j_head");
        playbacktime = float(max(isdefined(soundgetplaybacktime(alias)) ? soundgetplaybacktime(alias) : 500, 500)) / 1000;
        wait playbacktime;
        zombie.talking = 0;
        zombie.currentvox = undefined;
        zombie.currentvoxpriority = 1;
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xb6139959, Offset: 0x7190
// Size: 0xe4
function zmbaivox_playdeath() {
    self endon(#"disconnect");
    self waittill(#"death");
    if (isdefined(self)) {
        if (is_true(self.bgb_tone_death)) {
            level thread zmbaivox_playvox(self, "death_whimsy", 1);
            return;
        }
        if (is_true(self.head_gibbed)) {
            level thread zmbaivox_playvox(self, "death_nohead", 1);
            return;
        }
        level thread zmbaivox_playvox(self, "death", 1);
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xb1bc40f, Offset: 0x7280
// Size: 0x11a
function zmbaivox_playelectrocution() {
    self endon(#"disconnect", #"death");
    while (true) {
        waitresult = self waittill(#"damage");
        weapon = waitresult.weapon;
        if (!isdefined(weapon)) {
            continue;
        }
        if (weapon.name === #"zombie_beast_lightning_dwl" || weapon.name === #"zombie_beast_lightning_dwl2" || weapon.name === #"zombie_beast_lightning_dwl3") {
            bhtnactionstartevent(self, "electrocute");
            self notify(#"bhtn_action_notify", {#action:"electrocute"});
        }
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x9e381e0a, Offset: 0x73a8
// Size: 0x5a
function zmbaivox_ambientdelay() {
    self notify(#"sndambientdelay");
    self endon(#"sndambientdelay", #"death", #"disconnect");
    wait 2;
    self.delayambientvox = 0;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xf24d322b, Offset: 0x7410
// Size: 0x30
function networksafereset() {
    while (true) {
        level._numzmbaivox = 0;
        util::wait_network_frame();
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x6fe09325, Offset: 0x7448
// Size: 0x54
function sndisnetworksafe() {
    if (!isdefined(level._numzmbaivox)) {
        level thread networksafereset();
    }
    if (level._numzmbaivox >= 2) {
        return false;
    }
    level._numzmbaivox++;
    return true;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xd5170c41, Offset: 0x74a8
// Size: 0x32
function get_zombie_array() {
    enemies = getaiarchetypearray(#"zombie");
    return enemies;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x8faf321c, Offset: 0x74e8
// Size: 0x32
function function_4f20e746() {
    enemies = getaiarchetypearray(#"zombie_dog");
    return enemies;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x3d351ae4, Offset: 0x7528
// Size: 0x4c
function function_5ded2774() {
    enemies = get_zombie_array();
    var_b56897f8 = function_4f20e746();
    return var_b56897f8.size + enemies.size;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0x8e2be10a, Offset: 0x7580
// Size: 0x24
function is_last_zombie() {
    if (function_5ded2774() <= 1) {
        return true;
    }
    return false;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0xc5e0f5d0, Offset: 0x75b0
// Size: 0x3e
function getyaw(org) {
    angles = vectortoangles(org - self.origin);
    return angles[1];
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0xe156eb02, Offset: 0x75f8
// Size: 0x62
function getyawtospot(spot) {
    pos = spot;
    yaw = self.angles[1] - getyaw(pos);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xa9477108, Offset: 0x7668
// Size: 0x364
function zombie_behind_vox() {
    level endon(#"unloaded");
    self endon(#"death", #"disconnect");
    if (!isdefined(level._zbv_vox_last_update_time)) {
        level._zbv_vox_last_update_time = 0;
        level._audio_zbv_shared_ent_list = get_zombie_array();
    }
    while (true) {
        wait 1;
        t = gettime();
        if (t > level._zbv_vox_last_update_time + 1000) {
            level._zbv_vox_last_update_time = t;
            level._audio_zbv_shared_ent_list = get_zombie_array();
        }
        zombs = level._audio_zbv_shared_ent_list;
        played_sound = 0;
        for (i = 0; i < zombs.size; i++) {
            if (!isdefined(zombs[i])) {
                continue;
            }
            if (zombs[i].isdog) {
                continue;
            }
            dist = 150;
            z_dist = 50;
            alias = level.vox_behind_zombie;
            if (isdefined(zombs[i].zombie_move_speed)) {
                switch (zombs[i].zombie_move_speed) {
                case #"walk":
                    dist = 150;
                    break;
                case #"run":
                    dist = 175;
                    break;
                case #"sprint":
                    dist = 200;
                    break;
                }
            }
            if (distancesquared(zombs[i].origin, self.origin) < dist * dist) {
                yaw = self getyawtospot(zombs[i].origin);
                z_diff = self.origin[2] - zombs[i].origin[2];
                if ((yaw < -95 || yaw > 95) && abs(z_diff) < 50) {
                    wait 0.1;
                    if (isdefined(zombs[i]) && isalive(zombs[i])) {
                        bhtnactionstartevent(zombs[i], "behind");
                        zombs[i] notify(#"bhtn_action_notify", {#action:"behind"});
                        played_sound = 1;
                    }
                    break;
                }
            }
        }
        if (played_sound) {
            wait 2.5;
        }
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 0, eflags: 0x0
// Checksum 0xeeb842fd, Offset: 0x79d8
// Size: 0x170
function play_ambient_zombie_vocals() {
    self endon(#"death");
    while (true) {
        type = "ambient";
        float = 3;
        if (isdefined(self.zombie_move_speed)) {
            switch (self.zombie_move_speed) {
            case #"walk":
                type = "ambient";
                float = 3;
                break;
            case #"run":
                type = "sprint";
                float = 3;
                break;
            case #"sprint":
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

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 2, eflags: 0x0
// Checksum 0xc67f3623, Offset: 0x7b50
// Size: 0x98
function function_713192b1(str_location, var_39acfdda) {
    if (!isdefined(level.var_cbcee8da)) {
        level.var_cbcee8da = [];
    }
    if (!isdefined(level.var_b2a9a8d7)) {
        level.var_b2a9a8d7 = [];
    }
    if (!isdefined(level.var_cbcee8da[var_39acfdda])) {
        level.var_cbcee8da[var_39acfdda] = 0;
    }
    if (!isdefined(level.var_b2a9a8d7[str_location])) {
        level.var_b2a9a8d7[str_location] = var_39acfdda;
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0xfd9441d0, Offset: 0x7bf0
// Size: 0x100
function location_vox(str_location) {
    if (!isdefined(level.var_b2a9a8d7)) {
        return;
    }
    if (!isdefined(level.var_b2a9a8d7[str_location])) {
        return;
    }
    var_39acfdda = level.var_b2a9a8d7[str_location];
    if (!isdefined(self.var_cbcee8da)) {
        self.var_cbcee8da = [];
    }
    if (!isdefined(self.var_cbcee8da[var_39acfdda])) {
        self.var_cbcee8da[var_39acfdda] = 0;
    }
    if (!level.var_cbcee8da[var_39acfdda] && !self.var_cbcee8da[var_39acfdda]) {
        self.var_cbcee8da[var_39acfdda] = 1;
        b_played = 0;
        if (is_true(b_played)) {
            level.var_cbcee8da[var_39acfdda] = 1;
        }
    }
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0xf6d9211e, Offset: 0x7cf8
// Size: 0x7c
function get_number_variants(aliasprefix) {
    for (i = 0; i < 20; i++) {
        if (!soundexists(aliasprefix + "_" + i)) {
            return i;
        }
    }
    assertmsg("<dev string:x119>");
}

// Namespace namespace_51f64aa9/namespace_51f64aa9
// Params 1, eflags: 0x0
// Checksum 0x5dc57e52, Offset: 0x7d80
// Size: 0x12a
function get_valid_lines(aliasprefix) {
    a_variants = [];
    for (i = 0; i < 20; i++) {
        str_alias = aliasprefix + "_" + i;
        if (soundexists(str_alias)) {
            if (!isdefined(a_variants)) {
                a_variants = [];
            } else if (!isarray(a_variants)) {
                a_variants = array(a_variants);
            }
            a_variants[a_variants.size] = str_alias;
            continue;
        }
        if (soundexists(aliasprefix)) {
            if (!isdefined(a_variants)) {
                a_variants = [];
            } else if (!isarray(a_variants)) {
                a_variants = array(a_variants);
            }
            a_variants[a_variants.size] = aliasprefix;
            break;
        }
    }
    return a_variants;
}

