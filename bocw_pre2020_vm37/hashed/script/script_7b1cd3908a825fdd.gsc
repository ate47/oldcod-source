#using script_1029986e2bc8ca8e;
#using script_113dd7f0ea2a1d4f;
#using script_1cc417743d7c262d;
#using script_27347f09888ad15;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_355c6e84a79530cb;
#using script_7fc996fe8678852;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\zm_common\zm_utility;

#namespace namespace_591b4396;

// Namespace namespace_591b4396/level_init
// Params 1, eflags: 0x40
// Checksum 0x3f7ab1ab, Offset: 0x298
// Size: 0x4c
function event_handler[level_init] main(*eventstruct) {
    objective_manager::function_b3464a7c(#"exfil", undefined, &exfil_start, #"exfil");
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 1, eflags: 0x1 linked
// Checksum 0xb8fe8f9f, Offset: 0x2f0
// Size: 0x27c
function exfil_start(instance) {
    if (isdefined(level.var_fdcaf3a6)) {
        return;
    }
    level.var_fdcaf3a6 = instance;
    level flag::wait_till(#"gameplay_started");
    level callback::callback(#"on_exfil_start");
    /#
        if (getdvarint(#"hash_33b0be96bf3cd69a", 0)) {
            level flag::wait_till(#"hash_7ace2c0d668c5128");
            level thread namespace_73df937d::function_de302547(level.var_7d45d0d4.currentdestination);
            level flag::clear(#"objective_locked");
            level waittill(#"hash_581a9d913f67821a");
            level flag::set(#"objective_locked");
        }
    #/
    level thread globallogic_audio::leader_dialog("objectiveExfilStart");
    level thread globallogic_audio::leader_dialog("objectiveExfilStartResponse");
    var_28bf3706 = instance.var_fe2612fe[#"heli_spawn"][0];
    do {
        waitframe(1);
        level.var_117d5f10 = vehicle::spawn(undefined, "exfil_heli", "vehicle_t8_mil_helicopter_light_gunner_wz", var_28bf3706.origin, var_28bf3706.angles);
    } while (!isdefined(level.var_117d5f10));
    var_3ec7083c = instance.var_fe2612fe[#"hash_216188a7e7b381a6"][0];
    level thread function_839b3d5a(var_3ec7083c);
    level thread function_17f88f7c(var_3ec7083c);
    level.var_117d5f10 thread function_c70a47c(var_3ec7083c);
    level thread function_31125f54();
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 1, eflags: 0x1 linked
// Checksum 0x6444a860, Offset: 0x578
// Size: 0x6bc
function function_c70a47c(var_3ec7083c) {
    instance = var_3ec7083c.parent;
    if (is_true(instance.var_93408d43)) {
        self.var_ff373d73 = array(2, 1, 5);
    } else {
        self.var_ff373d73 = array(1, 2, 5);
    }
    self val::set("exfil_heli", "takedamage", 0);
    self makevehicleusable();
    self setrotorspeed(1);
    self setseatoccupied(0, 1);
    self vehicle::get_on_and_go_path(function_60c104b6(instance, "heli_spawn"));
    objective_setposition(level.var_fdcaf3a6.var_e55c8b4e, self.origin + (0, 0, -48));
    objective_onentity(level.var_fdcaf3a6.var_e55c8b4e, self);
    if (getplayers().size > 1 || getdvarint(#"hash_33b0be96bf3cd69a", 0)) {
        level thread function_1913632();
    }
    level flag::wait_till(#"hash_3babb5bf72d208da");
    foreach (player in getplayers()) {
        level thread function_c4908232(player);
    }
    level flag::wait_till_any(array(#"hash_1442cccc0c2806d6", #"exfil_cleared"));
    if (!level flag::get(#"exfil_cleared")) {
        self vehicle::get_off_path();
        self thread vehicle::get_on_and_go_path(function_60c104b6(instance, "exfil_circle_path_start"));
        level flag::wait_till(#"exfil_cleared");
    }
    if (level flag::get(#"hash_1f7daee81549103")) {
        return;
    }
    self vehicle::get_off_path();
    var_41dec230 = util::spawn_model("tag_origin", self.origin, self.angles);
    if (isdefined(self.var_11f5ad9d)) {
        self.var_11f5ad9d hide();
    }
    if (isdefined(level.var_fdcaf3a6.trigger)) {
        level.var_fdcaf3a6.trigger delete();
    }
    self unlink();
    self enablelinkto();
    self linkto(var_41dec230);
    var_41dec230 moveto(var_3ec7083c.origin + (0, 0, 400), 4);
    wait 4;
    if (!level flag::get(#"hash_1f7daee81549103")) {
        var_41dec230 moveto(var_3ec7083c.origin, 4);
        var_41dec230 rotateto(var_3ec7083c.angles, 4);
        wait 4;
        level flag::set(#"hash_3831052f822d12ed");
        self disconnectpaths(0, 0);
        level.var_fdcaf3a6.trigger = namespace_8b6a9d79::function_214737c7(var_3ec7083c, &function_39f35c4e, #"hash_611e948769ca0bdf", undefined, 256);
        level.var_fdcaf3a6.trigger usetriggerrequirelookat(0);
        level flag::wait_till(#"hash_1f7daee81549103");
    }
    self makevehicleunusable();
    var_68fb6e1d = self.origin + (randomintrange(-1000, 1000), randomintrange(-1000, 1000), 5000);
    var_41dec230 moveto(var_68fb6e1d, 65);
    var_41dec230 rotateto((0, 0, 0), 5);
    var_41dec230 waittill(#"rotatedone");
    var_41dec230 rotate((0, -5, 0));
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 2, eflags: 0x1 linked
// Checksum 0xf8536a8, Offset: 0xc40
// Size: 0x62
function function_60c104b6(instance, var_eece1f6a) {
    var_ec14921 = instance.var_fe2612fe[var_eece1f6a][0].targetname;
    node = getvehiclenode(var_ec14921, "target");
    return node;
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 0, eflags: 0x1 linked
// Checksum 0xdd5bfae4, Offset: 0xcb0
// Size: 0x1ac
function function_1913632() {
    level endon(#"exfil_cleared");
    wait 1.5;
    var_b89ccc9f = (18, 0, -100);
    var_11f5ad9d = util::spawn_model(#"hash_28e9c0bf37df2c68", level.var_117d5f10.origin + var_b89ccc9f);
    var_11f5ad9d linkto(level.var_117d5f10);
    level.var_117d5f10.var_11f5ad9d = var_11f5ad9d;
    s_interact = spawnstruct();
    var_4adc70ee = (18, 0, -385);
    s_interact.origin = level.var_117d5f10.origin + var_4adc70ee;
    level.var_fdcaf3a6.trigger = namespace_8b6a9d79::function_214737c7(s_interact, &function_39f35c4e, #"hash_611e948769ca0bdf", undefined, 128);
    level.var_fdcaf3a6.trigger enablelinkto();
    level.var_fdcaf3a6.trigger linkto(level.var_117d5f10);
    level.var_b290ca72 = &function_d236f851;
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 1, eflags: 0x1 linked
// Checksum 0xa98a9f86, Offset: 0xe68
// Size: 0x58
function function_d236f851(*player) {
    if (isdefined(level.var_fdcaf3a6.trigger) && self istouching(level.var_fdcaf3a6.trigger)) {
        return false;
    }
    return true;
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 1, eflags: 0x1 linked
// Checksum 0x65664555, Offset: 0xec8
// Size: 0x214
function function_39f35c4e(eventstruct) {
    var_3a8b4ddf = eventstruct.activator;
    if (!isdefined(var_3a8b4ddf) || is_true(var_3a8b4ddf.var_2c27f919)) {
        return;
    }
    foreach (n_seat in level.var_117d5f10.var_ff373d73) {
        if (!isdefined(level.var_117d5f10 getseatoccupant(n_seat))) {
            level.var_117d5f10 usevehicle(var_3a8b4ddf, n_seat);
            b_in_vehicle = 1;
            break;
        }
    }
    if (!is_true(b_in_vehicle)) {
        var_3a8b4ddf playerlinktodelta(level.var_117d5f10, "tag_ground", 1);
    }
    level flag::set(#"hash_1442cccc0c2806d6");
    if (isdefined(level.var_117d5f10.var_11f5ad9d)) {
        level.var_117d5f10.var_11f5ad9d hide();
    }
    if (!level flag::get(#"hash_3831052f822d12ed")) {
        level.var_fdcaf3a6.trigger triggerenable(0);
    }
    var_3a8b4ddf function_9e79b1b7();
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 1, eflags: 0x1 linked
// Checksum 0xc2a5bb80, Offset: 0x10e8
// Size: 0xa8
function function_c4908232(player) {
    while (isdefined(level.var_117d5f10)) {
        s_result = player waittill(#"enter_vehicle", #"death", #"spawned_player");
        vehicle = s_result.vehicle;
        if (vehicle === level.var_117d5f10) {
            player function_9e79b1b7();
        }
    }
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 0, eflags: 0x1 linked
// Checksum 0x87aeaa89, Offset: 0x1198
// Size: 0x1c0
function function_9e79b1b7() {
    objective_setinvisibletoplayer(level.var_fdcaf3a6.var_e55c8b4e, self);
    level.var_31028c5d prototype_hud::function_817e4d10(self, 0);
    self.var_2c27f919 = 1;
    self val::set(#"hash_4086023ba6ea23e2", "ignoreme", 1);
    self thread function_2bfabc96();
    foreach (player in function_a1ef346b()) {
        if (!is_true(player.var_2c27f919)) {
            return;
        }
    }
    level thread objective_manager::stop_timer();
    level flag::set(#"hash_1f7daee81549103");
    /#
        if (getdvarint(#"hash_33b0be96bf3cd69a", 0)) {
            iprintlnbold("<dev string:x38>");
            return;
        }
    #/
    level notify(#"hash_4fbe4720f6f13107");
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 0, eflags: 0x1 linked
// Checksum 0xb1bc8cff, Offset: 0x1360
// Size: 0xd4
function function_2bfabc96() {
    self notify("1639b1d5274b2198");
    self endon("1639b1d5274b2198");
    self endoncallback(&function_36b0b6ae, #"death");
    while (isdefined(level.var_117d5f10)) {
        s_result = level.var_117d5f10 waittill(#"exit_vehicle");
        if (s_result.player === self) {
            self val::reset(#"hash_4086023ba6ea23e2", "ignoreme");
            self function_36b0b6ae();
            break;
        }
    }
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 1, eflags: 0x1 linked
// Checksum 0xcedcf7eb, Offset: 0x1440
// Size: 0x74
function function_36b0b6ae(*notifyhash) {
    if (isplayer(self)) {
        self.var_2c27f919 = 0;
        objective_setvisibletoplayer(level.var_fdcaf3a6.var_e55c8b4e, self);
        level.var_31028c5d prototype_hud::function_817e4d10(self, 2);
    }
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 1, eflags: 0x1 linked
// Checksum 0xd0b7a128, Offset: 0x14c0
// Size: 0x388
function function_839b3d5a(var_48236d2c) {
    level endon(#"objective_ended");
    foreach (player in getplayers()) {
        level.var_31028c5d prototype_hud::function_7491d6c5(player, #"hash_2138b0d3ea594968");
    }
    wait 5;
    foreach (player in getplayers()) {
        level.var_31028c5d prototype_hud::set_active_objective_string(player, #"hash_2138b0d3ea594968");
        level.var_31028c5d prototype_hud::function_817e4d10(player, 2);
    }
    n_time = function_385ab693(var_48236d2c.origin);
    level thread objective_manager::start_timer(n_time, "exfil");
    level thread function_c504b2d1();
    level thread function_8fcb0a(n_time);
    if (!isdefined(var_48236d2c.radius)) {
        var_48236d2c.radius = 2000;
    }
    if (!isdefined(var_48236d2c.height)) {
        var_48236d2c.height = 500;
    }
    var_48236d2c.radius = int(var_48236d2c.radius);
    var_48236d2c.height = int(var_48236d2c.height);
    var_4cdbc624 = spawn("trigger_radius", var_48236d2c.origin - (0, 0, var_48236d2c.height), 0, var_48236d2c.radius, var_48236d2c.height * 2);
    var_4cdbc624 waittill(#"trigger");
    level flag::set(#"hash_3babb5bf72d208da");
    foreach (player in getplayers()) {
        player thread function_bf33dd82(var_4cdbc624);
    }
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 1, eflags: 0x1 linked
// Checksum 0x295af55e, Offset: 0x1850
// Size: 0x16c
function function_bf33dd82(var_4cdbc624) {
    self endon(#"death");
    v_train_inbound_igc = 0;
    while (!level flag::get(#"exfil_cleared")) {
        if (is_true(self.var_2c27f919) || !v_train_inbound_igc && self istouching(var_4cdbc624)) {
            level.var_31028c5d prototype_hud::set_active_objective_string(self, #"hash_18a40982c5569db2");
            v_train_inbound_igc = 1;
        } else if (v_train_inbound_igc && !self istouching(var_4cdbc624)) {
            level.var_31028c5d prototype_hud::set_active_objective_string(self, #"hash_2138b0d3ea594968");
            v_train_inbound_igc = 0;
        }
        wait 1;
    }
    objective_setvisibletoplayer(level.var_fdcaf3a6.var_e55c8b4e, self);
    level.var_31028c5d prototype_hud::set_active_objective_string(self, #"hash_1ea76eb37bb646db");
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 1, eflags: 0x1 linked
// Checksum 0xe7b9c056, Offset: 0x19c8
// Size: 0x7c
function function_8fcb0a(n_time) {
    level endon(#"objective_ended", #"hash_158779eefe4893d1", #"hash_4fbe4720f6f13107", #"hash_1f7daee81549103");
    wait n_time * 0.67;
    level thread globallogic_audio::leader_dialog("objectiveExfilTimeNag");
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 1, eflags: 0x1 linked
// Checksum 0x67f5c146, Offset: 0x1a50
// Size: 0x1b2
function function_385ab693(var_fda8dff8) {
    if (isdefined(level.var_7d45d0d4.var_c4181ea)) {
        v_start = level.var_7d45d0d4.var_c4181ea.origin;
    } else {
        v_start = (0, 0, 0);
        a_players = function_a1ef346b();
        foreach (player in a_players) {
            v_start += player.origin;
        }
        v_start /= a_players.size;
    }
    n_dist = distance2d(var_fda8dff8, v_start);
    var_6b68b20f = n_dist / 10000;
    if (isdefined(level.var_aaf7505f)) {
        var_5dc3d377 = level.var_aaf7505f;
    } else {
        var_5dc3d377 = max(var_6b68b20f * 60, 60) + 60;
    }
    return int(min(540, var_5dc3d377));
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 0, eflags: 0x1 linked
// Checksum 0x74609cd9, Offset: 0x1c10
// Size: 0xa0
function function_c504b2d1() {
    level endon(#"objective_ended", #"hash_1f7daee81549103");
    level waittill(#"hash_158779eefe4893d1");
    if (level flag::get(#"exfil_cleared")) {
        level flag::wait_till(#"hash_3831052f822d12ed");
        wait 10;
    }
    level notify(#"hash_4fbe4720f6f13107");
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 0, eflags: 0x1 linked
// Checksum 0x22a0892b, Offset: 0x1cb8
// Size: 0x254
function function_31125f54() {
    level waittill(#"hash_4fbe4720f6f13107");
    objective_setinvisibletoall(level.var_fdcaf3a6.var_e55c8b4e);
    level flag::set(#"hash_1f7daee81549103");
    wait 3;
    level.var_117d5f10 makevehicleunusable();
    if (isdefined(level.var_fdcaf3a6.trigger)) {
        level.var_fdcaf3a6.trigger delete();
    }
    b_success = 0;
    foreach (player in function_a1ef346b()) {
        if (is_true(player.var_2c27f919)) {
            b_success = 1;
            player val::set("exfil", "takedamage", 0);
            player val::set("exfil", "allowdeath", 0);
            continue;
        }
        var_cd126a25 = 1;
    }
    if (is_true(var_cd126a25) && is_true(b_success)) {
        level globallogic_audio::leader_dialog("matchEndPartialWin");
    } else {
        level globallogic_audio::leader_dialog("matchEndPerfectWin");
    }
    objective_manager::objective_ended(level.var_fdcaf3a6, b_success);
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 1, eflags: 0x1 linked
// Checksum 0x704d747e, Offset: 0x1f18
// Size: 0x454
function function_17f88f7c(var_68cc0f1f) {
    level endon(#"objective_ended");
    level thread function_5ddbfe57(var_68cc0f1f);
    var_fda8dff8 = var_68cc0f1f.origin;
    var_b538af19 = isdefined(level.var_fdcaf3a6.var_fe2612fe[#"hash_1f59ed48456964e4"]) ? level.var_fdcaf3a6.var_fe2612fe[#"hash_1f59ed48456964e4"] : [];
    foreach (spawn in var_b538af19) {
        level thread function_4b115eba(spawn);
    }
    var_ca838126 = zm_utility::is_classic() ? level.zombie_ai_limit : getailimit();
    while (true) {
        if (level flag::get(#"hash_58df1e8b20eb71d2") && !level flag::get(#"hash_47ded767d48dfe83")) {
            function_9feae843(var_fda8dff8);
            level flag::set(#"hash_47ded767d48dfe83");
        }
        a_players = function_a1ef346b();
        var_62455b3e = min(var_ca838126 / a_players.size + 1, var_ca838126 / 3);
        foreach (player in a_players) {
            if (is_true(player.var_652c0aa1) || player laststand::player_is_in_laststand()) {
                continue;
            }
            n_dist = distancesquared(var_fda8dff8, player.origin);
            if (function_a3f6cdac(3000) > n_dist) {
                v_spawn = var_fda8dff8;
            } else {
                var_b8af022a = function_411bb920(player);
                v_dir = vectornormalize(var_fda8dff8 - player.origin + var_b8af022a);
                v_spawn = player.origin + v_dir * 3000;
            }
            /#
                if (getdvarint(#"hash_33b0be96bf3cd69a", 0)) {
                    cylinder(v_spawn, v_spawn + (0, 0, 5000), 500, (1, 0, 0), 0, 10000);
                }
            #/
            player thread function_64df57fc(v_spawn, var_62455b3e);
        }
        level waittilltimeout(10, #"hash_3babb5bf72d208da", #"hash_58df1e8b20eb71d2");
    }
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 1, eflags: 0x1 linked
// Checksum 0x2f4dcc6, Offset: 0x2378
// Size: 0x8c
function function_411bb920(player) {
    if (player isinvehicle()) {
        velocity = player getvehicleoccupied() getvelocity();
        var_1f25c893 = 2;
    } else {
        velocity = player getvelocity();
        var_1f25c893 = 7;
    }
    return velocity * var_1f25c893;
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 1, eflags: 0x1 linked
// Checksum 0xe7447943, Offset: 0x2410
// Size: 0x19e
function function_5ddbfe57(var_68cc0f1f) {
    var_a789c878 = level.var_fdcaf3a6.var_fe2612fe[#"hash_4c80dd6ba453f9f9"][0];
    if (isdefined(var_a789c878)) {
        n_radius = int(var_a789c878.radius);
        n_height = int(var_a789c878.height);
        v_origin = var_a789c878.origin;
    } else {
        n_radius = 4000;
        n_height = 2000;
        v_origin = var_68cc0f1f.origin - (0, 0, n_height / 2);
    }
    var_196e22fd = spawn("trigger_radius", v_origin, 0, n_radius, n_height);
    while (!level flag::get(#"exfil_cleared")) {
        s_result = var_196e22fd waittill(#"trigger");
        level flag::set(#"hash_58df1e8b20eb71d2");
        if (isplayer(s_result.activator)) {
            s_result.activator.var_652c0aa1 = 1;
        }
    }
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 2, eflags: 0x1 linked
// Checksum 0xd7428ed6, Offset: 0x25b8
// Size: 0x39e
function function_64df57fc(v_spawn, var_ca838126) {
    self notify("30a54880eac1129d");
    self endon("30a54880eac1129d");
    self endon(#"death");
    level endon(#"exfil_cleared");
    n_z_offset = 0;
    if (isdefined(self.var_36462255)) {
        function_1eaaceab(self.var_36462255);
        foreach (ai in self.var_36462255) {
            ai.var_921627ad = 0;
        }
    }
    if (abs(v_spawn[2] - self.origin[2]) > 512) {
        n_z_offset += abs(v_spawn[2] - self.origin[2]);
    }
    self.var_36462255 = [];
    var_2eb61c8a = array::randomize(namespace_85745671::function_e4791424(v_spawn, var_ca838126, 512 + n_z_offset, 1024));
    n_ai_count = 0;
    i = 0;
    str_bundle = "default_zombies_realm_" + level.realm;
    if (isdefined(level.var_7f72eddd)) {
        str_bundle = level.var_7f72eddd;
    }
    while (var_2eb61c8a.size && n_ai_count < var_ca838126) {
        waitframe(randomintrange(5, 10));
        v_angles = vectortoangles(self.origin - v_spawn);
        var_4bf95f4c = namespace_679a22ba::function_ca209564(str_bundle);
        if (!isdefined(var_4bf95f4c)) {
            break;
        }
        ai = namespace_85745671::function_9d3ad056(var_4bf95f4c.var_990b33df, var_2eb61c8a[i].origin, (0, v_angles[1], 0), "exfil_ai");
        if (isalive(ai)) {
            n_ai_count++;
            ai.var_921627ad = 0;
            ai thread awareness::function_c241ef9a(ai, self, 10);
            if (!isdefined(self.var_36462255)) {
                self.var_36462255 = [];
            } else if (!isarray(self.var_36462255)) {
                self.var_36462255 = array(self.var_36462255);
            }
            self.var_36462255[self.var_36462255.size] = ai;
        }
        i++;
        if (i >= var_2eb61c8a.size) {
            i = 0;
        }
    }
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 1, eflags: 0x1 linked
// Checksum 0x951cb320, Offset: 0x2960
// Size: 0x418
function function_4b115eba(struct) {
    if (!isdefined(struct.radius)) {
        struct.radius = 1024;
    }
    if (!isdefined(struct.height)) {
        struct.height = 256;
    }
    if (!isdefined(struct.var_9b178666)) {
        struct.var_9b178666 = 256;
    }
    if (!isdefined(struct.var_48d0f926)) {
        struct.var_48d0f926 = 64;
    }
    struct.radius = int(struct.radius);
    struct.height = int(struct.height);
    struct.var_9b178666 = int(struct.var_9b178666);
    struct.var_48d0f926 = int(struct.var_48d0f926);
    trigger = spawn("trigger_radius", struct.origin - (0, 0, struct.height), 0, struct.radius, struct.height * 2);
    s_result = trigger waittill(#"trigger");
    trigger delete();
    str_bundle = "default_zombies_realm_" + level.realm;
    if (isdefined(level.var_7f72eddd)) {
        str_bundle = level.var_7f72eddd;
    }
    n_ai_count = 0;
    i = 0;
    var_a77909d4 = randomintrangeinclusive(4, 6);
    if (isplayer(s_result.activator)) {
        v_angles = vectortoangles(s_result.activator.origin - struct.origin);
    } else {
        v_angles = struct.angles;
    }
    a_v_points = array::randomize(namespace_85745671::function_e4791424(struct.origin, var_a77909d4, struct.var_48d0f926, struct.var_9b178666));
    while (n_ai_count < var_a77909d4 && a_v_points.size) {
        var_4bf95f4c = namespace_679a22ba::function_ca209564(str_bundle);
        if (!isdefined(var_4bf95f4c)) {
            break;
        }
        ai = namespace_85745671::function_9d3ad056(var_4bf95f4c.var_990b33df, a_v_points[i].origin, (0, v_angles[1], 0), "exfil_ai");
        if (isdefined(ai)) {
            n_ai_count++;
            if (isalive(s_result.activator)) {
                target = s_result.activator;
            } else {
                target = arraysortclosest(function_a1ef346b(), a_v_points[i], 1)[0];
            }
            if (isdefined(target)) {
                ai thread awareness::function_c241ef9a(ai, target, 10);
            }
        }
        i++;
        if (i >= a_v_points.size) {
            i = 0;
        }
        waitframe(randomintrange(5, 10));
    }
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 1, eflags: 0x1 linked
// Checksum 0x4b1c7f69, Offset: 0x2d80
// Size: 0x344
function function_9feae843(var_fda8dff8) {
    str_bundle = "exfil_realm_" + level.realm;
    if (isdefined(level.var_7f72eddd)) {
        str_bundle = level.var_7f72eddd;
    }
    var_6443acc = namespace_679a22ba::function_77be8a83(str_bundle);
    var_a77909d4 = 0;
    foreach (spawn_list in var_6443acc.var_7c88c117) {
        var_a77909d4 += spawn_list.var_cffbc08;
    }
    n_ai_count = 0;
    var_4ebe6ac0 = 0;
    b_force_spawn = 0;
    a_v_points = array::randomize(namespace_85745671::function_e4791424(var_fda8dff8, var_a77909d4, 256, 512));
    i = 0;
    while (n_ai_count < var_a77909d4 && a_v_points.size) {
        var_4bf95f4c = namespace_679a22ba::function_ca209564(str_bundle, var_6443acc);
        if (!isdefined(var_4bf95f4c)) {
            break;
        }
        ai = namespace_85745671::function_9d3ad056(var_4bf95f4c.var_990b33df, a_v_points[i].origin, (0, randomint(360), 0), "exfil_ai", b_force_spawn);
        if (isdefined(ai)) {
            namespace_679a22ba::function_266ee075(var_4bf95f4c.list_name, var_6443acc);
            n_ai_count++;
            var_4ebe6ac0 = 0;
            b_force_spawn = 0;
            if (n_ai_count >= var_a77909d4) {
                break;
            }
        } else {
            var_4ebe6ac0++;
            if (var_4ebe6ac0 > 10 && n_ai_count < var_a77909d4 / 2) {
                b_force_spawn = 1;
            }
        }
        i++;
        if (i >= a_v_points.size) {
            i = 0;
        }
        waitframe(randomintrange(2, 5));
    }
    var_d4245663 = spawn("trigger_radius", var_fda8dff8 - (0, 0, 256 / 2), 512 | 1, 512 + 1024, 256);
    level util::delay(5, undefined, &function_6cbcd4dd, var_d4245663);
}

// Namespace namespace_591b4396/namespace_591b4396
// Params 1, eflags: 0x1 linked
// Checksum 0x3961bfa3, Offset: 0x30d0
// Size: 0x9c
function function_6cbcd4dd(var_d4245663) {
    do {
        wait 1;
        var_c7597757 = getaiarray("exfil_ai", "targetname");
        function_1eaaceab(var_c7597757);
    } while (array::get_touching(var_c7597757, var_d4245663).size > 4);
    level flag::set(#"exfil_cleared");
}

