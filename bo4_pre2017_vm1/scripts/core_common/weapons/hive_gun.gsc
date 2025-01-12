#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/killcam_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace namespace_5cffdc90;

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 0, eflags: 0x0
// Checksum 0xb5b2ae19, Offset: 0x660
// Size: 0x2f4
function init_shared() {
    level.var_f2a9479f = getweapon("hero_chemicalgelgun");
    level.var_20f71f76 = getweapon("hive_gungun_secondary_explosion");
    level.var_3bbbad88 = getdvarint("scr_firefly_debug", 0);
    level.var_197357e1 = getdvarint("scr_fireflyPodDetectionRadius", 150);
    level.var_c9e7e54b = getdvarfloat("scr_fireflyPodGracePeriod", 0);
    level.var_2559cde9 = getdvarfloat("scr_fireflyPodActivationTime", 1);
    level.var_b1f3e24 = getdvarfloat("scr_fireflyPartialMovePercent", 0.8);
    if (!isdefined(level.var_5f1dba02)) {
        level.var_5f1dba02 = 21;
    }
    level.var_d3d1f492 = getdvarint("betty_jump_height_onground", 55);
    level.var_349e9ed = getdvarint("betty_jump_height_wall", 20);
    level.var_1f929be9 = getdvarint("betty_onground_angle_threshold", 30);
    level.var_92e128b5 = cos(level.var_1f929be9);
    level.var_f7f4be46 = getdvarfloat("scr_firefly_emit_time", 0.2);
    level.var_760e32ed = getdvarint("scr_firefly_min_speed", 400);
    level.var_65c696bc = getdvarfloat("scr_firefly_attack_attack_speed_scale", 1.75);
    level.var_5bcd062c = getdvarfloat("scr_firefly_collision_check_interval", 0.2);
    callback::add_weapon_damage(level.var_f2a9479f, &function_602b5d20);
    level thread register();
    /#
        level thread update_dvars();
    #/
}

/#

    // Namespace namespace_5cffdc90/namespace_5cffdc90
    // Params 0, eflags: 0x0
    // Checksum 0x1826e1d8, Offset: 0x960
    // Size: 0x9c
    function update_dvars() {
        while (true) {
            wait 1;
            level.var_760e32ed = getdvarint("<dev string:x28>", 250);
            level.var_65c696bc = getdvarfloat("<dev string:x3a>", 1.15);
            level.var_3bbbad88 = getdvarint("<dev string:x60>", 0);
        }
    }

