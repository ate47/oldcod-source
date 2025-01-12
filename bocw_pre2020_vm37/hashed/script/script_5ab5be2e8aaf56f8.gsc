#using script_1029986e2bc8ca8e;
#using script_113dd7f0ea2a1d4f;
#using script_12538a87a80a2978;
#using script_1cc417743d7c262d;
#using script_215d7818c548cb51;
#using script_27347f09888ad15;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_4163291d6e693552;
#using script_5961deb533dad533;
#using script_7fc996fe8678852;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_score;

#namespace namespace_24fd6413;

// Namespace namespace_24fd6413/level_init
// Params 1, eflags: 0x40
// Checksum 0xf655fc44, Offset: 0x390
// Size: 0x22c
function event_handler[level_init] main(*eventstruct) {
    clientfield::register("scriptmover", "" + #"hash_502be00d1af105e9", 1, 1, "counter");
    clientfield::register("scriptmover", "" + #"hash_771abe419eda7442", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_38e22f5ceb9065c", 1, 2, "int");
    clientfield::register("scriptmover", "" + #"hash_76d1986dfad6a190", 1, 2, "int");
    clientfield::register("scriptmover", "" + #"hash_43aa7cec00d262aa", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_582f769d593e00e0", 1, 1, "int");
    clientfield::register("actor", "" + #"hash_5342c00e940ad12b", 1, 1, "int");
    objective_manager::function_b3464a7c(#"secure", &init, &function_fb9dff2f, #"secure", #"hash_582ab7cd393c5d47");
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0x2afce857, Offset: 0x5c8
// Size: 0x7e4
function init(instance) {
    instance.var_344a6a1a = [];
    if (isdefined(instance.var_fe2612fe[#"platform"])) {
        instance.var_a43a7410 = namespace_8b6a9d79::spawn_script_model(instance.var_fe2612fe[#"platform"][0], instance.var_fe2612fe[#"platform"][0].model, 1);
    }
    if (isdefined(instance.var_fe2612fe[#"hash_4a44a667578f8f9d"])) {
        instance.var_2972bc14 = namespace_8b6a9d79::spawn_script_model(instance.var_fe2612fe[#"hash_4a44a667578f8f9d"][0], instance.var_fe2612fe[#"hash_4a44a667578f8f9d"][0].model, 1);
    }
    foreach (s_instance in instance.var_fe2612fe[#"secure"]) {
        s_instance.s_start = s_instance.var_fe2612fe[#"hash_6669e6979008287"][0];
        s_instance.var_4a416ea9 = namespace_8b6a9d79::spawn_script_model(s_instance, s_instance.model, 1);
        s_instance.var_4a416ea9.var_42dcbe3d = s_instance.var_fe2612fe[#"hash_38e22f5ceb9065c"];
        s_instance.var_4a416ea9.var_eff5bd11 = s_instance.var_fe2612fe[#"boundary"];
        s_instance.var_4a416ea9.var_559503f1 = s_instance.var_fe2612fe[#"spawn_pt"];
        s_instance.var_4a416ea9.a_s_rewards = s_instance.var_fe2612fe[#"reward"];
        for (i = 0; i < s_instance.var_4a416ea9.var_42dcbe3d.size; i++) {
            v_org = s_instance.var_4a416ea9.var_42dcbe3d[i].origin;
            if (s_instance.var_e5474455[i].script_int === 0) {
                v_offset = (0, 0, 1000);
            } else {
                v_offset = (0, 0, 0);
            }
            v_start = v_org + (0, 0, 8000) + v_offset;
            var_954ec1b6 = util::spawn_model(#"hash_91bd6c685ca0c64", v_start, s_instance.var_4a416ea9.var_42dcbe3d[i].angles);
            instance.var_344a6a1a[instance.var_344a6a1a.size] = var_954ec1b6;
            var_954ec1b6 hide();
            var_954ec1b6.var_848c555f = v_org;
            var_954ec1b6.n_id = s_instance.var_4a416ea9.var_42dcbe3d[i].script_int;
            var_954ec1b6.targetname = "drop_pod";
            var_954ec1b6.var_559503f1 = [];
            var_954ec1b6.var_eff5bd11 = [];
            var_954ec1b6.n_active = 0;
            foreach (var_c309b891 in s_instance.var_4a416ea9.var_eff5bd11) {
                if (var_c309b891.script_int === var_954ec1b6.n_id) {
                    var_954ec1b6.var_c309b891 = var_c309b891;
                }
            }
            foreach (s_spawnpt in s_instance.var_4a416ea9.var_559503f1) {
                if (s_spawnpt.script_int === var_954ec1b6.n_id) {
                    var_954ec1b6.var_559503f1[var_954ec1b6.var_559503f1.size] = s_spawnpt;
                }
            }
            foreach (s_reward in s_instance.var_4a416ea9.a_s_rewards) {
                if (s_reward.script_int === var_954ec1b6.n_id) {
                    var_954ec1b6.s_reward = s_reward;
                }
            }
            var_954ec1b6.n_total = 0;
            var_954ec1b6.n_kills = 0;
            var_954ec1b6 thread function_c488f3b8(instance);
            var_954ec1b6 thread function_d35b3d1f(instance);
            var_954ec1b6 thread function_a39f5f0(instance);
            var_954ec1b6 thread function_b076be86(instance);
            var_954ec1b6 thread function_5efbdd83(instance);
            var_954ec1b6 thread function_1ee78771(instance);
            var_954ec1b6 thread function_75eea0d2(instance);
            var_954ec1b6 thread function_b70e2a37();
            var_954ec1b6 thread function_7cfc417a(instance);
        }
    }
    instance.var_4a416ea9 = s_instance.var_4a416ea9;
    instance.var_5b071610 = 0;
    instance.var_4fff464f = 0;
    instance.var_f63c851c = 0;
    instance.var_bf189694 = getentarray("drop_pod", "targetname");
    instance thread function_a6619053();
    instance thread function_1d405fe5();
    instance thread function_f5087df2();
    if (isdefined(instance.var_fe2612fe[#"hash_4a44a667578f8f9d"])) {
        instance thread function_338034b3();
    }
    instance.var_4272a188 thread objective_manager::function_98da2ed1(instance.var_4272a188.origin, "objectiveSecureApproach");
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 0, eflags: 0x0
// Checksum 0xe072a822, Offset: 0xdb8
// Size: 0x31e
function function_338034b3() {
    self endon(#"objective_ended");
    self.var_4272a188 triggerenable(0);
    var_1490cdb5 = spawn("trigger_radius_use", self.var_4a416ea9.origin + (0, 0, 24), 0, 96, 96);
    var_1490cdb5 triggerignoreteam();
    var_1490cdb5 setcursorhint("HINT_NOICON");
    var_1490cdb5 sethintstring(#"hash_263f26fcd49be105");
    var_1490cdb5 usetriggerrequirelookat(1);
    s_result = var_1490cdb5 waittill(#"trigger");
    var_1490cdb5 delete();
    objective_setvisibletoall(self.var_e55c8b4e);
    foreach (player in getplayers()) {
        player thread namespace_77bd50da::function_cc8342e0(#"hash_1ec6a694a90d1ad8", 3);
    }
    wait 0.5;
    self.var_2972bc14 rotateyaw(60, 3);
    self.var_2972bc14 waittill(#"rotatedone");
    wait 1.5;
    foreach (player in getplayers()) {
        player thread namespace_77bd50da::function_cc8342e0(#"hash_312b812b4d70edf1", 3);
    }
    wait 5;
    self.var_4272a188 triggerenable(1);
    self.var_4272a188 useby(s_result.activator);
    self notify(#"summon");
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0x34c244aa, Offset: 0x10e0
// Size: 0x22e
function function_c488f3b8(instance) {
    instance endon(#"objective_ended");
    self endon(#"death");
    if (isdefined(instance.var_2972bc14)) {
        instance waittill(#"summon");
    } else {
        instance waittill(#"hash_20dcff0079f189f3");
    }
    self show();
    n_dist = self.origin[2] - self.var_848c555f[2];
    n_time = n_dist / 1500;
    self clientfield::set("" + #"hash_76d1986dfad6a190", 1);
    self moveto(self.var_848c555f + (0, 0, 2400), n_time);
    wait n_time - 0.5;
    self clientfield::set("" + #"hash_76d1986dfad6a190", 3);
    self waittill(#"movedone");
    self moveto(self.var_848c555f, n_time);
    self waittill(#"movedone");
    self function_e44defaa((0, 0, 0));
    self clientfield::set("" + #"hash_76d1986dfad6a190", 2);
    self playrumbleonentity("sr_transmitter_impact");
    wait 1;
    self notify(#"landed");
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0xf50d52ba, Offset: 0x1318
// Size: 0x2ca
function function_75eea0d2(instance) {
    self endon(#"secured", #"death", #"cleared");
    instance endon(#"objective_ended");
    self.var_2c27b95c = 0;
    self waittill(#"ready");
    n_total = self function_37a785fb(0);
    self.var_c5391433 = self function_1172db0d();
    self.var_75833abc = 400;
    self.var_116c0db1 = 0;
    self.var_db94b70a = 0;
    self.var_2493681a = 0;
    self.var_90627599 = 0;
    while (true) {
        self waittill(#"capture");
        self.var_2c27b95c = self.n_kills / self.var_c5391433;
        if (self.var_2c27b95c >= 0.8 && !self.var_90627599) {
            self.var_90627599 = 1;
            namespace_85745671::function_b70e2a37(self);
            wait 0.1;
            self thread function_b5770dda(instance, 2);
        } else if (self.var_2c27b95c >= 0.4 && !self.var_db94b70a) {
            self.var_db94b70a = 1;
            namespace_85745671::function_b70e2a37(self);
            wait 0.1;
            self thread function_b5770dda(instance, 3);
        }
        if (self.var_2c27b95c >= 0.5 && !is_true(self.var_41763f62)) {
            instance notify(#"hash_3167f3403f1172ad");
            self.var_41763f62 = 1;
        }
        if (self.n_total >= n_total || self.n_kills >= self.var_c5391433) {
            if (!is_true(self.var_41763f62)) {
                instance notify(#"hash_3167f3403f1172ad");
            }
            self notify(#"cleared");
        }
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0xd6274ad3, Offset: 0x15f0
// Size: 0x174
function function_a39f5f0(instance) {
    instance endon(#"objective_ended");
    self endon(#"death");
    self waittill(#"ready");
    while (true) {
        self.var_210e22a1 = 0;
        foreach (player in getplayers()) {
            if (distance2dsquared(self.origin, player.origin) <= function_a3f6cdac(2000)) {
                self.var_210e22a1 = 1;
            }
        }
        if (self.var_210e22a1 || is_true(self.b_forced)) {
            self thread function_9761554f(instance);
            break;
        }
        wait 1;
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0xaca07cbe, Offset: 0x1770
// Size: 0x24c
function function_b076be86(instance) {
    instance endon(#"objective_ended");
    self endon(#"death");
    self waittill(#"ready");
    while (true) {
        self.var_210e22a1 = 0;
        foreach (player in getplayers()) {
            if (distance2dsquared(self.origin, player.origin) <= function_a3f6cdac(1000)) {
                self.var_210e22a1 = 1;
            }
        }
        if (self.var_210e22a1 || is_true(self.b_forced)) {
            self thread function_4c664c70(instance);
            self clientfield::set("" + #"hash_771abe419eda7442", 1);
            if (!instance.var_5b071610) {
                instance.var_5b071610 = 1;
                instance thread function_71e7b72b();
            }
            wait 4;
            self.var_48ab101 = util::spawn_model(#"hash_340adc3d8bcc33d2", self.var_c309b891.origin, self.var_c309b891.angles);
            wait 0.1;
            self.var_48ab101 setscale(0.8);
            break;
        }
        wait 1;
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 0, eflags: 0x0
// Checksum 0xf4a6a800, Offset: 0x19c8
// Size: 0x160
function function_1d405fe5() {
    self endon(#"objective_ended");
    self waittill(#"hash_20dcff0079f189f3");
    self thread function_55ea0c81(45);
    var_bf189694 = array::randomize(self.var_bf189694);
    while (true) {
        self waittill(#"hash_3167f3403f1172ad");
        if (!is_true(var_bf189694[0].b_attacked) && !is_true(var_bf189694[0].var_210e22a1)) {
            var_bf189694[0].b_forced = 1;
        } else if (!is_true(var_bf189694[1].b_attacked) && !is_true(var_bf189694[1].var_210e22a1)) {
            var_bf189694[1].b_forced = 1;
        }
        self thread function_55ea0c81(60);
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0x71d85021, Offset: 0x1b30
// Size: 0x6e
function function_55ea0c81(n_time) {
    self notify("31f627b3703fde93");
    self endon("31f627b3703fde93");
    self endon(#"objective_ended", #"hash_3167f3403f1172ad", #"start_attack");
    wait n_time;
    self notify(#"hash_3167f3403f1172ad");
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0x8e527207, Offset: 0x1ba8
// Size: 0xec
function function_9761554f(instance) {
    instance endon(#"objective_ended");
    self.b_attacked = 1;
    for (i = 0; i < 2; i++) {
        ai_zombie = self function_536798ae();
        wait 0.1;
        if (isdefined(ai_zombie)) {
            self.n_active++;
            self.n_total++;
            ai_zombie.var_ce72b8cb = self;
            self thread zombie_death_watcher(instance, ai_zombie);
            ai_zombie thread function_bf606a73();
            namespace_85745671::function_744beb04(ai_zombie);
        }
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 0, eflags: 0x0
// Checksum 0xb9bc090c, Offset: 0x1ca0
// Size: 0x10c
function function_536798ae() {
    self endon(#"death");
    s_pt = array::random(self.var_559503f1);
    if (isdefined(s_pt)) {
        a_s_pts = namespace_85745671::function_e4791424(s_pt.origin, 8, 80, 80);
    }
    if (isdefined(a_s_pts)) {
        s_point = array::random(a_s_pts);
    }
    if (isdefined(s_point)) {
        ai_spawned = namespace_85745671::function_9d3ad056(#"hash_7cba8a05511ceedf", s_point.origin, s_point.angles, "droppod_zombie");
        if (isdefined(ai_spawned)) {
            ai_spawned.b_ignore_cleanup = 1;
            ai_spawned.var_ce72b8cb = self;
            return ai_spawned;
        }
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0x43ee417d, Offset: 0x1db8
// Size: 0x22c
function function_311b330e(instance) {
    instance endon(#"objective_ended");
    n_spawns = int(function_37a785fb(1) * 0.5);
    while (true) {
        self.var_35dfb407 = 0;
        foreach (player in getplayers()) {
            if (distance2dsquared(self.origin, player.origin) <= function_a3f6cdac(3200)) {
                self.var_35dfb407 = 1;
            }
        }
        if (self.var_35dfb407) {
            break;
        }
        wait 0.1;
    }
    for (i = 0; i < n_spawns; i++) {
        ai_zombie = self function_536798ae();
        wait 0.1;
        if (isdefined(ai_zombie)) {
            self.n_active++;
            self thread zombie_death_watcher(instance, ai_zombie);
            ai_zombie.var_ce72b8cb = self;
            ai_zombie.var_3be28c89 = 1;
            ai_zombie callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_fd68cae4);
            ai_zombie thread function_7dbe9585();
        }
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 0, eflags: 0x0
// Checksum 0x4cfc41e1, Offset: 0x1ff0
// Size: 0xb6
function function_7dbe9585() {
    self endon(#"death");
    while (true) {
        if (isdefined(self.var_b238ef38)) {
            self.var_b238ef38 = undefined;
        }
        if (!isdefined(self.favoriteenemy)) {
            player = array::random(getplayers());
            if (isalive(player)) {
                awareness::function_c241ef9a(self, player, 15);
            }
        }
        wait 1;
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0x59c96f8b, Offset: 0x20b0
// Size: 0x1a0
function function_4c664c70(instance) {
    instance endon(#"objective_ended");
    self endon(#"death", #"cleared");
    instance notify(#"start_attack");
    self.b_attacked = 1;
    instance.var_155bbc44 = 0;
    self playsound(#"hash_52a4865a418218f0");
    n_active = self function_53e21154();
    n_total = self function_37a785fb(0);
    while (true) {
        if (self.n_active <= n_active && self.n_total < n_total) {
            ai_zombie = self function_88a7c00a(instance);
            wait 0.1;
            if (isdefined(ai_zombie)) {
                self.n_active++;
                self.n_total++;
                self thread zombie_death_watcher(instance, ai_zombie);
                ai_zombie.var_ce72b8cb = self;
                ai_zombie thread function_bf606a73();
            }
        }
        wait 0.1;
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 2, eflags: 0x0
// Checksum 0x9e0a7a9, Offset: 0x2258
// Size: 0x84
function zombie_death_watcher(instance, ai_zombie) {
    instance endon(#"objective_ended");
    ai_zombie waittill(#"death");
    if (self.n_active) {
        self.n_active--;
    }
    if (ai_zombie.aitype === #"spawner_bo5_avogadro_sr") {
        instance.var_155bbc44--;
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 0, eflags: 0x0
// Checksum 0xac2eccf1, Offset: 0x22e8
// Size: 0x1c0
function function_bf606a73() {
    self endon(#"death");
    if (isdefined(self.var_ce72b8cb)) {
        self.var_ce72b8cb endon(#"death");
    }
    self callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_fd68cae4);
    while (true) {
        a_players = getplayers();
        if (isdefined(self.var_ce72b8cb)) {
            player = array::get_all_closest(self.var_ce72b8cb.origin, a_players)[0];
            namespace_85745671::function_744beb04(self);
            if (isdefined(self.var_ce72b8cb) && !isdefined(self.var_b7e90547) && isalive(self) && !isdefined(self.var_b238ef38) && isalive(player) && distance2dsquared(self.var_ce72b8cb.origin, player.origin) <= function_a3f6cdac(2000)) {
                self.var_b7e90547 = 1;
                awareness::function_c241ef9a(self, player, 15);
            }
        }
        wait 2;
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 0, eflags: 0x0
// Checksum 0x97d66e69, Offset: 0x24b0
// Size: 0x74
function function_fd68cae4() {
    self endon(#"death");
    if (isdefined(self.var_ce72b8cb)) {
        self.var_ce72b8cb endon(#"death");
    }
    if (self.archetype === #"zombie") {
        self namespace_85745671::function_9758722("sprint");
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0x4c38c57d, Offset: 0x2530
// Size: 0x2a8
function function_88a7c00a(instance) {
    self endon(#"death", #"cleared");
    if (level.var_b48509f9 == 1) {
        var_6017f33e = namespace_679a22ba::function_ca209564(#"hash_1c088782dcf5c8ef");
    } else if (level.var_b48509f9 == 2) {
        var_6017f33e = namespace_679a22ba::function_ca209564(#"objective_secure_ailist_2");
    } else {
        var_6017f33e = namespace_679a22ba::function_ca209564(#"objective_secure_ailist_3");
    }
    var_7ecdee63 = var_6017f33e.var_990b33df;
    if (var_7ecdee63 == #"spawner_bo5_avogadro_sr" && instance.var_155bbc44 > 0) {
        if (level.var_b48509f9 >= 3) {
            var_7ecdee63 = #"hash_46c917a1b5ed91e7";
        } else if (level.var_b48509f9 == 2) {
            var_7ecdee63 = #"hash_338eb4103e0ed797";
        } else if (math::cointoss()) {
            var_7ecdee63 = #"hash_7cba8a05511ceedf";
        } else {
            var_7ecdee63 = #"hash_124b582ce08d78c0";
        }
    }
    a_s_pts = namespace_85745671::function_e4791424(array::random(self.var_559503f1).origin, 8, 80, 300);
    if (!isdefined(a_s_pts) || a_s_pts.size === 0) {
        return;
    }
    var_3955def4 = array::random(a_s_pts).origin;
    if (isdefined(var_3955def4)) {
        ai_spawned = namespace_85745671::function_9d3ad056(var_7ecdee63, var_3955def4, self.angles, "droppod_zombie");
    }
    wait 0.1;
    if (isdefined(ai_spawned)) {
        if (ai_spawned.aitype === #"spawner_bo5_avogadro_sr") {
            instance.var_155bbc44++;
        }
        ai_spawned.b_ignore_cleanup = 1;
        return ai_spawned;
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0xf076fb5f, Offset: 0x27e0
// Size: 0x12e
function function_c9277739(a_s_pts) {
    for (i = 0; i < a_s_pts.size; i++) {
        a_s_pts[i].var_7caea647 = 0;
        foreach (player in getplayers()) {
            if (player util::is_player_looking_at(a_s_pts[i].origin, 0.8, 1, player)) {
                a_s_pts[i].var_7caea647 = 1;
            }
        }
        if (!a_s_pts[i].var_7caea647) {
            v_point = a_s_pts[i].origin;
            return v_point;
        }
    }
    return undefined;
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 0, eflags: 0x0
// Checksum 0xb82e8b07, Offset: 0x2918
// Size: 0x9e
function function_1172db0d() {
    switch (getplayers().size) {
    case 1:
        n_kills = 16;
        break;
    case 2:
        n_kills = 20;
        break;
    case 3:
        n_kills = 24;
        break;
    case 4:
        n_kills = 32;
        break;
    }
    return n_kills;
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 0, eflags: 0x0
// Checksum 0xf1913d80, Offset: 0x29c0
// Size: 0x9e
function function_53e21154() {
    switch (getplayers().size) {
    case 1:
        n_spawns = 7;
        break;
    case 2:
        n_spawns = 12;
        break;
    case 3:
        n_spawns = 15;
        break;
    case 4:
        n_spawns = 20;
        break;
    }
    return n_spawns;
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0xdac3a62a, Offset: 0x2a68
// Size: 0x10e
function function_37a785fb(b_active) {
    self endon(#"death");
    switch (getplayers().size) {
    case 1:
        if (b_active) {
            n_spawns = 6;
        } else {
            n_spawns = 48;
        }
        break;
    case 2:
        if (b_active) {
            n_spawns = 10;
        } else {
            n_spawns = 60;
        }
        break;
    case 3:
        if (b_active) {
            n_spawns = 14;
        } else {
            n_spawns = 72;
        }
        break;
    case 4:
        if (b_active) {
            n_spawns = 18;
        } else {
            n_spawns = 96;
        }
        break;
    }
    return n_spawns;
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 0, eflags: 0x0
// Checksum 0x42d3031b, Offset: 0x2b80
// Size: 0xc8
function function_a6619053() {
    self endon(#"objective_ended");
    self waittill(#"hash_20dcff0079f189f3");
    while (true) {
        if (self.var_f63c851c == 2) {
            level thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog, "objectiveSecureEndSuccess");
            level thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog, "objectiveSecureEndSuccessResponse");
            objective_manager::objective_ended(self);
        }
        wait 0.5;
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0x2929a50, Offset: 0x2c50
// Size: 0x57c
function function_5efbdd83(instance) {
    self endon(#"death");
    self waittill(#"landed");
    self thread function_311b330e(instance);
    self thread function_b5770dda(instance, 4);
    self disconnectpaths();
    self.mdl_fx = util::spawn_model("tag_origin", self.origin + (0, 0, 152));
    wait 0.1;
    instance.var_344a6a1a[instance.var_344a6a1a.size] = self.mdl_fx;
    self.is_active = 1;
    self.mdl_fx clientfield::set("" + #"hash_38e22f5ceb9065c", 1);
    self notify(#"ready");
    self.mdl_fx clientfield::set("" + #"hash_38e22f5ceb9065c", 0);
    self waittill(#"cleared");
    self.var_abe43927 = 1;
    self.mdl_fx clientfield::set("" + #"hash_582f769d593e00e0", 1);
    self clientfield::set("" + #"hash_3eeee7f3f5bdb9ff", 1);
    wait 0.1;
    self.var_fcd0c6d7 = 1;
    if (!isdefined(self.var_fcd0c6d7)) {
        self thread function_311b330e();
    }
    namespace_85745671::function_b70e2a37(self);
    self playrumblelooponentity("sr_payload_portal_rumble");
    if (isdefined(self.var_48ab101)) {
        self thread function_cf89aec();
    }
    self.mdl_fx moveto(self.origin, 3);
    self.mdl_fx waittill(#"movedone");
    self stoprumble("sr_payload_portal_rumble");
    wait 0.1;
    self playrumbleonentity("sr_transmitter_clear");
    self clientfield::increment("" + #"hash_502be00d1af105e9");
    self.mdl_fx clientfield::set("" + #"hash_38e22f5ceb9065c", 3);
    waitframe(1);
    self function_c6f443c5();
    wait 1;
    self.mdl_fx delete();
    instance.var_f63c851c++;
    if (instance.var_f63c851c > 1 && !instance.var_4fff464f) {
        instance.var_4fff464f = 1;
        namespace_cda50904::function_a92a93e9(self.s_reward.origin, self.s_reward.angles);
        level thread namespace_7589cf5c::function_3899cfea(self.origin, 5000);
    }
    foreach (player in getplayers()) {
        if (isdefined(player.var_1948045d[self.n_id])) {
            player.var_1948045d[self.n_id] thread luielembar::set_color(player, 1, 1, 1);
        }
    }
    wait 1.5;
    var_88f24b00 = util::spawn_model(#"hash_8b8c98dda08574e", self.origin + (0, 0, 37));
    if (isdefined(var_88f24b00)) {
        self thread function_3dce2703(var_88f24b00);
        instance.var_344a6a1a[instance.var_344a6a1a.size] = var_88f24b00;
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 0, eflags: 0x0
// Checksum 0xdfa3e2eb, Offset: 0x31d8
// Size: 0xd4
function function_cf89aec() {
    self endon(#"death");
    self.var_48ab101 endon(#"death");
    n_scale = 0.75;
    while (true) {
        self.var_48ab101 setscale(n_scale);
        self.var_48ab101 movez(2, 0.05);
        n_scale -= 0.01;
        if (n_scale <= 0.1) {
            break;
        }
        wait 0.05;
    }
    self.var_48ab101 delete();
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 0, eflags: 0x0
// Checksum 0x7b87eb03, Offset: 0x32b8
// Size: 0x140
function function_71e7b72b() {
    foreach (player in getplayers()) {
        player thread namespace_77bd50da::function_cc8342e0(#"hash_763038398b0e6b59", 4);
    }
    wait 4.5;
    foreach (player in getplayers()) {
        player thread namespace_77bd50da::function_cc8342e0(#"hash_113ad5247404dc08", 3);
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0xbb9fbfcd, Offset: 0x3400
// Size: 0x154
function function_3dce2703(var_88f24b00) {
    self endon(#"death");
    var_88f24b00.var_3aee78d5 = spawn("trigger_radius_use", var_88f24b00.origin, 0, 80, 80);
    var_88f24b00.var_3aee78d5 triggerignoreteam();
    var_88f24b00.var_3aee78d5 setcursorhint("HINT_NOICON");
    var_88f24b00.var_3aee78d5 sethintstring(#"hash_1f4dfe99a27799dd");
    var_88f24b00.var_3aee78d5 usetriggerrequirelookat(1);
    s_result = var_88f24b00.var_3aee78d5 waittill(#"trigger");
    s_result.activator thread zm_score::add_to_player_score(250);
    var_88f24b00.var_3aee78d5 delete();
    var_88f24b00 delete();
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 2, eflags: 0x0
// Checksum 0xdf6e1d15, Offset: 0x3560
// Size: 0xd8
function function_b5770dda(instance, var_c2323ea4) {
    instance endon(#"objective_ended");
    slots = namespace_85745671::function_bdb2b85b(self, self.origin + (0, 0, 16), self.angles, 48, var_c2323ea4, 16);
    if (!isdefined(slots) || slots.size <= 0) {
        return;
    }
    self.var_b79a8ac7 = {#var_f019ea1a:2000, #slots:slots};
    level.attackables[level.attackables.size] = self;
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0x681e9f26, Offset: 0x3640
// Size: 0xdc
function function_d35b3d1f(instance) {
    instance endon(#"objective_ended");
    self waittill(#"landed");
    self.n_objective_id = gameobjects::get_next_obj_id();
    self.var_805ed574 = function_c607df95(instance);
    objective_add(self.n_objective_id, "active", self.origin + (0, 0, 162), self.var_805ed574);
    self waittill(#"cleared");
    objective_setinvisibletoall(self.n_objective_id);
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0x51e1bd49, Offset: 0x3728
// Size: 0x7e
function function_c607df95(*instance) {
    switch (self.n_id) {
    case 0:
        var_805ed574 = #"hash_123b41efdf89a905";
        break;
    case 1:
        var_805ed574 = #"hash_123b3eefdf89a3ec";
        break;
    }
    return var_805ed574;
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 0, eflags: 0x0
// Checksum 0x39d7a56d, Offset: 0x37b0
// Size: 0xac
function function_b70e2a37() {
    self waittill(#"death", #"destroyed", #"secured");
    if (isdefined(self.mdl_gameobject)) {
        self.mdl_gameobject gameobjects::destroy_object(1, 1);
    }
    if (isdefined(self.n_objective_id)) {
        objective_delete(self.n_objective_id);
    }
    namespace_85745671::function_b70e2a37(self);
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0x90dd7049, Offset: 0x3868
// Size: 0xb4
function function_7cfc417a(instance) {
    instance waittill(#"objective_ended");
    namespace_85745671::function_b70e2a37(self);
    if (!instance.success) {
        self notify(#"destroyed");
        self thread function_84ccd16c();
        return;
    }
    self notify(#"secured");
    if (isdefined(self.var_48ab101)) {
        self.var_48ab101 delete();
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 0, eflags: 0x0
// Checksum 0x46b78a39, Offset: 0x3928
// Size: 0x108
function function_f5087df2() {
    self waittill(#"objective_ended");
    callback::remove_callback(&on_ai_killed);
    foreach (player in getplayers()) {
        level.var_31028c5d prototype_hud::function_817e4d10(player, 0);
        level.var_31028c5d prototype_hud::function_da4fba84(player, 0);
    }
    level notify(#"secure_end");
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 0, eflags: 0x0
// Checksum 0xcfdb96eb, Offset: 0x3a38
// Size: 0xe4
function function_84ccd16c() {
    self clientfield::set("" + #"hash_74d70bb7fe52c00", 1);
    self playrumbleonentity("sr_prototype_generator_explosion");
    self playsound(#"hash_877884cc0c69c6");
    wait 0.1;
    if (isdefined(self.mdl_fx)) {
        self.mdl_fx delete();
    }
    if (isdefined(self.var_48ab101)) {
        self.var_48ab101 delete();
    }
    self delete();
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0xe66be3c0, Offset: 0x3b28
// Size: 0x53c
function function_1ee78771(instance) {
    instance endon(#"objective_ended");
    self endon(#"secured");
    self val::set("drop", "takedamage", 0);
    self waittill(#"landed");
    self val::reset("drop", "takedamage");
    self.is_damaged = 0;
    switch (getplayers().size) {
    case 1:
        self.health = 4000;
        break;
    case 2:
        self.health = 3800;
        break;
    case 3:
        self.health = 3500;
        break;
    case 4:
        self.health = 3000;
        break;
    }
    n_start_health = self.health;
    switch (self.n_id) {
    case 0:
        objective_manager::function_91574ec1(level.var_8e86256f, 91, 420, undefined, "secure_end", 1, 0);
        break;
    case 1:
        objective_manager::function_91574ec1(level.var_478e1780, 91, 450, undefined, "secure_end", 1, 1);
        break;
    }
    objective_manager::function_5d1c184(1, self.n_id);
    self val::set("droppod", "takedamage", 1);
    while (true) {
        s_result = self waittill(#"damage");
        if (isdefined(s_result.attacker) && isplayer(s_result.attacker)) {
            if (isdefined(s_result.amount)) {
                self.health += s_result.amount;
            }
        } else {
            self playsound(#"hash_52e02ca86c5fa117");
            if (!self.is_damaged) {
                self thread function_814c0e69(instance);
            }
            if (s_result.mod === "MOD_PROJECTILE_SPLASH") {
                if (isdefined(s_result.amount)) {
                    self dodamage(s_result.amount * 3, self.origin);
                }
            }
        }
        var_c3a3ae13 = self.health / n_start_health;
        if (var_c3a3ae13 <= 0.5 && !is_true(level.var_f869b7f6)) {
            level.var_f869b7f6 = 1;
            array::thread_all(function_a1ef346b(), &globallogic_audio::play_taacom_dialog, "objectiveSecureHalfHealth");
        }
        if (var_c3a3ae13 <= 0.2 && !is_true(level.var_9cc5ee3f)) {
            level.var_9cc5ee3f = 1;
            array::thread_all(function_a1ef346b(), &globallogic_audio::play_taacom_dialog, "objectiveSecureCritical");
        }
        if (var_c3a3ae13 < 0) {
            var_c3a3ae13 = 0;
        }
        self clientfield::increment("" + #"hash_18bcf106c476dfeb");
        objective_manager::function_5d1c184(var_c3a3ae13, self.n_id);
        self function_f8b793c9(var_c3a3ae13);
        if (self.health <= 1) {
            break;
        }
    }
    self notify(#"destroyed");
    instance notify(#"destroyed");
    objective_manager::objective_ended(instance, 0);
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0x45100fa0, Offset: 0x4070
// Size: 0x9e
function function_814c0e69(instance) {
    instance endon(#"objective_ended");
    self endon(#"death");
    n_inc = 0;
    self.is_damaged = 1;
    while (n_inc < 3) {
        self playsound(#"hash_2847596f1017cb69");
        wait 0.5;
        n_inc++;
    }
    wait 0.5;
    self.is_damaged = 0;
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 3, eflags: 0x0
// Checksum 0x79a5ccb9, Offset: 0x4118
// Size: 0x340
function function_2857fbd9(instance, droppod, var_c3a3ae13) {
    instance endon(#"objective_ended");
    level endon(#"game_ended");
    foreach (player in getplayers()) {
        if (isplayer(player) && isdefined(droppod.n_id) && isdefined(player.var_1948045d) && isdefined(player.var_1948045d[droppod.n_id])) {
            if (is_true(droppod.var_38ae4622)) {
                player.var_1948045d[droppod.n_id] luielembar::set_color(player, 1, 1, 1);
                continue;
            }
            player.var_1948045d[droppod.n_id] luielembar::set_color(player, 1, 0, 0);
        }
    }
    wait 0.1;
    foreach (player in getplayers()) {
        if (isplayer(player) && isdefined(droppod.n_id) && isdefined(player.var_1948045d) && isdefined(player.var_1948045d[droppod.n_id])) {
            if (var_c3a3ae13 <= 0.66 && var_c3a3ae13 > 0.33) {
                player.var_1948045d[droppod.n_id] luielembar::set_color(player, 1, 1, 0);
                continue;
            }
            if (var_c3a3ae13 <= 0.33) {
                player.var_1948045d[droppod.n_id] luielembar::set_color(player, 1, 0, 0);
                continue;
            }
            player.var_1948045d[droppod.n_id] luielembar::set_color(player, 0, 1, 0);
        }
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0xf400687f, Offset: 0x4460
// Size: 0x17e
function function_f8b793c9(var_c3a3ae13) {
    foreach (player in getplayers()) {
        if (var_c3a3ae13 <= 0.66 && var_c3a3ae13 > 0.33 && !is_true(self.var_b2ad28ef)) {
            player.var_1948045d[self.n_id] luielembar::set_color(player, 1, 1, 0);
            self.var_b2ad28ef = 1;
            continue;
        }
        if (var_c3a3ae13 <= 0.33 && !is_true(self.var_38ae4622)) {
            player.var_1948045d[self.n_id] luielembar::set_color(player, 1, 0, 0);
            self.var_38ae4622 = 1;
        }
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 2, eflags: 0x0
// Checksum 0x5468636d, Offset: 0x45e8
// Size: 0x308
function function_fb9dff2f(instance, activator) {
    if (isplayer(activator)) {
        instance notify(#"hash_20dcff0079f189f3");
        activator thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog_on_player, "objectiveSecureStart");
        level thread util::delay(2.5, undefined, &globallogic_audio::leader_dialog, "objectiveSecureStartResponse");
        callback::on_ai_killed(&on_ai_killed);
        foreach (player in getplayers()) {
            level.var_31028c5d prototype_hud::function_7491d6c5(player, #"hash_691ec119979cba95");
        }
        wait 6;
        foreach (player in getplayers()) {
            level.var_31028c5d prototype_hud::set_active_objective_string(player, #"hash_691ec119979cba95");
            level.var_31028c5d prototype_hud::function_817e4d10(player, 2);
            level.var_31028c5d prototype_hud::function_da4fba84(player, 1);
        }
        while (true) {
            if (is_true(instance.var_5b071610)) {
                break;
            }
            wait 1;
        }
        foreach (player in getplayers()) {
            level.var_31028c5d prototype_hud::set_active_objective_string(player, #"hash_1201ff20897597a2");
        }
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0x9c167602, Offset: 0x48f8
// Size: 0x1d0
function on_ai_killed(params) {
    if (isplayer(params.eattacker) && (self.aitype === #"spawner_bo5_avogadro_sr" || self.archetype === #"zombie")) {
        var_bf189694 = getentarray("drop_pod", "targetname");
        var_954ec1b6 = array::get_all_closest(self.origin, var_bf189694)[0];
        if (isdefined(self) && isdefined(var_954ec1b6) && isdefined(var_954ec1b6.var_48ab101) && !is_true(var_954ec1b6.var_fcd0c6d7) && distance2dsquared(self.origin, var_954ec1b6.origin) <= function_a3f6cdac(var_954ec1b6.var_75833abc) && is_true(var_954ec1b6.is_active) && !is_true(var_954ec1b6.var_abe43927)) {
            var_954ec1b6.n_kills++;
            self clientfield::set("" + #"hash_5342c00e940ad12b", 1);
            wait 1;
            if (isdefined(var_954ec1b6)) {
                var_954ec1b6 notify(#"capture");
            }
        }
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0xbe9e8c02, Offset: 0x4ad0
// Size: 0x32e
function function_b769e108(instance) {
    instance endon(#"objective_ended");
    self endon(#"death");
    a_zombies = function_a38db454(self.origin, 1000);
    foreach (zombie in a_zombies) {
        if (zombie.archetype === #"zombie") {
            zombie.knockdown = 1;
            zombie.knockdown_type = "knockdown_shoved";
            var_7d6a995e = self.origin - zombie.origin;
            var_1040735c = vectornormalize((var_7d6a995e[0], var_7d6a995e[1], 0));
            zombie_forward = anglestoforward(zombie.angles);
            zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
            zombie_right = anglestoright(zombie.angles);
            zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
            dot = vectordot(var_1040735c, zombie_forward_2d);
            if (dot >= 0.5) {
                zombie.knockdown_direction = "front";
                zombie.getup_direction = "getup_back";
                continue;
            }
            if (dot < 0.5 && dot > -0.5) {
                dot = vectordot(var_1040735c, zombie_right_2d);
                if (dot > 0) {
                    zombie.knockdown_direction = "right";
                    if (math::cointoss()) {
                        zombie.getup_direction = "getup_back";
                    } else {
                        zombie.getup_direction = "getup_belly";
                    }
                } else {
                    zombie.knockdown_direction = "left";
                    zombie.getup_direction = "getup_belly";
                }
                continue;
            }
            zombie.knockdown_direction = "back";
            zombie.getup_direction = "getup_belly";
        }
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 0, eflags: 0x0
// Checksum 0xce2eda80, Offset: 0x4e08
// Size: 0xd8
function function_c6f443c5() {
    self endon(#"death");
    a_zombies = function_a38db454(self.origin, 2500);
    foreach (zombie in a_zombies) {
        if (isalive(zombie)) {
            self thread function_912eedf3(zombie);
        }
    }
}

// Namespace namespace_24fd6413/namespace_24fd6413
// Params 1, eflags: 0x0
// Checksum 0xef413aec, Offset: 0x4ee8
// Size: 0x164
function function_912eedf3(zombie) {
    self endon(#"death");
    zombie endon(#"death");
    if (zombie.archetype === #"zombie" && isdefined(zombie) && !is_true(zombie.var_a950813d)) {
        v_forward = vectornormalize(anglestoforward(zombie.origin - self.origin));
        v_launch = v_forward * randomintrange(250, 350) + (0, 0, 450);
        zombie.allowdeath = 1;
        if (!zombie isragdoll()) {
            zombie startragdoll();
            waitframe(2);
            zombie launchragdoll(v_launch);
        }
        zombie kill();
    }
}

