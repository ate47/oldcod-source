#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_net;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_weap_blundergat;

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 0, eflags: 0x2
// Checksum 0xcddc1b04, Offset: 0x310
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_weap_blundergat", &__init__, &__main__, undefined);
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 0, eflags: 0x0
// Checksum 0x908a5430, Offset: 0x360
// Size: 0x28c
function __init__() {
    clientfield::register("missile", "blundergat_dart_blink", 1, 1, "int");
    clientfield::register("scriptmover", "blundergat_dart_blink", 1, 1, "int");
    clientfield::register("scriptmover", "magma_gat_blob_fx", 1, 2, "int");
    clientfield::register("actor", "zombie_magma_fire_explosion", 1, 1, "int");
    n_bits = getminbitcountfornum(6);
    clientfield::register("actor", "positional_zombie_fire_fx", 1, n_bits, "int");
    zm::register_zombie_damage_override_callback(&function_96ab90ae);
    callback::on_connect(&function_dfebd47);
    level flag::init(#"hash_72c4671390c83158");
    level flag::init(#"hash_634424410f574c1c");
    weaponobjects::function_f298eae6(#"ww_blundergat_fire_t8_unfinished", &function_2f1f17, 0);
    weaponobjects::function_f298eae6(#"ww_blundergat_fire_t8", &function_2f1f17, 0);
    weaponobjects::function_f298eae6(#"ww_blundergat_fire_t8_upgraded", &function_2f1f17, 0);
    zm_utility::register_slowdown(#"hash_716657b9842cfd1b", 0.6, 1);
    level.var_d0093016 = new throttle();
    [[ level.var_d0093016 ]]->initialize(6, 0.1);
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 0, eflags: 0x0
// Checksum 0x36498b57, Offset: 0x5f8
// Size: 0x34
function __main__() {
    level.var_6333b411 = [];
    level.var_36fc5032 = [];
    level thread function_6cdd25e();
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 1, eflags: 0x0
// Checksum 0x42c32b85, Offset: 0x638
// Size: 0x94
function function_2b9dcd1d(n_spread) {
    n_x = randomintrange(n_spread * -1, n_spread);
    n_y = randomintrange(n_spread * -1, n_spread);
    n_z = randomintrange(n_spread * -1, n_spread);
    return (n_x, n_y, n_z);
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 0, eflags: 0x0
// Checksum 0xf1436250, Offset: 0x6d8
// Size: 0x36
function function_e59a0efb() {
    self endon(#"death");
    self.titusmarked = 1;
    wait 1;
    self.titusmarked = undefined;
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 2, eflags: 0x0
// Checksum 0x91a62618, Offset: 0x718
// Size: 0x134
function function_14c87511(n_fuse_timer, attacker) {
    self endon(#"death", #"titus_target_timeout");
    self thread titus_target_timeout(n_fuse_timer);
    if (self.var_29ed62b2 == #"miniboss" || self.var_29ed62b2 == #"boss") {
        wait n_fuse_timer;
        self.var_df54b6e = undefined;
        return;
    }
    self thread function_cfcfb8f0(attacker);
    self ai::stun(n_fuse_timer);
    wait n_fuse_timer;
    self notify(#"hash_1c822785c3e778b5", {#attacker:attacker});
    self dodamage(self.health + 1000, self.origin, attacker, attacker, "none", "MOD_GRENADE");
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 0, eflags: 0x0
// Checksum 0xe5c3f7f6, Offset: 0x858
// Size: 0x19c
function function_9c29192f() {
    self endon(#"death", #"titus_target_timeout");
    while (true) {
        s_result = self waittill(#"damage");
        if (s_result.weapon === getweapon(#"hash_3de0926b89369160") || s_result.weapon === getweapon(#"hash_127bb24f68b5df27")) {
            a_grenades = getentarray("grenade", "classname");
            foreach (e_grenade in a_grenades) {
                if (isdefined(e_grenade.model) && e_grenade.model == #"wpn_t8_zm_blundergat_acid_projectile") {
                    if (e_grenade islinkedto(self)) {
                        e_grenade thread function_44b97d7d(self);
                    }
                }
            }
        }
    }
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 1, eflags: 0x0
// Checksum 0xeae6f2db, Offset: 0xa00
// Size: 0x36
function titus_target_timeout(n_fuse_timer) {
    self endon(#"death");
    wait n_fuse_timer;
    self notify(#"titus_target_timeout");
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 1, eflags: 0x0
// Checksum 0x7caad792, Offset: 0xa40
// Size: 0x4e
function function_cfcfb8f0(attacker) {
    self waittill(#"death");
    self notify(#"hash_1c822785c3e778b5", {#attacker:attacker});
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 1, eflags: 0x0
// Checksum 0x6e33c94e, Offset: 0xa98
// Size: 0xb4
function function_44b97d7d(target) {
    self endon(#"death");
    target endon(#"titus_target_timeout");
    target waittill(#"hash_1c822785c3e778b5");
    if (self clientfield::get("blundergat_dart_blink")) {
        self clientfield::set("blundergat_dart_blink", 0);
    }
    self.var_2c1849cb = 1;
    self resetmissiledetonationtime(0.05);
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 13, eflags: 0x0
// Checksum 0x49430301, Offset: 0xb58
// Size: 0x64e
function function_96ab90ae(willbekilled, einflictor, eattacker, idamage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    var_4761b070 = getweapon(#"hash_3de0926b89369160");
    var_c61beac3 = getweapon(#"hash_494f5501b3f8e1e9");
    if (weapon === var_4761b070) {
        if (!(isdefined(self.var_df54b6e) && self.var_df54b6e)) {
            a_grenades = getentarray("grenade", "classname");
            self.var_df54b6e = 1;
            foreach (e_grenade in a_grenades) {
                if (isdefined(e_grenade) && isdefined(e_grenade.model) && e_grenade.model == #"wpn_t8_zm_blundergat_acid_projectile") {
                    if (e_grenade islinkedto(self)) {
                        while (isdefined(e_grenade)) {
                            if (!isdefined(e_grenade.n_fuse_time)) {
                                waitframe(1);
                                continue;
                            }
                            break;
                        }
                        if (isdefined(e_grenade)) {
                            n_fuse_timer = e_grenade.n_fuse_time;
                            e_grenade thread function_44b97d7d(self);
                        }
                    }
                }
            }
            if (!isdefined(n_fuse_timer)) {
                n_fuse_timer = randomfloatrange(1, 1.5);
            }
            self thread function_14c87511(n_fuse_timer, eattacker);
            self thread function_9c29192f();
        }
        return idamage;
    } else if (weapon === var_c61beac3) {
        if (self.var_29ed62b2 == #"miniboss" || self.var_29ed62b2 == #"boss") {
            return (idamage * 0.1);
        }
        return idamage;
    }
    w_blundergat_fire = getweapon(#"ww_blundergat_fire_t8");
    w_blundergat_fire_upgraded = getweapon(#"ww_blundergat_fire_t8_upgraded");
    var_5daa1d9a = getweapon(#"ww_blundergat_fire_t8_unfinished");
    if (weapon == w_blundergat_fire || weapon == w_blundergat_fire_upgraded || weapon == var_5daa1d9a) {
        if (self.var_29ed62b2 == #"basic" || self.var_29ed62b2 == #"popcorn") {
            if (meansofdeath == "MOD_IMPACT") {
                self thread function_832c103(shitloc, vpoint, eattacker, weapon);
                return 0;
            } else if (isdefined(self.var_d8ede258) || isdefined(self.var_c8d5356) && self.var_c8d5356) {
                if (isdefined(willbekilled) && willbekilled) {
                    self thread function_1e3f3174(eattacker);
                    if (isdefined(level.no_gib_in_wolf_area) && isdefined(self [[ level.no_gib_in_wolf_area ]]()) && self [[ level.no_gib_in_wolf_area ]]()) {
                        self.no_gib = 1;
                    }
                    if (!(isdefined(self.no_gib) && self.no_gib)) {
                        gibserverutils::annihilate(self);
                    }
                    self clientfield::set("zombie_magma_fire_explosion", 1);
                }
            }
        } else if (self.var_29ed62b2 == #"miniboss" || self.var_29ed62b2 == #"boss") {
            if (meansofdeath == "MOD_IMPACT") {
                self thread function_832c103(shitloc, vpoint, eattacker, weapon);
                return 0;
            }
        }
        return idamage;
    }
    w_blundergat = getweapon(#"ww_blundergat_t8");
    w_blundergat_upgraded = getweapon(#"ww_blundergat_t8_upgraded");
    if (weapon == w_blundergat || weapon == w_blundergat_upgraded) {
        if (self.var_29ed62b2 == #"basic") {
            if (isdefined(level.no_gib_in_wolf_area) && [[ level.no_gib_in_wolf_area ]]()) {
                return idamage;
            }
            self zombie_utility::derive_damage_refs(vpoint);
        }
        return idamage;
    }
    return idamage;
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 0, eflags: 0x4
// Checksum 0x8464afdd, Offset: 0x11b0
// Size: 0x13a
function private function_dfebd47() {
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill(#"weapon_change");
        wpn_cur = waitresult.weapon;
        wpn_prev = waitresult.last_weapon;
        if (wpn_cur == getweapon(#"ww_blundergat_acid_t8") || wpn_cur == getweapon(#"ww_blundergat_acid_t8_upgraded")) {
            self thread function_e617596();
            continue;
        }
        if (wpn_prev == getweapon(#"ww_blundergat_acid_t8") || wpn_prev == getweapon(#"ww_blundergat_acid_t8_upgraded")) {
            self notify(#"hash_20e403096a8af3b7");
        }
    }
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 0, eflags: 0x4
// Checksum 0x96c94e0a, Offset: 0x12f8
// Size: 0x140
function private function_e617596() {
    self notify(#"hash_20e403096a8af3b7");
    self endon(#"disconnect", #"hash_20e403096a8af3b7");
    while (true) {
        s_result = self waittill(#"weapon_fired");
        if (s_result.weapon == getweapon(#"ww_blundergat_acid_t8") || s_result.weapon == getweapon(#"ww_blundergat_acid_t8_upgraded")) {
            util::wait_network_frame();
            function_62252f73(1);
            util::wait_network_frame();
            function_62252f73(1);
            util::wait_network_frame();
            function_62252f73(1);
        }
        wait 0.5;
    }
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 1, eflags: 0x0
// Checksum 0x1d6e68d7, Offset: 0x1440
// Size: 0x52c
function function_62252f73(is_not_upgraded = 1) {
    var_1319fcbb = self getplayerangles();
    var_e1b84d95 = self getplayercamerapos();
    a_ai_targets = getaiteamarray(level.zombie_team);
    a_vh_targets = getvehicleteamarray(level.zombie_team);
    a_targets = arraycombine(a_ai_targets, a_vh_targets, 0, 0);
    a_targets = util::get_array_of_closest(self.origin, a_targets, undefined, undefined, 1500);
    if (is_not_upgraded) {
        n_fuse_timer = randomfloatrange(1, 2.5);
    } else {
        n_fuse_timer = randomfloatrange(3, 4);
    }
    foreach (target in a_targets) {
        if (util::within_fov(var_e1b84d95, var_1319fcbb, target.origin, cos(30))) {
            if (isai(target)) {
                if (!isdefined(target.titusmarked)) {
                    a_tags = [];
                    if (target.archetype == #"zombie_dog") {
                        a_tags[0] = "j_hip_le";
                        a_tags[1] = "j_hip_ri";
                        a_tags[2] = "j_spine4";
                        a_tags[3] = "j_neck";
                        a_tags[4] = "j_shoulder_le";
                        a_tags[5] = "j_shoulder_ri";
                    } else {
                        a_tags[0] = "j_hip_le";
                        a_tags[1] = "j_hip_ri";
                        a_tags[2] = "j_spine4";
                        a_tags[3] = "j_elbow_le";
                        a_tags[4] = "j_elbow_ri";
                        a_tags[5] = "j_clavicle_le";
                        a_tags[6] = "j_clavicle_ri";
                    }
                    str_tag = a_tags[randomint(a_tags.size)];
                    b_trace_pass = bullettracepassed(var_e1b84d95, target gettagorigin(str_tag), 1, self, target);
                    if (b_trace_pass) {
                        target thread function_e59a0efb();
                        e_dart = magicbullet(getweapon(#"hash_3de0926b89369160"), var_e1b84d95, target gettagorigin(str_tag), self);
                        e_dart thread function_26bba129(n_fuse_timer, is_not_upgraded, target);
                        return;
                    }
                }
            }
        }
    }
    vec = anglestoforward(var_1319fcbb);
    trace_end = var_e1b84d95 + vec * 20000;
    trace = bullettrace(var_e1b84d95, trace_end, 1, self);
    var_9b4b1855 = trace[#"position"] + function_2b9dcd1d(55);
    e_dart = magicbullet(getweapon(#"hash_3de0926b89369160"), var_e1b84d95, var_9b4b1855, self);
    e_dart thread function_26bba129(n_fuse_timer);
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 4, eflags: 0x0
// Checksum 0xc612ceb7, Offset: 0x1978
// Size: 0x212
function function_26bba129(n_fuse_timer = randomfloatrange(1, 1.5), is_not_upgraded = 1, ai_target, var_2114ce6d = 1) {
    s_result = self waittill(#"death");
    a_grenades = getentarray("grenade", "classname");
    foreach (e_grenade in a_grenades) {
        if (isdefined(e_grenade.model) && !(isdefined(e_grenade.var_2c1849cb) && e_grenade.var_2c1849cb) && e_grenade.model == #"wpn_t8_zm_blundergat_acid_projectile") {
            e_grenade clientfield::set("blundergat_dart_blink", 1);
            e_grenade.var_2c1849cb = 1;
            e_grenade.n_fuse_time = n_fuse_timer;
            e_grenade resetmissiledetonationtime(n_fuse_timer);
            e_grenade thread wait_for_grenade_explode(n_fuse_timer, ai_target, s_result.attacker);
            if (var_2114ce6d) {
                e_grenade thread function_10238dcb(e_grenade.owner);
            }
            return;
        }
    }
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 3, eflags: 0x0
// Checksum 0xf1f2a37f, Offset: 0x1b98
// Size: 0x1fc
function wait_for_grenade_explode(n_fuse_timer, ai_target, e_attacker) {
    util::waittill_any_ents(self, "death", ai_target, #"titus_target_timeout", ai_target, "death");
    if (isdefined(ai_target)) {
        if (isdefined(self.weapon)) {
            w_grenade = self.weapon;
        } else {
            w_grenade = undefined;
        }
        if (ai_target.var_29ed62b2 == #"miniboss" || ai_target.var_29ed62b2 == #"boss") {
            ai_target dodamage(ai_target.maxhealth * 0.1, ai_target.origin, e_attacker, e_attacker, "none", "MOD_GRENADE", 0, w_grenade);
            return;
        }
        if (isdefined(level.no_gib_in_wolf_area) && isdefined(ai_target [[ level.no_gib_in_wolf_area ]]()) && ai_target [[ level.no_gib_in_wolf_area ]]()) {
            ai_target.no_gib = 1;
        }
        if (!(isdefined(ai_target.no_gib) && ai_target.no_gib)) {
            gibserverutils::annihilate(ai_target);
        }
        ai_target dodamage(ai_target.health + 1000, ai_target.origin, e_attacker, e_attacker, "none", "MOD_GRENADE", 0, w_grenade);
    }
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 1, eflags: 0x0
// Checksum 0x9e115863, Offset: 0x1da0
// Size: 0x126
function function_2f1f17(watcher) {
    watcher.onspawn = &function_211a55bd;
    watcher.watchforfire = 1;
    watcher.hackable = 0;
    watcher.activatefx = 1;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.immediatedetonation = 1;
    watcher.detectiongraceperiod = 0;
    watcher.detonateradius = 64;
    watcher.onstun = &weaponobjects::weaponstun;
    watcher.stuntime = 0;
    watcher.activationdelay = 1;
    watcher.activatesound = #"wpn_gelgun_blob_burst";
    watcher.deleteonplayerspawn = 1;
    watcher.timeout = 5;
    watcher.ignorevehicles = 0;
    watcher.ignoreai = 0;
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 2, eflags: 0x0
// Checksum 0x789bd709, Offset: 0x1ed0
// Size: 0x3fc
function function_211a55bd(watcher, owner) {
    self endon(#"death");
    a_ai_zombies = getaiteamarray(level.zombie_team);
    foreach (ai_zombie in a_ai_zombies) {
        ai_zombie thread function_aedb5cf5(self);
    }
    s_result = self waittilltimeout(5, #"stationary", #"hash_14fd7b6a20ac8f44");
    waitframe(1);
    if (isplayer(s_result.target)) {
        v_pos = groundtrace(self.origin + (0, 0, 32) + (0, 0, 8), self.origin + (0, 0, 32) + (0, 0, -100000), 0, self)[#"position"];
        if (isdefined(v_pos)) {
            self ghost();
            mdl_magma = util::spawn_model(self.model, v_pos, s_result.target.angles);
        } else {
            mdl_magma = util::spawn_model(self.model, s_result.target.origin, s_result.target.angles);
        }
    } else {
        mdl_magma = util::spawn_model(self.model, self.origin, self.angles);
    }
    mdl_magma.owner = owner;
    a_ai_zombies = array::remove_undefined(a_ai_zombies, 0);
    foreach (ai_zombie in a_ai_zombies) {
        if (ai_zombie.var_d8ede258 === self) {
            if (ai_zombie.archetype == "zombie_dog") {
                str_tag = "j_spine1";
            } else {
                str_tag = ai_zombie get_closest_tag(self.origin);
            }
            mdl_magma clientfield::set("magma_gat_blob_fx", 2);
            mdl_magma linkto(ai_zombie, str_tag);
            ai_zombie.var_c8d5356 = 1;
            ai_zombie thread function_244dabd(mdl_magma);
            self delete();
            return;
        }
    }
    mdl_magma clientfield::set("magma_gat_blob_fx", 1);
    self thread function_4356a340(mdl_magma, owner);
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 2, eflags: 0x4
// Checksum 0xde6c2e57, Offset: 0x22d8
// Size: 0x1ac
function private function_4356a340(mdl_magma, owner) {
    self delete();
    if (!isdefined(level.var_36fc5032)) {
        level.var_36fc5032 = [];
    } else if (!isarray(level.var_36fc5032)) {
        level.var_36fc5032 = array(level.var_36fc5032);
    }
    if (!isinarray(level.var_36fc5032, mdl_magma)) {
        level.var_36fc5032[level.var_36fc5032.size] = mdl_magma;
    }
    if (level.var_36fc5032.size > 3) {
        level.var_36fc5032[0] notify(#"hash_39da21c99d3cf743");
    }
    mdl_magma.trigger = spawn("trigger_radius_new", mdl_magma.origin, (512 | 1) + 2, 64, 64);
    mdl_magma thread function_4a73b137();
    mdl_magma thread function_10238dcb(owner);
    mdl_magma waittilltimeout(5, #"hash_39da21c99d3cf743");
    if (isdefined(mdl_magma)) {
        mdl_magma function_d72dfe21();
    }
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 1, eflags: 0x4
// Checksum 0x279b3b6d, Offset: 0x2490
// Size: 0x2dc
function private function_10238dcb(e_player) {
    if (isdefined(e_player)) {
        w_current = e_player getcurrentweapon();
    }
    v_point = getclosestpointonnavmesh(self.origin, 128, 16);
    if (!isdefined(v_point)) {
        return;
    }
    if (distance(self.origin, v_point) > 64) {
        return;
    }
    var_efb97c9e = spawn("script_origin", v_point);
    if (!(isdefined(var_efb97c9e zm_utility::in_playable_area()) && var_efb97c9e zm_utility::in_playable_area())) {
        var_efb97c9e delete();
        return;
    }
    if (isdefined(w_current) && (w_current === getweapon(#"ww_blundergat_fire_t8_upgraded") || w_current === getweapon(#"ww_blundergat_acid_t8_upgraded"))) {
        var_efb97c9e zm_utility::create_zombie_point_of_interest(256, 8, 10000);
        var_efb97c9e zm_utility::create_zombie_point_of_interest_attractor_positions(undefined, undefined, 128);
    } else {
        var_efb97c9e zm_utility::create_zombie_point_of_interest(128, 4, 10000);
        var_efb97c9e zm_utility::create_zombie_point_of_interest_attractor_positions(undefined, undefined, 128);
    }
    a_ai_zombies = getaiteamarray(level.zombie_team);
    foreach (ai_zombie in a_ai_zombies) {
        if (ai_zombie.var_29ed62b2 == #"miniboss" || ai_zombie.var_29ed62b2 == #"boss") {
            ai_zombie thread zm_utility::add_poi_to_ignore_list(var_efb97c9e);
        }
    }
    self waittill(#"death");
    var_efb97c9e delete();
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 1, eflags: 0x4
// Checksum 0xac3b2cf1, Offset: 0x2778
// Size: 0x90
function private function_aedb5cf5(e_grenade) {
    self endon(#"death");
    e_grenade endon(#"death");
    s_result = self waittilltimeout(5, #"grenade_stuck");
    if (s_result.projectile === e_grenade) {
        self.var_d8ede258 = e_grenade;
        e_grenade notify(#"hash_14fd7b6a20ac8f44");
    }
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 1, eflags: 0x4
// Checksum 0xba25b3fd, Offset: 0x2810
// Size: 0xec
function private function_244dabd(mdl_magma) {
    mdl_magma endon(#"death");
    if (self.var_29ed62b2 == #"basic" || self.var_29ed62b2 == #"popcorn") {
        self waittill(#"death");
    } else if (self.var_29ed62b2 == #"miniboss" || self.var_29ed62b2 == #"boss") {
        self waittilltimeout(5, #"death");
        self notify(#"hash_556bad125b55e1a9");
    }
    mdl_magma function_d72dfe21();
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 0, eflags: 0x4
// Checksum 0x78bb3e, Offset: 0x2908
// Size: 0x230
function private function_4a73b137() {
    self endon(#"death");
    self.trigger endon(#"death");
    while (true) {
        s_result = self.trigger waittill(#"trigger");
        if (isdefined(s_result.activator)) {
            if (isplayer(s_result.activator) && s_result.activator == self.owner) {
                s_result.activator thread function_c110f52e(self.trigger);
                continue;
            }
            if (isinarray(getaiteamarray(level.zombie_team), s_result.activator)) {
                if (s_result.activator.var_29ed62b2 == #"popcorn" && !(isdefined(s_result.activator.is_on_fire) && s_result.activator.is_on_fire)) {
                    s_result.activator dodamage(s_result.activator.health + 100, self.origin, self.owner, self.owner, undefined, "MOD_BURNED", 0, undefined);
                    continue;
                }
                if (!(isdefined(s_result.activator.is_on_fire) && s_result.activator.is_on_fire)) {
                    s_result.activator thread function_4c6a96b(self.owner, self.origin, s_result.activator.health * 0.1);
                }
            }
        }
    }
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 0, eflags: 0x4
// Checksum 0x2d32f7b6, Offset: 0x2b40
// Size: 0xcc
function private function_d72dfe21() {
    if (self clientfield::get("magma_gat_blob_fx")) {
        self clientfield::set("magma_gat_blob_fx", 0);
    }
    if (isinarray(level.var_36fc5032, self)) {
        arrayremovevalue(level.var_36fc5032, self);
    }
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 1, eflags: 0x4
// Checksum 0x934ce699, Offset: 0x2c18
// Size: 0x192
function private get_closest_tag(v_pos) {
    if (!isdefined(level.gib_tags)) {
        zombie_utility::init_gib_tags();
    }
    tag_closest = undefined;
    var_9c149efb = arraycopy(level.gib_tags);
    if (!isdefined(var_9c149efb)) {
        var_9c149efb = [];
    } else if (!isarray(var_9c149efb)) {
        var_9c149efb = array(var_9c149efb);
    }
    if (!isinarray(var_9c149efb, "j_head")) {
        var_9c149efb[var_9c149efb.size] = "j_head";
    }
    for (i = 0; i < var_9c149efb.size; i++) {
        if (!isdefined(tag_closest)) {
            tag_closest = var_9c149efb[i];
            continue;
        }
        if (distancesquared(v_pos, self gettagorigin(var_9c149efb[i])) < distancesquared(v_pos, self gettagorigin(tag_closest))) {
            tag_closest = var_9c149efb[i];
        }
    }
    return tolower(tag_closest);
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 1, eflags: 0x4
// Checksum 0xf3d1d64d, Offset: 0x2db8
// Size: 0xda
function private function_c110f52e(t_damage) {
    self endon(#"disconnect");
    if (isdefined(self.var_4686a3a) && self.var_4686a3a) {
        return;
    }
    self.var_4686a3a = 1;
    while (isdefined(t_damage) && self istouching(t_damage)) {
        self dodamage(1, t_damage.origin, undefined, undefined, "torso_lower", "MOD_BURNED");
        self playrumbleonentity("damage_light");
        wait 0.4;
    }
    self.var_4686a3a = undefined;
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 1, eflags: 0x4
// Checksum 0xbc07d795, Offset: 0x2ea0
// Size: 0x170
function private function_1e3f3174(eattacker) {
    v_pos = self.origin;
    var_97e81f4 = self getcentroid();
    a_ai_zombies = getaiteamarray(level.zombie_team);
    a_ai_targets = array::get_all_closest(v_pos, a_ai_zombies, self, undefined, 128);
    foreach (ai_target in a_ai_targets) {
        if (!isdefined(ai_target) || ai_target === self) {
            continue;
        }
        if (ai_target.var_29ed62b2 === #"basic") {
            ai_target thread function_1f61ea79(eattacker, var_97e81f4);
            continue;
        }
        ai_target thread function_4c6a96b(eattacker, var_97e81f4, 20);
    }
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 2, eflags: 0x0
// Checksum 0xa4e5eaf, Offset: 0x3018
// Size: 0x114
function function_1f61ea79(eattacker, var_97e81f4) {
    [[ level.var_d0093016 ]]->waitinqueue(self);
    if (isdefined(level.no_gib_in_wolf_area) && isdefined(self [[ level.no_gib_in_wolf_area ]]()) && self [[ level.no_gib_in_wolf_area ]]()) {
        var_64acd675 = 1;
    }
    if (!(isdefined(self.no_gib) && self.no_gib) || isdefined(var_64acd675) && var_64acd675) {
        self zombie_utility::gib_random_parts();
    }
    self thread function_4c6a96b(eattacker, var_97e81f4);
    self dodamage(400, var_97e81f4, eattacker, eattacker, "torso_lower", "MOD_EXPLOSIVE");
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 4, eflags: 0x4
// Checksum 0x999e6a70, Offset: 0x3138
// Size: 0x24c
function private function_832c103(shitloc, vpoint, eattacker, weapon) {
    self endon(#"death");
    wait 0.5;
    if (self.var_29ed62b2 == #"miniboss" || self.var_29ed62b2 == #"boss") {
        self thread function_4c6a96b(eattacker, vpoint, 100);
        self thread function_e57e2edf(eattacker);
        return;
    }
    if (self.var_29ed62b2 == #"popcorn") {
        self thread function_1e3f3174(eattacker);
        self dodamage(self.health + 100, vpoint, eattacker, eattacker, shitloc, "MOD_BURNED", 0, weapon);
        return;
    }
    if (self.health <= 1000) {
        if (isdefined(level.no_gib_in_wolf_area) && isdefined(self [[ level.no_gib_in_wolf_area ]]()) && self [[ level.no_gib_in_wolf_area ]]()) {
            self.no_gib = 1;
        }
        if (!(isdefined(self.no_gib) && self.no_gib)) {
            gibserverutils::annihilate(self);
        }
        self clientfield::set("zombie_magma_fire_explosion", 1);
        self dodamage(self.health + 100, vpoint, eattacker, eattacker, shitloc, "MOD_BURNED", 0, weapon);
        return;
    }
    self thread function_4c6a96b(eattacker, vpoint, 1000);
    self thread function_2fa561fb(eattacker);
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 1, eflags: 0x4
// Checksum 0xee1fb371, Offset: 0x3390
// Size: 0x140
function private function_e57e2edf(eattacker) {
    self endon(#"death", #"hash_556bad125b55e1a9");
    while (true) {
        if (level.round_number < 15) {
            n_dmg = self.maxhealth * randomfloatrange(0.1, 0.2);
        } else {
            n_dmg = self.maxhealth * randomfloatrange(0.05, 0.1);
        }
        if (isdefined(eattacker) && isalive(eattacker)) {
            self dodamage(n_dmg, self.origin, eattacker, eattacker, undefined, "MOD_BURNED");
        } else {
            self dodamage(n_dmg, self.origin, undefined, undefined, undefined, "MOD_BURNED");
        }
        wait 1;
    }
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 3, eflags: 0x4
// Checksum 0xe04df692, Offset: 0x34d8
// Size: 0x164
function private function_4c6a96b(eattacker, v_hit_pos, n_damage) {
    self endon(#"death");
    if (isdefined(n_damage)) {
        self dodamage(n_damage, self getcentroid(), eattacker, eattacker, "torso_lower", "MOD_BURNED");
    }
    if (self.var_29ed62b2 == #"basic") {
        if (!(isdefined(self.var_27228b00) && self.var_27228b00)) {
            self thread function_a2ae9c3(eattacker);
        }
    } else if (!(isdefined(self.is_on_fire) && self.is_on_fire)) {
        zm_spawner::damage_on_fire(eattacker);
    }
    if (level.var_6333b411.size < 12) {
        if (self.var_29ed62b2 == #"basic") {
            self thread function_d469b618(v_hit_pos);
        } else {
            self thread zombie_death::flame_death_fx();
        }
        self thread function_ad31c3f1();
    }
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 1, eflags: 0x4
// Checksum 0x5617543d, Offset: 0x3648
// Size: 0x2a4
function private function_d469b618(v_hit_pos) {
    self endon(#"death");
    if (isdefined(self.var_27228b00) && self.var_27228b00) {
        return;
    }
    if (isdefined(self.is_on_fire) && self.is_on_fire) {
        self.is_on_fire = undefined;
    }
    if (isdefined(self.disable_flame_fx) && self.disable_flame_fx) {
        return;
    }
    self.var_27228b00 = 1;
    if (!isdefined(v_hit_pos)) {
        v_hit_pos = "torso_upper";
    }
    str_tag = get_closest_tag(v_hit_pos);
    self thread zombie_death::on_fire_timeout();
    switch (str_tag) {
    case #"j_head":
        n_fx_pos = 1;
        break;
    case #"j_spinelower":
    case #"j_spine4":
    case #"j_spineupper":
        n_fx_pos = 2;
        break;
    case #"j_elbow_le":
    case #"j_wrist_le":
    case #"j_shoulder_le":
        n_fx_pos = 3;
        break;
    case #"j_elbow_ri":
    case #"j_wrist_ri":
    case #"j_shoulder_ri":
        n_fx_pos = 4;
        break;
    case #"j_ankle_le":
    case #"j_knee_le":
    case #"j_hip_le":
        n_fx_pos = 5;
        break;
    case #"j_ankle_ri":
    case #"j_knee_ri":
    case #"j_hip_ri":
        n_fx_pos = 6;
        break;
    default:
        n_fx_pos = 1;
        break;
    }
    self clientfield::set("positional_zombie_fire_fx", n_fx_pos);
    self waittill(#"stop_flame_damage");
    self clientfield::set("positional_zombie_fire_fx", 0);
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 1, eflags: 0x4
// Checksum 0x54f4b3ed, Offset: 0x38f8
// Size: 0x1f0
function private function_a2ae9c3(eattacker) {
    self endon(#"death", #"stop_flame_damage");
    waitframe(1);
    while (isdefined(self.var_27228b00) && self.var_27228b00) {
        [[ level.var_d0093016 ]]->waitinqueue(self);
        if (level.round_number < 6) {
            n_dmg = self.maxhealth * randomfloatrange(0.4, 0.5);
        } else if (level.round_number < 11) {
            n_dmg = self.maxhealth * randomfloatrange(0.3, 0.5);
        } else if (level.round_number < 21) {
            n_dmg = self.maxhealth * randomfloatrange(0.2, 0.3);
        } else {
            n_dmg = self.maxhealth * randomfloatrange(0.1, 0.15);
        }
        if (isdefined(eattacker) && isalive(eattacker)) {
            self dodamage(n_dmg, self.origin, eattacker, eattacker, undefined, "MOD_BURNED");
        } else {
            self dodamage(n_dmg, self.origin, undefined, undefined, undefined, "MOD_BURNED");
        }
        wait 1;
    }
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 0, eflags: 0x4
// Checksum 0x32dae88d, Offset: 0x3af0
// Size: 0xdc
function private function_ad31c3f1() {
    if (!isdefined(level.var_6333b411)) {
        level.var_6333b411 = [];
    } else if (!isarray(level.var_6333b411)) {
        level.var_6333b411 = array(level.var_6333b411);
    }
    if (!isinarray(level.var_6333b411, self)) {
        level.var_6333b411[level.var_6333b411.size] = self;
    }
    self waittill(#"death");
    arrayremovevalue(level.var_6333b411, self);
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 1, eflags: 0x4
// Checksum 0xeccd49e0, Offset: 0x3bd8
// Size: 0x104
function private function_2fa561fb(eattacker) {
    self endon(#"death");
    if (self.var_29ed62b2 !== #"basic") {
        return;
    }
    n_start_time = gettime();
    for (n_total_time = 0; n_total_time < 4; n_total_time = (n_current_time - n_start_time) / 1000) {
        self thread zm_utility::function_447d3917(#"hash_716657b9842cfd1b");
        wait 1;
        n_current_time = gettime();
    }
    self dodamage(self.health + 100, self getcentroid(), eattacker, eattacker, "torso_lower", "MOD_BURNED");
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 0, eflags: 0x0
// Checksum 0xeeb26b1, Offset: 0x3ce8
// Size: 0x16c
function function_6cdd25e() {
    level.var_d8934159 = struct::get_array("blundergat_upgrade_acid");
    foreach (var_23536539 in level.var_d8934159) {
        var_23536539.unitrigger_stub = var_23536539 zm_unitrigger::create(&function_a6ec0a7, 64, &function_2998a0ee);
        zm_unitrigger::unitrigger_force_per_player_triggers(var_23536539.unitrigger_stub, 1);
        var_23536539.unitrigger_stub flag::init(#"hash_56b99393c357db0f");
        var_23536539.var_b98d4fb = getent(var_23536539.target, "targetname");
        var_23536539.var_b98d4fb ghost();
    }
    level thread function_6bf827f6();
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 0, eflags: 0x4
// Checksum 0x1b1e40e6, Offset: 0x3e60
// Size: 0x78
function private function_6bf827f6() {
    level endon(#"hash_209ec855e7a13ef3");
    while (true) {
        s_result = level waittill(#"crafting_started");
        if (isdefined(s_result.unitrigger)) {
            s_result.unitrigger thread crafting_table_watcher();
        }
    }
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 0, eflags: 0x0
// Checksum 0x82bfb217, Offset: 0x3ee0
// Size: 0x128
function crafting_table_watcher() {
    if (isdefined(self.stub.blueprint) && self.stub.blueprint.name == #"zblueprint_acid_gat_build_kit") {
        v_pos = self.stub.origin;
        s_progress = self waittill(#"death", #"hash_6db03c91467a21f5");
        if (isdefined(s_progress.b_completed) && s_progress.b_completed) {
            var_23536539 = arraygetclosest(v_pos, level.var_d8934159);
            var_23536539.unitrigger_stub flag::set(#"hash_56b99393c357db0f");
            var_23536539.var_b98d4fb show();
            level notify(#"hash_209ec855e7a13ef3");
        }
    }
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 1, eflags: 0x0
// Checksum 0xddb26f82, Offset: 0x4010
// Size: 0x23a
function function_a6ec0a7(player) {
    if (!self.stub flag::get(#"hash_56b99393c357db0f")) {
        return 0;
    }
    if (level flag::get(#"hash_72c4671390c83158")) {
        return 0;
    }
    if ((player hasweapon(getweapon(#"ww_blundergat_t8")) || player hasweapon(getweapon(#"ww_blundergat_t8_upgraded")) || player hasweapon(getweapon(#"ww_blundergat_fire_t8")) || player hasweapon(getweapon(#"ww_blundergat_fire_t8_upgraded"))) && !level flag::get(#"hash_634424410f574c1c")) {
        self sethintstring(#"hash_62313fa367264bc6");
        return 1;
    }
    if (!level flag::get(#"hash_72c4671390c83158") && level flag::get(#"hash_634424410f574c1c") && isdefined(player.is_pack_splatting) && player.is_pack_splatting) {
        self sethintstring(#"hash_41dc872d8c9fd072");
        return 1;
    }
    return 0;
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 0, eflags: 0x0
// Checksum 0xd64e8f15, Offset: 0x4258
// Size: 0x6e8
function function_2998a0ee() {
    var_b98d4fb = getent(self.stub.related_parent.target, "targetname");
    v_angles = var_b98d4fb gettagangles("tag_origin");
    v_weapon_origin_offset = anglestoforward(v_angles) * 2 + anglestoright(v_angles) * 21 + anglestoup(v_angles) * 1.75;
    v_weapon_angles_offset = (0, 90, -90);
    var_b98d4fb.v_weapon_origin = var_b98d4fb gettagorigin("tag_origin") + v_weapon_origin_offset;
    var_b98d4fb.v_weapon_angles = v_angles + v_weapon_angles_offset;
    while (true) {
        s_result = self waittill(#"trigger");
        e_player = s_result.activator;
        if (!level flag::get(#"hash_72c4671390c83158") && !level flag::get(#"hash_634424410f574c1c")) {
            var_9b962656 = undefined;
            if (e_player hasweapon(getweapon(#"ww_blundergat_t8"))) {
                var_9b962656 = #"ww_blundergat_t8";
            } else if (e_player hasweapon(getweapon(#"ww_blundergat_t8_upgraded"))) {
                var_9b962656 = #"ww_blundergat_t8_upgraded";
            } else if (e_player hasweapon(getweapon(#"ww_blundergat_fire_t8"))) {
                var_9b962656 = #"ww_blundergat_fire_t8";
            } else if (e_player hasweapon(getweapon(#"ww_blundergat_fire_t8_upgraded"))) {
                var_9b962656 = #"ww_blundergat_fire_t8_upgraded";
            }
            if (isdefined(var_9b962656)) {
                e_player takeweapon(getweapon(var_9b962656));
                e_player.is_pack_splatting = 1;
                var_b98d4fb.worldgun = zm_utility::spawn_weapon_model(getweapon(var_9b962656), undefined, var_b98d4fb.v_weapon_origin, var_b98d4fb.v_weapon_angles);
                var_b98d4fb thread blundergat_upgrade_station_inject(var_9b962656, e_player, self);
            }
            continue;
        }
        if (level flag::get(#"hash_634424410f574c1c")) {
            if (isdefined(e_player.is_pack_splatting) && e_player.is_pack_splatting && zm_utility::is_player_valid(e_player) && !e_player zm_utility::is_drinking() && !zm_loadout::is_placeable_mine(e_player.currentweapon) && !zm_equipment::is_equipment(e_player.currentweapon) && e_player.currentweapon.name != "none") {
                self notify(#"acid_taken");
                e_player notify(#"acid_taken");
                var_dd27188c = zm_utility::get_player_weapon_limit(e_player);
                a_primaries = e_player getweaponslistprimaries();
                if (isdefined(a_primaries) && a_primaries.size >= var_dd27188c) {
                    e_player takeweapon(e_player.currentweapon);
                }
                if (e_player hasweapon(getweapon(#"ww_blundergat_acid_t8"))) {
                    e_player givemaxammo(getweapon(#"ww_blundergat_acid_t8"));
                } else if (e_player hasweapon(getweapon(#"ww_blundergat_acid_t8_upgraded"))) {
                    e_player givemaxammo(getweapon(#"ww_blundergat_acid_t8_upgraded"));
                } else {
                    e_player giveweapon(getweapon(#"ww_blundergat_acid_t8"));
                    e_player switchtoweapon(getweapon(#"ww_blundergat_acid_t8"));
                    e_player thread zm_audio::create_and_play_dialog("weapon_pickup", "acidgat");
                }
                e_player notify(#"player_obtained_acidgat");
            }
            if (isdefined(var_b98d4fb.worldgun)) {
                var_b98d4fb.worldgun delete();
            }
            wait 0.5;
            e_player.is_pack_splatting = undefined;
            level flag::clear(#"hash_634424410f574c1c");
            level flag::clear(#"hash_72c4671390c83158");
        }
    }
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 2, eflags: 0x0
// Checksum 0x1a20d274, Offset: 0x4948
// Size: 0xa4
function wait_for_timeout(e_player, var_f19b316b) {
    self endon(#"acid_taken");
    e_player endon(#"player_obtained_acidgat");
    wait 15;
    self notify(#"hash_607a49dec1daef58");
    level flag::clear(#"hash_634424410f574c1c");
    if (isdefined(e_player)) {
        e_player.is_pack_splatting = undefined;
    }
    if (isdefined(var_f19b316b)) {
        var_f19b316b delete();
    }
}

// Namespace zm_weap_blundergat/zm_weap_blundergat
// Params 3, eflags: 0x0
// Checksum 0x596c5c47, Offset: 0x49f8
// Size: 0x204
function blundergat_upgrade_station_inject(var_ba1489dd, e_player, var_899a94f3) {
    level flag::set(#"hash_72c4671390c83158");
    wait 0.5;
    self playsound(#"zmb_acidgat_upgrade_machine");
    self thread scene::init(#"p8_fxanim_zm_esc_packasplat_bundle", self);
    wait 5;
    self.worldgun delete();
    if (var_ba1489dd == #"ww_blundergat_t8" || var_ba1489dd == #"ww_blundergat_fire_t8") {
        self.worldgun = zm_utility::spawn_weapon_model(getweapon(#"ww_blundergat_acid_t8"), undefined, self.v_weapon_origin, self.v_weapon_angles);
    } else {
        self.worldgun = zm_utility::spawn_weapon_model(getweapon(#"ww_blundergat_acid_t8_upgraded"), undefined, self.v_weapon_origin, self.v_weapon_angles);
    }
    self thread scene::play(#"p8_fxanim_zm_esc_packasplat_bundle", self);
    wait 1;
    level flag::clear(#"hash_72c4671390c83158");
    level flag::set(#"hash_634424410f574c1c");
    if (isdefined(e_player)) {
        var_899a94f3 thread wait_for_timeout(e_player, self.worldgun);
    }
}