#/

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 0, eflags: 0x0
// Checksum 0xafdae190, Offset: 0xa08
// Size: 0x94
function register() {
    clientfield::register("scriptmover", "firefly_state", 1, 3, "int");
    clientfield::register("toplayer", "fireflies_attacking", 1, 1, "int");
    clientfield::register("toplayer", "fireflies_chasing", 1, 1, "int");
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 0, eflags: 0x0
// Checksum 0xbc123599, Offset: 0xaa8
// Size: 0x200
function function_2347c7c7() {
    watcher = self weaponobjects::createproximityweaponobjectwatcher("hero_chemicalgelgun", self.team);
    watcher.onspawn = &function_545b9a44;
    watcher.watchforfire = 1;
    watcher.hackable = 0;
    watcher.headicon = 0;
    watcher.activatefx = 1;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.immediatedetonation = 1;
    watcher.detectiongraceperiod = level.var_c9e7e54b;
    watcher.detonateradius = level.var_197357e1;
    watcher.onstun = &weaponobjects::weaponstun;
    watcher.stuntime = 0;
    watcher.ondetonatecallback = &function_3bf629e7;
    watcher.activationdelay = level.var_2559cde9;
    watcher.activatesound = "wpn_gelgun_blob_burst";
    watcher.var_c90f5587 = &function_878bc806;
    watcher.deleteonplayerspawn = 1;
    watcher.timeout = getdvarfloat("scr_firefly_pod_timeout", 0);
    watcher.ignorevehicles = 0;
    watcher.ignoreai = 0;
    watcher.onsupplementaldetonatecallback = &function_90fba777;
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 2, eflags: 0x0
// Checksum 0x8fc6f765, Offset: 0xcb0
// Size: 0xa4
function function_545b9a44(watcher, owner) {
    weaponobjects::onspawnproximityweaponobject(watcher, owner);
    self playloopsound("wpn_gelgun_blob_alert_lp", 1);
    self endon(#"death");
    self waittill("stationary");
    self setmodel("wpn_t7_hero_chemgun_residue3_grn");
    self setenemymodel("wpn_t7_hero_chemgun_residue3_org");
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 0, eflags: 0x0
// Checksum 0x146e1335, Offset: 0xd60
// Size: 0x34
function function_6182a7b6() {
    /#
        if (isgodmode(self)) {
            return;
        }
    #/
    self thread function_726a1213();
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 0, eflags: 0x0
// Checksum 0xdd2b3dff, Offset: 0xda0
// Size: 0x1e
function function_726a1213() {
    self endon(#"disconnect");
    self waittill("death");
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 5, eflags: 0x0
// Checksum 0xc4381541, Offset: 0xdc8
// Size: 0x4e
function function_602b5d20(eattacker, einflictor, weapon, meansofdeath, damage) {
    if ("MOD_GRENADE" != meansofdeath && "MOD_GRENADE_SPLASH" != meansofdeath) {
        return;
    }
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 0, eflags: 0x0
// Checksum 0xf8212818, Offset: 0xe20
// Size: 0x22c
function function_205d8156() {
    var_541f0416 = spawn("script_model", self.origin);
    var_541f0416.angles = self.angles;
    var_541f0416 setmodel("tag_origin");
    var_541f0416.owner = self.owner;
    var_541f0416.killcamoffset = (0, 0, getdvarfloat("scr_fireflies_start_height", 8));
    var_541f0416.weapon = getweapon("hero_firefly_swarm");
    var_541f0416.takedamage = 1;
    var_541f0416.soundmod = "firefly";
    var_541f0416.team = self.team;
    killcament = spawn("script_model", var_541f0416.origin + var_541f0416.killcamoffset);
    killcament.angles = (0, 0, 0);
    killcament setmodel("tag_origin");
    killcament setweapon(var_541f0416.weapon);
    killcament killcam::store_killcam_entity_on_entity(self);
    var_541f0416.killcament = killcament;
    self.var_541f0416 = var_541f0416;
    var_541f0416.debug_time = 1;
    var_541f0416 thread function_fba7b282();
    weaponobjects::add_supplemental_object(var_541f0416);
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 0, eflags: 0x0
// Checksum 0xb76ff52, Offset: 0x1058
// Size: 0x30
function function_fba7b282() {
    while (true) {
        self waittill("damage");
        self thread function_90fba777();
    }
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 0, eflags: 0x0
// Checksum 0xade6eb2b, Offset: 0x1090
// Size: 0x64
function function_596f2ad1() {
    if (isdefined(self.var_541f0416)) {
        if (isdefined(self.var_541f0416.killcament)) {
            self.var_541f0416.killcament delete();
        }
        self.var_541f0416 delete();
    }
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 3, eflags: 0x0
// Checksum 0xe49960fe, Offset: 0x1100
// Size: 0x184
function function_3bf629e7(attacker, weapon, target) {
    if (!isdefined(target) || !isdefined(target.team) || !isdefined(self.team) || self.team == target.team) {
        if (isdefined(weapon) && weapon.isvalid) {
            if (isdefined(attacker)) {
                if (self.owner util::isenemyplayer(attacker)) {
                    attacker challenges::destroyedexplosive(weapon);
                    scoreevents::processscoreevent("destroyed_fireflyhive", attacker, self.owner, weapon);
                }
            }
        }
        self function_27f1ba88();
        return;
    }
    self function_205d8156();
    self.var_541f0416 thread function_7453793f(target);
    self.var_541f0416 thread function_7f55c5c4(target);
    self thread function_79871484(attacker, target);
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 0, eflags: 0x0
// Checksum 0x61dbc3ad, Offset: 0x1290
// Size: 0xc4
function function_27f1ba88() {
    fx_ent = playfx("weapon/fx_hero_chem_gun_blob_death", self.origin);
    fx_ent.team = self.team;
    playsoundatposition("wpn_gelgun_blob_destroy", self.origin);
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    self function_596f2ad1();
    self delete();
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 2, eflags: 0x0
// Checksum 0xc5de37e9, Offset: 0x1360
// Size: 0x84
function function_729c2b24(position, time) {
    if (!isdefined(self.killcament)) {
        return;
    }
    self endon(#"death");
    wait 0.5;
    accel = 0;
    decel = 0;
    self.killcament moveto(position, time, accel, decel);
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 0, eflags: 0x0
// Checksum 0xaf6f07ee, Offset: 0x13f0
// Size: 0x54
function function_38d25df7() {
    self notify(#"hash_f88912f5");
    if (isdefined(self.killcament)) {
        self.killcament moveto(self.killcament.origin, 0.1, 0, 0);
    }
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 2, eflags: 0x0
// Checksum 0xfaa8e6d8, Offset: 0x1450
// Size: 0x92
function function_654599bc(position, time) {
    self endon(#"death");
    accel = 0;
    decel = 0;
    self thread function_729c2b24(position, time);
    self moveto(position, time, accel, decel);
    self waittill("movedone");
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 4, eflags: 0x0
// Checksum 0xc5c6f96, Offset: 0x14f0
// Size: 0xde
function function_c628a642(target, position, time, percent) {
    self endon(#"death");
    self endon(#"hash_f88912f5");
    accel = 0;
    decel = 0;
    self thread function_729c2b24(position, time);
    self moveto(position, time, accel, decel);
    self thread function_3a089bb(target, position, time);
    wait time * percent;
    self notify(#"movedone");
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 2, eflags: 0x0
// Checksum 0xa97f279c, Offset: 0x15d8
// Size: 0x52
function function_ad9f7ffe(angles, time) {
    self endon(#"death");
    self rotateto(angles, time, 0, 0);
    self waittill("rotatedone");
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 3, eflags: 0x0
// Checksum 0x69beff09, Offset: 0x1638
// Size: 0x154
function function_3a089bb(target, move_to, time) {
    self endon(#"death");
    self endon(#"movedone");
    original_position = self.origin;
    dir = vectornormalize(move_to - self.origin);
    dist = distance(self.origin, move_to);
    speed = dist / time;
    delta = dir * speed * level.var_5bcd062c;
    while (true) {
        if (!function_3bca47af(self.origin + delta, target)) {
            self thread function_90fba777();
            self playsound("wpn_gelgun_hive_wall_impact");
        }
        wait level.var_5bcd062c;
    }
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 3, eflags: 0x0
// Checksum 0x41196b4f, Offset: 0x1798
// Size: 0x8c
function function_83614051(degrees, radius, height) {
    angles = (0, degrees, 0);
    forward = (radius, 0, 0);
    point = rotatepoint(forward, angles);
    return self.spawn_origin + point + (0, 0, height);
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 0, eflags: 0x0
// Checksum 0x9e782f04, Offset: 0x1830
// Size: 0x72
function function_b89d2a69() {
    return function_83614051(randomint(359), randomint(level.var_ce2b8735), randomintrange(level.var_afb23ee4 * -1, level.var_afb23ee4));
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 0, eflags: 0x0
// Checksum 0xe03fc888, Offset: 0x18b0
// Size: 0x138
function function_d0099366() {
    self endon(#"death");
    self endon(#"attacking");
    while (true) {
        point = function_b89d2a69();
        delta = point - self.origin;
        angles = vectortoangles(delta);
        function_ad9f7ffe(angles, 0.15);
        dist = length(delta);
        time = 0.01;
        if (dist > 0) {
            time = dist / level.var_760e32ed;
        }
        function_654599bc(point, time);
        wait randomfloatrange(0.1, 0.7);
    }
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 3, eflags: 0x0
// Checksum 0xeb273389, Offset: 0x19f0
// Size: 0x1c4
function function_e78bffe3(degrees, increment, radius) {
    self endon(#"death");
    self endon(#"attacking");
    var_f2dfd712 = randomint(int(360 / degrees)) * degrees;
    height_offset = 0;
    while (true) {
        point = function_83614051(var_f2dfd712, radius, height_offset);
        delta = point - self.origin;
        angles = (0, var_f2dfd712, 0);
        thread function_ad9f7ffe(angles, 0.15);
        dist = length(delta);
        time = 0.01;
        if (dist > 0) {
            time = dist / level.var_760e32ed;
        }
        function_654599bc(point, time);
        wait randomfloatrange(0.1, 0.3);
        var_f2dfd712 = (var_f2dfd712 + degrees * increment) % 360;
    }
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 1, eflags: 0x0
// Checksum 0xa6ba2a18, Offset: 0x1bc0
// Size: 0x2d8
function function_c4fb08f0(target) {
    level endon(#"game_ended");
    self endon(#"death");
    target endon(#"disconnect");
    target endon(#"death");
    target endon(#"entering_last_stand");
    damage = 25;
    var_894fd1c6 = 0.1;
    weapon = self.weapon;
    target playsound("wpn_gelgun_hive_attack");
    target notify(#"hash_2f723e7e");
    var_1a797bc0 = 10;
    if (!isplayer(target)) {
        var_1a797bc0 = 4;
    }
    while (var_1a797bc0 > 0) {
        wait var_894fd1c6;
        target dodamage(damage, self.origin, self.owner, self, "", "MOD_IMPACT", 0, weapon);
        var_1a797bc0 -= 1;
        if (isalive(target) && isplayer(target)) {
            bodytype = target getcharacterbodytype();
            if (bodytype >= 0) {
                var_f99f1882 = getcharacterfields(bodytype, currentsessionmode());
                if (isdefined(var_f99f1882.digitalblood) ? var_f99f1882.digitalblood : 0) {
                    playfxontag("weapon/fx_hero_firefly_sparks_os", target, "J_SpineLower");
                } else {
                    playfxontag("weapon/fx_hero_firefly_blood_os", target, "J_SpineLower");
                }
            } else {
                playfxontag("weapon/fx_hero_firefly_blood_os", target, "J_SpineLower");
            }
            continue;
        }
        if (!isplayer(target)) {
            playfxontag("weapon/fx_hero_firefly_sparks_os", target, "tag_origin");
        }
    }
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 1, eflags: 0x0
// Checksum 0x72277c02, Offset: 0x1ea0
// Size: 0xbc
function function_7453793f(target) {
    self endon(#"death");
    if (isalive(target)) {
        target waittill("death", "flashback", "game_ended");
    }
    if (isplayer(target)) {
        target clientfield::set_to_player("fireflies_attacking", 0);
        target clientfield::set_to_player("fireflies_chasing", 0);
    }
    self thread function_90fba777();
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 1, eflags: 0x0
// Checksum 0x7417bb93, Offset: 0x1f68
// Size: 0xac
function function_7f55c5c4(target) {
    self endon(#"death");
    level waittill("game_ended");
    if (isalive(target) && isplayer(target)) {
        target clientfield::set_to_player("fireflies_attacking", 0);
        target clientfield::set_to_player("fireflies_chasing", 0);
    }
    self thread function_90fba777();
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 0, eflags: 0x0
// Checksum 0xb2907bef, Offset: 0x2020
// Size: 0x154
function function_90fba777() {
    /#
        println("<dev string:x72>" + self getentnum());
    #/
    self clientfield::set("firefly_state", 5);
    self playsound("wpn_gelgun_hive_die");
    if (isdefined(self.target_entity) && isplayer(self.target_entity)) {
        self.target_entity clientfield::set_to_player("fireflies_attacking", 0);
        self.target_entity clientfield::set_to_player("fireflies_chasing", 0);
    }
    waittillframeend();
    thread function_c3149187(self.killcament);
    if (isdefined(self)) {
        /#
            println("<dev string:x81>" + self getentnum());
        #/
        self delete();
    }
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 1, eflags: 0x0
// Checksum 0x877df483, Offset: 0x2180
// Size: 0x34
function function_c3149187(killcament) {
    wait 5;
    if (isdefined(killcament)) {
        killcament delete();
    }
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 1, eflags: 0x0
// Checksum 0x9b3b2ea5, Offset: 0x21c0
// Size: 0x88
function function_187ecda(target) {
    velocity = target getvelocity();
    speed = length(velocity) * level.var_65c696bc;
    if (speed < level.var_760e32ed) {
        speed = level.var_760e32ed;
    }
    return speed;
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 2, eflags: 0x0
// Checksum 0x3ac271d8, Offset: 0x2250
// Size: 0x1ec
function function_d15aaa87(target, state) {
    level endon(#"game_ended");
    self endon(#"death");
    target endon(#"entering_last_stand");
    self thread function_38d25df7();
    self clientfield::set("firefly_state", state);
    if (isplayer(target)) {
        target clientfield::set_to_player("fireflies_attacking", 1);
    }
    target_origin = target.origin + (0, 0, 50);
    delta = self.origin - target_origin;
    dist = length(delta);
    time = 0.01;
    if (dist > 0) {
        speed = function_187ecda(target);
        time = dist / speed;
    }
    self.enemy = target;
    function_654599bc(target_origin, time);
    self linkto(target);
    wait time;
    if (!isalive(target)) {
        return;
    }
    self thread function_c4fb08f0(target);
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 1, eflags: 0x0
// Checksum 0xc1fd64d6, Offset: 0x2448
// Size: 0xaa
function function_961e63c3(target) {
    height = 50;
    if (isplayer(target)) {
        stance = target getstance();
        if (stance == "crouch") {
            height = 30;
        } else if (stance == "prone") {
            height = 15;
        }
    }
    return target.origin + (0, 0, height);
}

/#

    // Namespace namespace_5cffdc90/namespace_5cffdc90
    // Params 1, eflags: 0x0
    // Checksum 0xb075dd78, Offset: 0x2500
    // Size: 0x16a
    function function_37137eb(target) {
        self endon(#"death");
        self endon(#"attack");
        while (true) {
            var_6cb204d2 = self.origin;
            for (i = 0; i < self.var_9cf529c1.size; i++) {
                if (self.var_537cb7e9 + i > self.var_82ab7ed6) {
                    break;
                }
                crumb_index = (self.var_537cb7e9 + i) % self.var_9cf529c1.size;
                crumb = self.var_9cf529c1[crumb_index];
                sphere(crumb, 2, (0, 1, 0), 1, 1, 10, self.debug_time);
                if (i > 0) {
                    line(var_6cb204d2, crumb, (0, 1, 0), 1, 1, self.debug_time);
                }
                var_6cb204d2 = crumb;
            }
            waitframe(1);
        }
    }

#/

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 1, eflags: 0x0
// Checksum 0x104b2962, Offset: 0x2678
// Size: 0x1be
function function_f43c3dfc(target) {
    self endon(#"death");
    target endon(#"death");
    self.var_9cf529c1 = [];
    self.var_537cb7e9 = 0;
    self.var_82ab7ed6 = 0;
    var_4b25e927 = 400;
    self.var_38756ed8 = 20;
    self.var_9cf529c1[self.var_82ab7ed6] = function_961e63c3(target);
    /#
        if (level.var_3bbbad88) {
            self thread function_37137eb(target);
        }
    #/
    while (true) {
        wait 0.25;
        var_744f6323 = self.var_82ab7ed6 % self.var_38756ed8;
        var_61f36349 = function_961e63c3(target);
        if (distancesquared(var_61f36349, self.var_9cf529c1[var_744f6323]) > var_4b25e927) {
            self.var_82ab7ed6++;
            if (self.var_82ab7ed6 >= self.var_537cb7e9 + self.var_38756ed8) {
                self.var_537cb7e9 = self.var_82ab7ed6 - self.var_38756ed8 + 1;
            }
            self.var_9cf529c1[self.var_82ab7ed6 % self.var_38756ed8] = var_61f36349;
        }
    }
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 1, eflags: 0x0
// Checksum 0xb650e532, Offset: 0x2840
// Size: 0x9c
function function_7a614bfa(target) {
    if (self.var_537cb7e9 > self.var_82ab7ed6) {
        return function_961e63c3(target);
    }
    current_index = self.var_537cb7e9 % self.var_38756ed8;
    if (!isdefined(self.var_9cf529c1[current_index])) {
        return function_961e63c3(target);
    }
    return self.var_9cf529c1[current_index];
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 2, eflags: 0x0
// Checksum 0x23af6bd4, Offset: 0x28e8
// Size: 0x4c
function function_3bca47af(position, target) {
    passed = bullettracepassed(self.origin, position, 0, self, target);
    return passed;
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 1, eflags: 0x0
// Checksum 0x22efa054, Offset: 0x2940
// Size: 0x314
function function_fb950047(target) {
    level endon(#"game_ended");
    self endon(#"death");
    target endon(#"death");
    target endon(#"entering_last_stand");
    self clientfield::set("firefly_state", 2);
    if (isplayer(target)) {
        target clientfield::set_to_player("fireflies_chasing", 1);
    }
    max_distance = 500;
    var_f6b9cc79 = 50;
    var_5f58e301 = 10;
    up = (0, 0, 1);
    while (true) {
        target_origin = target.origin + (0, 0, 50);
        delta = target_origin - self.origin;
        dist = length(delta);
        if (dist <= var_f6b9cc79 && function_3bca47af(target_origin, target)) {
            thread function_d15aaa87(target, 3);
            return;
        } else {
            target_origin = function_7a614bfa(target);
            /#
                if (level.var_3bbbad88) {
                    sphere(self.origin, 2, (1, 0, 0), 1, 1, 10, self.debug_time);
                }
            #/
        }
        delta = target_origin - self.origin;
        angles = vectortoangles(delta);
        thread function_ad9f7ffe(angles, 0.15);
        dist = length(delta);
        time = 0.01;
        if (dist > 0) {
            speed = function_187ecda(target);
            time = dist / speed;
        }
        function_c628a642(target, target_origin, time, level.var_b1f3e24);
        self.var_537cb7e9++;
    }
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 3, eflags: 0x0
// Checksum 0x2cd19469, Offset: 0x2c60
// Size: 0x214
function function_cfecc4d1(start_pos, target, linked) {
    level endon(#"game_ended");
    self endon(#"death");
    self notify(#"attack");
    /#
        if (level.var_3bbbad88) {
            sphere(self.origin, 4, (1, 0, 0), 1, 1, 10, self.debug_time);
        }
    #/
    level.var_afb23ee4 = 30;
    level.var_ce2b8735 = 100;
    self.var_851b29ac = target.origin;
    self.target_entity = target;
    if (linked) {
        thread function_d15aaa87(target, 4);
        return;
    } else {
        thread function_f43c3dfc(target);
        self moveto(start_pos, level.var_f7f4be46, 0, level.var_f7f4be46);
        self waittill("movedone");
        delta = target.origin - self.origin;
        angles = vectortoangles(delta);
        self.angles = angles;
        self thread function_fb950047(target);
    }
    wait 30;
    if (isdefined(self.killcament)) {
        self.killcament delete();
    }
    self delete();
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 2, eflags: 0x0
// Checksum 0x46f255b3, Offset: 0x2e80
// Size: 0x22c
function function_79871484(attacker, target) {
    jumpdir = vectornormalize(anglestoup(self.angles));
    if (jumpdir[2] > level.var_92e128b5) {
        jumpheight = level.var_d3d1f492;
    } else {
        jumpheight = level.var_349e9ed;
    }
    explodepos = self.origin + jumpdir * jumpheight;
    self.var_541f0416.spawn_origin = explodepos;
    linked_to = self getlinkedent();
    linked = linked_to === target;
    if (!linked) {
        fx_ent = playfx("weapon/fx_hero_firefly_start", self.origin, anglestoup(self.angles));
        fx_ent.team = self.team;
        self.var_541f0416 clientfield::set("firefly_state", 1);
        self.var_541f0416.killcament moveto(explodepos + self.var_541f0416.killcamoffset, level.var_f7f4be46, 0, level.var_f7f4be46);
    }
    self.var_541f0416 thread function_cfecc4d1(explodepos, target, linked);
    self delete();
}

// Namespace namespace_5cffdc90/namespace_5cffdc90
// Params 4, eflags: 0x0
// Checksum 0x66f9959b, Offset: 0x30b8
// Size: 0x84
function function_878bc806(watcher, attacker, weapon, damage) {
    if (weapon == watcher.weapon) {
        return false;
    }
    if (weapon.isemp || weapon.destroysequipment) {
        return true;
    }
    if (self.damagetaken < 15) {
        return false;
    }
    return true;
}

