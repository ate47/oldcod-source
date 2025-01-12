#using scripts\abilities\ability_player;
#using scripts\core_common\audio_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\rcxd;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\remote_weapons;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\weapons\deployable;

#namespace killstreak_vehicle;

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 0, eflags: 0x0
// Checksum 0x4f9c8e3f, Offset: 0x1e8
// Size: 0x34
function init() {
    clientfield::register("vehicle", "stunned", 1, 1, "int");
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 1, eflags: 0x0
// Checksum 0xbaf31939, Offset: 0x228
// Size: 0x14c
function init_killstreak(bundle) {
    killstreaks::register_bundle(bundle, &activate_vehicle);
    killstreaks::allow_assists(bundle.var_e409027f, 1);
    remote_weapons::registerremoteweapon(bundle.ksweapon.name, #"", &function_a0274e96, &function_ead43c4f, 0);
    vehicle::add_main_callback(bundle.ksvehicle, &init_vehicle);
    deployable::register_deployable(bundle.ksweapon, undefined, undefined);
    level.killstreaks[bundle.var_e409027f].var_66b45a8f = 1;
    if (isdefined(bundle.var_65b65f1b)) {
        visionset_mgr::register_info("overlay", bundle.var_65b65f1b, 1, 1, 1, 1);
    }
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 0, eflags: 0x0
// Checksum 0xe617e2fb, Offset: 0x380
// Size: 0x134
function init_vehicle() {
    vehicle = self;
    vehicle clientfield::set("enemyvehicle", 1);
    vehicle.allowfriendlyfiredamageoverride = &function_cf4e0053;
    vehicle enableaimassist();
    vehicle setdrawinfrared(1);
    vehicle.delete_on_death = 1;
    vehicle.death_enter_cb = &function_c8a1df55;
    vehicle.disableremoteweaponswitch = 1;
    vehicle.overridevehicledamage = &on_damage;
    vehicle.overridevehiclekilled = &on_death;
    vehicle.watch_remote_weapon_death = 1;
    vehicle.watch_remote_weapon_death_duration = 0.3;
    if (issentient(vehicle) == 0) {
        vehicle makesentient();
    }
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 0, eflags: 0x0
// Checksum 0x7fd21c94, Offset: 0x4c0
// Size: 0xd2
function function_c8a1df55() {
    remote_controlled = isdefined(self.control_initiated) && self.control_initiated || isdefined(self.controlled) && self.controlled;
    if (remote_controlled) {
        notifystring = self waittill(#"remote_weapon_end", #"shutdown");
        if (notifystring._notify == "remote_weapon_end") {
            self waittill(#"shutdown");
        } else {
            self waittill(#"remote_weapon_end");
        }
        return;
    }
    self waittill(#"shutdown");
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 1, eflags: 0x0
// Checksum 0x1e0cbbee, Offset: 0x5a0
// Size: 0xa4
function function_6abfe7b(hacker) {
    vehicle = self;
    vehicle clientfield::set("toggle_lights", 1);
    vehicle.owner unlink();
    vehicle clientfield::set("vehicletransition", 0);
    vehicle.owner killstreaks::clear_using_remote();
    vehicle makevehicleunusable();
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 1, eflags: 0x0
// Checksum 0xc51a55e3, Offset: 0x650
// Size: 0xc4
function function_1932cbb4(hacker) {
    killstreak_type = level.var_59b5a4c5[self];
    bundle = level.killstreaks[killstreak_type].script_bundle;
    vehicle = self;
    hacker remote_weapons::useremoteweapon(vehicle, bundle.ksweapon, 1, 0);
    vehicle makevehicleunusable();
    vehicle killstreaks::set_killstreak_delay_killcam(killstreak_type);
    vehicle killstreak_hacking::set_vehicle_drivable_time_starting_now(vehicle);
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 1, eflags: 0x0
// Checksum 0x1fe8c069, Offset: 0x720
// Size: 0x4c
function function_501f1a63(owner) {
    self endon(#"shutdown");
    self killstreaks::function_501f1a63(owner, &function_4c0cc422);
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 2, eflags: 0x0
// Checksum 0xeeeec340, Offset: 0x778
// Size: 0x2c
function function_7e9a710c(owner, ishacked) {
    self thread function_501f1a63(owner);
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 1, eflags: 0x0
// Checksum 0x1bc6b640, Offset: 0x7b0
// Size: 0x7e
function can_activate(placement) {
    if (!isdefined(placement)) {
        return false;
    }
    if (!self isonground()) {
        return false;
    }
    if (self util::isusingremote()) {
        return false;
    }
    if (killstreaks::is_interacting_with_object()) {
        return false;
    }
    if (self oob::istouchinganyoobtrigger()) {
        return false;
    }
    return true;
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 1, eflags: 0x0
// Checksum 0xc686fac, Offset: 0x838
// Size: 0x4f0
function activate_vehicle(type) {
    assert(isplayer(self));
    player = self;
    if (!player killstreakrules::iskillstreakallowed(type, player.team)) {
        return false;
    }
    if (player usebuttonpressed()) {
        return false;
    }
    bundle = level.killstreaks[type].script_bundle;
    if (isdefined(bundle.ksweapon) && isdefined(bundle.ksweapon.deployable) && bundle.ksweapon.deployable && !deployable::function_c1fe55ef(bundle.ksweapon, 1)) {
        return false;
    }
    killstreak_id = player killstreakrules::killstreakstart(type, player.team, 0, 1);
    if (killstreak_id == -1) {
        return false;
    }
    vehicle = spawnvehicle(bundle.ksvehicle, player.var_ac6d9bd1, player.var_fc43d05f, type);
    vehicle deployable::function_c334d8f9(player);
    vehicle killstreaks::configure_team(type, killstreak_id, player, "small_vehicle", undefined, &function_7e9a710c);
    vehicle killstreak_hacking::enable_hacking(type, &function_6abfe7b, &function_1932cbb4);
    vehicle.damagetaken = 0;
    vehicle.abandoned = 0;
    vehicle.killstreak_id = killstreak_id;
    vehicle.activatingkillstreak = 1;
    vehicle setinvisibletoall();
    vehicle thread watch_shutdown(player);
    vehicle.health = bundle.kshealth;
    vehicle.maxhealth = bundle.kshealth;
    vehicle.hackedhealth = bundle.kshackedhealth;
    vehicle.hackedhealthupdatecallback = &function_40dafab2;
    vehicle.ignore_vehicle_underneath_splash_scalar = 1;
    if (isdefined(bundle.ksweapon)) {
        vehicle setweapon(bundle.ksweapon);
        vehicle.weapon = bundle.ksweapon;
    }
    vehicle killstreak_bundles::spawned(bundle);
    self thread killstreaks::play_killstreak_start_dialog(type, self.team, killstreak_id);
    self stats::function_4f10b697(bundle.ksweapon, #"used", 1);
    remote_weapons::useremoteweapon(vehicle, bundle.ksweapon.name, 1, 0);
    if (!isdefined(player) || !isalive(player) || isdefined(player.laststand) && player.laststand || player isempjammed()) {
        if (isdefined(vehicle)) {
            vehicle notify(#"remote_weapon_shutdown");
            vehicle function_127502e0();
        }
        return false;
    }
    if (!isdefined(vehicle)) {
        return false;
    }
    vehicle setvisibletoall();
    vehicle.activatingkillstreak = 0;
    target_set(vehicle);
    ability_player::function_184edba5(bundle.ksweapon);
    vehicle thread watch_game_ended();
    return true;
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 1, eflags: 0x0
// Checksum 0xab6843b7, Offset: 0xd30
// Size: 0x4e
function function_40dafab2(hacker) {
    vehicle = self;
    if (vehicle.health > vehicle.hackedhealth) {
        vehicle.health = vehicle.hackedhealth;
    }
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 1, eflags: 0x0
// Checksum 0xbb5d85c2, Offset: 0xd88
// Size: 0x1a4
function function_a0274e96(vehicle) {
    player = self;
    vehicle usevehicle(player, 0);
    vehicle clientfield::set("vehicletransition", 1);
    vehicle thread audio::sndupdatevehiclecontext(1);
    vehicle thread watch_timeout();
    vehicle thread function_e39645e2();
    vehicle thread function_c809573a();
    vehicle thread watch_water();
    player vehicle::set_vehicle_drivable_time_starting_now(int(vehicle.var_63a22f1e.ksduration));
    if (isdefined(vehicle.var_63a22f1e.var_65b65f1b)) {
        visionset_mgr::activate("overlay", vehicle.var_63a22f1e.var_65b65f1b, player, 1, 90000, 1);
    }
    if (isbot(self)) {
        if (vehicle.vehicletype == "vehicle_t8_drone_recon") {
            self thread function_fc70a200(vehicle);
        }
    }
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 1, eflags: 0x0
// Checksum 0xb6ebffdb, Offset: 0xf38
// Size: 0x4a
function function_fc70a200(vehicle) {
    vehicle thread rcxd::function_7619e01();
    vehicle vehicle_ai::get_state_callbacks("death").update_func = undefined;
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 2, eflags: 0x0
// Checksum 0xed13b14d, Offset: 0xf90
// Size: 0xe4
function function_ead43c4f(vehicle, exitrequestedbyowner) {
    if (exitrequestedbyowner == 0) {
        vehicle function_127502e0();
        vehicle thread audio::sndupdatevehiclecontext(0);
    }
    if (isdefined(vehicle.var_63a22f1e.var_65b65f1b)) {
        visionset_mgr::deactivate("overlay", vehicle.var_63a22f1e.var_65b65f1b, vehicle.owner);
    }
    vehicle clientfield::set("vehicletransition", 0);
    function_1d57566e(vehicle.var_63a22f1e, self.remoteowner);
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 0, eflags: 0x0
// Checksum 0xb47df237, Offset: 0x1080
// Size: 0x8c
function function_e39645e2() {
    vehicle = self;
    vehicle endon(#"shutdown");
    vehicle endon(#"death");
    while (!(isdefined(vehicle.owner) && vehicle.owner attackbuttonpressed())) {
        waitframe(1);
    }
    vehicle function_127502e0();
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 0, eflags: 0x0
// Checksum 0x8215441a, Offset: 0x1118
// Size: 0xc2
function watch_exit() {
    vehicle = self;
    vehicle endon(#"shutdown");
    vehicle endon(#"death");
    while (true) {
        timeused = 0;
        while (vehicle.owner usebuttonpressed()) {
            timeused += level.var_b5db3a4;
            if (timeused >= 250) {
                vehicle function_127502e0();
                return;
            }
            waitframe(1);
        }
        waitframe(1);
    }
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 0, eflags: 0x0
// Checksum 0xad7c978a, Offset: 0x11e8
// Size: 0xd4
function function_e44303e0() {
    self endon(#"shutdown");
    for (inwater = 0; !inwater; inwater = trace[#"fraction"] < 1) {
        wait 0.5;
        trace = physicstrace(self.origin + (0, 0, 10), self.origin + (0, 0, 6), (-2, -2, -2), (2, 2, 2), self, 4);
    }
    self function_4c0cc422();
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 0, eflags: 0x0
// Checksum 0x4defd826, Offset: 0x12c8
// Size: 0xa4
function watch_water() {
    self endon(#"shutdown");
    var_c51e5334 = 10;
    for (inwater = 0; !inwater; inwater = depth > var_c51e5334) {
        wait 0.5;
        depth = getwaterheight(self.origin) - self.origin[2];
    }
    self function_4c0cc422();
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 0, eflags: 0x0
// Checksum 0xa2fa73b, Offset: 0x1378
// Size: 0x6c
function watch_timeout() {
    vehicle = self;
    bundle = vehicle.var_63a22f1e;
    vehicle thread killstreaks::waitfortimeout(bundle.var_e409027f, bundle.ksduration, &function_127502e0, "shutdown");
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 0, eflags: 0x0
// Checksum 0xbaf46a3, Offset: 0x13f0
// Size: 0x34
function function_4c0cc422() {
    vehicle = self;
    vehicle.abandoned = 1;
    vehicle function_127502e0();
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 0, eflags: 0x0
// Checksum 0x99f4ccc, Offset: 0x1430
// Size: 0x28
function function_127502e0() {
    vehicle = self;
    vehicle notify(#"shutdown");
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 2, eflags: 0x0
// Checksum 0x92cce6ef, Offset: 0x1460
// Size: 0x4c
function function_1d57566e(bundle, driver) {
    if (isdefined(driver)) {
        var_ef31a667 = 0;
        driver ability_player::function_281eba9f(bundle.ksweapon, var_ef31a667);
    }
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 1, eflags: 0x0
// Checksum 0xb956c136, Offset: 0x14b8
// Size: 0x144
function watch_shutdown(driver) {
    vehicle = self;
    vehicle endon(#"death");
    vehicle waittill(#"shutdown");
    bundle = vehicle.var_63a22f1e;
    vehicle notify(#"remote_weapon_shutdown");
    if (isdefined(vehicle.activatingkillstreak) && vehicle.activatingkillstreak) {
        killstreakrules::killstreakstop(bundle.var_e409027f, vehicle.originalteam, vehicle.killstreak_id);
        vehicle function_127502e0();
        vehicle delete();
    } else {
        vehicle thread function_2d4ccd1c();
    }
    vehicle killstreaks::function_c8c6c926();
    function_1d57566e(bundle, driver);
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 0, eflags: 0x0
// Checksum 0x3cc1cb88, Offset: 0x1608
// Size: 0xdc
function function_2d4ccd1c() {
    vehicle = self;
    vehicle endon(#"death");
    vehicle waittill(#"remote_weapon_end", #"hash_59b25025ce93a142");
    attacker = isdefined(vehicle.owner) ? vehicle.owner : undefined;
    vehicle dodamage(vehicle.health + 1, vehicle.origin + (0, 0, 10), attacker, attacker, "none", "MOD_EXPLOSIVE", 0);
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 0, eflags: 0x0
// Checksum 0xb6cc7eac, Offset: 0x16f0
// Size: 0xd0
function function_c809573a() {
    vehicle = self;
    vehicle endon(#"shutdown");
    while (true) {
        waitresult = vehicle waittill(#"touch");
        ent = waitresult.entity;
        if (isdefined(ent.classname) && (ent.classname == "trigger_hurt_new" || ent.classname == "trigger_out_of_bounds")) {
            vehicle function_127502e0();
        }
    }
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 15, eflags: 0x0
// Checksum 0xe7c76231, Offset: 0x17c8
// Size: 0x194
function on_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (self.activatingkillstreak) {
        return 0;
    }
    if (!isdefined(eattacker) || eattacker != self.owner) {
        bundle = self.var_63a22f1e;
        idamage = killstreaks::ondamageperweapon(bundle.var_e409027f, eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, 0, undefined, 1, 1);
    }
    if (isdefined(eattacker) && isdefined(eattacker.team) && eattacker.team != self.team) {
        if (weapon.isemp) {
            self.damage_on_death = 0;
            self.died_by_emp = 1;
            idamage = self.health + 1;
        }
    }
    return idamage;
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 8, eflags: 0x0
// Checksum 0x361c39d5, Offset: 0x1968
// Size: 0x2ac
function on_death(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    vehicle = self;
    player = vehicle.owner;
    player endon(#"disconnect");
    player endon(#"joined_team");
    player endon(#"joined_spectators");
    bundle = self.var_63a22f1e;
    var_68dfef06 = isdefined(vehicle.var_68dfef06) ? vehicle.var_68dfef06 : 0;
    var_42ee4af4 = bundle.var_e409027f;
    var_42974e05 = vehicle.originalteam;
    var_7cbfcc70 = vehicle.killstreak_id;
    if (!var_68dfef06) {
        killstreakrules::killstreakstop(var_42ee4af4, var_42974e05, var_7cbfcc70);
    }
    vehicle clientfield::set("enemyvehicle", 0);
    vehicle explode(eattacker, weapon);
    var_db2b5269 = vehicle.died_by_emp === 1 ? 0.2 : 0.1;
    if (isdefined(player)) {
        player val::set(#"hash_7412aa1ce117e2a5", "freezecontrols");
        vehicle thread function_6c95b47b(var_db2b5269);
        wait 0.2;
        player val::reset(#"hash_7412aa1ce117e2a5", "freezecontrols");
    } else {
        vehicle thread function_6c95b47b(var_db2b5269);
    }
    if (var_68dfef06) {
        killstreakrules::killstreakstop(var_42ee4af4, var_42974e05, var_7cbfcc70);
    }
    if (isdefined(vehicle)) {
        vehicle function_127502e0();
    }
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 0, eflags: 0x0
// Checksum 0x9eebd363, Offset: 0x1c20
// Size: 0x64
function watch_game_ended() {
    vehicle = self;
    vehicle endon(#"death");
    level waittill(#"game_ended");
    vehicle.selfdestruct = 1;
    vehicle function_4c0cc422();
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 1, eflags: 0x0
// Checksum 0xbc71d012, Offset: 0x1c90
// Size: 0x4a
function function_6c95b47b(waittime) {
    self endon(#"death");
    wait waittime;
    self ghost();
    self.var_dd8f3836 = 1;
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 0, eflags: 0x0
// Checksum 0xd7a8d90d, Offset: 0x1ce8
// Size: 0xbc
function vehicle_death() {
    self vehicle_death::death_fx();
    self thread vehicle_death::death_radius_damage();
    self thread vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
    self vehicle::toggle_tread_fx(0);
    self vehicle::toggle_exhaust_fx(0);
    self vehicle::toggle_sounds(0);
    self vehicle::lights_off();
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 2, eflags: 0x0
// Checksum 0x613b3cf, Offset: 0x1db0
// Size: 0x288
function explode(attacker, weapon) {
    self endon(#"death");
    owner = self.owner;
    if (!isdefined(attacker) && isdefined(owner)) {
        attacker = owner;
    }
    attacker = self [[ level.figure_out_attacker ]](attacker);
    self vehicle_death();
    bundle = self.var_63a22f1e;
    var_757a988f = 0;
    if (!(isdefined(self.abandoned) && self.abandoned) && isplayer(attacker)) {
        attacker challenges::destroy_killstreak_vehicle(weapon, bundle.var_4d014756);
        if (self.team != attacker.team) {
            var_757a988f = 1;
            self killstreaks::function_8acf563(attacker, weapon, owner);
            luinotifyevent(#"player_callout", 2, bundle.var_61bf60f1, attacker.entnum);
            if (isdefined(weapon) && weapon.isvalid) {
                level.globalkillstreaksdestroyed++;
                attacker stats::function_4f10b697(bundle.ksweapon, #"destroyed", 1);
                attacker stats::function_4f10b697(bundle.ksweapon, #"destroyed_controlled_killstreak", 1);
                attacker challenges::destroyscorestreak(weapon, 0, 1);
                attacker challenges::function_90c432bd(weapon);
            }
            self killstreaks::play_destroyed_dialog_on_owner(bundle.var_e409027f, self.killstreak_id);
            attacker battlechatter::function_b5530e2c(bundle.var_e409027f, weapon);
        }
    }
    return var_757a988f;
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 4, eflags: 0x0
// Checksum 0xaf4b11ec, Offset: 0x2040
// Size: 0x70
function function_cf4e0053(einflictor, eattacker, smeansofdeath, weapon) {
    if (isdefined(eattacker) && eattacker == self.owner) {
        return true;
    }
    if (isdefined(einflictor) && einflictor islinkedto(self)) {
        return true;
    }
    return false;
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 0, eflags: 0x0
// Checksum 0xcf7d3123, Offset: 0x20b8
// Size: 0x76
function function_e686f80f() {
    startheight = 50;
    switch (self getstance()) {
    case #"crouch":
        startheight = 30;
        break;
    case #"prone":
        startheight = 15;
        break;
    }
    return startheight;
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 2, eflags: 0x0
// Checksum 0xd50ebc15, Offset: 0x2138
// Size: 0x4a0
function function_16277bf0(origin, angles) {
    startheight = function_e686f80f();
    mins = (-5, -5, 0);
    maxs = (5, 5, 10);
    startpoints = [];
    startangles = [];
    wheelcounts = [];
    testcheck = [];
    largestcount = 0;
    largestcountindex = 0;
    testangles = [];
    testangles[0] = (0, 0, 0);
    testangles[1] = (0, 20, 0);
    testangles[2] = (0, -20, 0);
    testangles[3] = (0, 45, 0);
    testangles[4] = (0, -45, 0);
    heightoffset = 5;
    for (i = 0; i < testangles.size; i++) {
        testcheck[i] = 0;
        startangles[i] = (0, angles[1], 0);
        startpoint = origin + vectorscale(anglestoforward(startangles[i] + testangles[i]), 70);
        endpoint = startpoint - (0, 0, 100);
        startpoint += (0, 0, startheight);
        mask = 1 | 2;
        trace = physicstrace(startpoint, endpoint, mins, maxs, self, mask);
        if (isdefined(trace[#"entity"]) && isplayer(trace[#"entity"])) {
            wheelcounts[i] = 0;
            continue;
        }
        startpoints[i] = trace[#"position"] + (0, 0, heightoffset);
        wheelcounts[i] = function_b2df18b0(startpoints[i], startangles[i], heightoffset);
        if (positionwouldtelefrag(startpoints[i])) {
            continue;
        }
        if (largestcount < wheelcounts[i]) {
            largestcount = wheelcounts[i];
            largestcountindex = i;
        }
        if (wheelcounts[i] >= 3) {
            testcheck[i] = 1;
            if (function_90774dda(startpoints[i], startangles[i])) {
                placement = spawnstruct();
                placement.origin = startpoints[i];
                placement.angles = startangles[i];
                return placement;
            }
        }
    }
    for (i = 0; i < testangles.size; i++) {
        if (!testcheck[i]) {
            if (wheelcounts[i] >= 2) {
                if (function_90774dda(startpoints[i], startangles[i])) {
                    placement = spawnstruct();
                    placement.origin = startpoints[i];
                    placement.angles = startangles[i];
                    return placement;
                }
            }
        }
    }
    return undefined;
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 3, eflags: 0x0
// Checksum 0xfb955a99, Offset: 0x25e0
// Size: 0x1ec
function function_b2df18b0(origin, angles, heightoffset) {
    forward = 13;
    side = 10;
    wheels = [];
    wheels[0] = (forward, side, 0);
    wheels[1] = (forward, -1 * side, 0);
    wheels[2] = (-1 * forward, -1 * side, 0);
    wheels[3] = (-1 * forward, side, 0);
    height = 5;
    touchcount = 0;
    yawangles = (0, angles[1], 0);
    for (i = 0; i < 4; i++) {
        wheel = rotatepoint(wheels[i], yawangles);
        startpoint = origin + wheel;
        endpoint = startpoint + (0, 0, -1 * height - heightoffset);
        startpoint += (0, 0, height - heightoffset);
        trace = bullettrace(startpoint, endpoint, 0, self);
        if (trace[#"fraction"] < 1) {
            touchcount++;
        }
    }
    return touchcount;
}

// Namespace killstreak_vehicle/killstreak_vehicle
// Params 2, eflags: 0x0
// Checksum 0x5935217b, Offset: 0x27d8
// Size: 0x208
function function_90774dda(origin, angles) {
    liftedorigin = origin + (0, 0, 5);
    size = 12;
    height = 15;
    mins = (-1 * size, -1 * size, 0);
    maxs = (size, size, height);
    absmins = liftedorigin + mins;
    absmaxs = liftedorigin + maxs;
    if (boundswouldtelefrag(absmins, absmaxs)) {
        return false;
    }
    startheight = function_e686f80f();
    mask = 1 | 2 | 4;
    trace = physicstrace(liftedorigin, origin + (0, 0, 1), mins, maxs, self, mask);
    if (trace[#"fraction"] < 1) {
        return false;
    }
    size = 2.5;
    height = size * 2;
    mins = (-1 * size, -1 * size, 0);
    maxs = (size, size, height);
    sweeptrace = physicstrace(self.origin + (0, 0, startheight), liftedorigin, mins, maxs, self, mask);
    if (sweeptrace[#"fraction"] < 1) {
        return false;
    }
    return true;
}

