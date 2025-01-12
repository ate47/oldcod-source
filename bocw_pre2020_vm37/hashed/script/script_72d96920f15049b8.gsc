#using script_4721de209091b1a6;
#using scripts\core_common\ai_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\heatseekingmissile;

#namespace namespace_e8c18978;

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 1, eflags: 0x1 linked
// Checksum 0x6e159c72, Offset: 0x358
// Size: 0x13e
function function_70a657d8(bundlename) {
    profilestart();
    clientfield::register("toplayer", "" + #"hash_7c907650b14abbbe", 1, 1, "int");
    clientfield::register("vehicle", "" + #"hash_4ddf67f7aa0f6884", 1, 1, "int");
    clientfield::register("vehicle", "" + #"hash_46646871455cab15", 1, 2, "int");
    clientfield::register("vehicle", "" + #"hash_6cf1a3b26118d892", 1, 1, "int");
    init_shared();
    killstreaks::register_killstreak(bundlename, &activatemaingunner);
    profilestop();
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 0, eflags: 0x1 linked
// Checksum 0x11dc7c70, Offset: 0x4a0
// Size: 0xb4
function function_3675de8b() {
    scene::add_scene_func(#"chopper_gunner_door_open", &function_294e90d4, "play");
    scene::add_scene_func(#"chopper_gunner_door_open", &function_4e4267e0, "done");
    bundle = killstreaks::get_script_bundle("chopper_gunner");
    assert(isdefined(bundle));
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 0, eflags: 0x1 linked
// Checksum 0x850f6da0, Offset: 0x560
// Size: 0xc9a
function function_5160bb1e() {
    assert(!isdefined(level.chopper_gunner));
    profilestart();
    if (is_true(self.isplanting) || is_true(self.isdefusing) || self util::isusingremote() || self iswallrunning() || self oob::isoutofbounds()) {
        profilestop();
        return 0;
    }
    killstreak_id = self killstreakrules::killstreakstart("chopper_gunner", self.team, undefined, 1);
    if (killstreak_id == -1) {
        profilestop();
        return 0;
    }
    bundle = killstreaks::get_script_bundle("chopper_gunner");
    assert(isdefined(bundle));
    spawnpos = level.mapcenter + (0, bundle.var_42d6fcc1, bundle.var_4325e427);
    level.chopper_gunner = spawnvehicle(bundle.ksvehicle, spawnpos, (0, 0, 0), "chopperGunner");
    level.chopper_gunner.identifier_weapon = getweapon("ac130");
    level.chopper_gunner killstreaks::configure_team("chopper_gunner", killstreak_id, self, "helicopter");
    level.chopper_gunner.killstreak_id = killstreak_id;
    level.chopper_gunner.destroyfunc = &function_f1d43cb2;
    level.chopper_gunner.hardpointtype = "chopper_gunner";
    level.chopper_gunner clientfield::set("enemyvehicle", 1);
    level.chopper_gunner vehicle::init_target_group();
    level.chopper_gunner.killstreak_timer_started = 0;
    level.chopper_gunner.allowdeath = 0;
    level.chopper_gunner.var_c31213a5 = 1;
    level.chopper_gunner.playermovedrecently = 0;
    level.chopper_gunner.soundmod = "default_loud";
    if (isdefined(level.registerwithhackertool)) {
        level.chopper_gunner [[ level.registerwithhackertool ]](50, 10000);
    }
    level.chopper_gunner.usage = [];
    level.destructible_callbacks[#"turret_destroyed"] = &function_aecfdb77;
    level.chopper_gunner.shuttingdown = 0;
    level.chopper_gunner.completely_shutdown = 0;
    level.chopper_gunner thread playlockonsoundsthread(self, level.chopper_gunner);
    level.chopper_gunner thread helicopter::wait_for_killed();
    level.chopper_gunner.maxhealth = isdefined(killstreak_bundles::get_max_health("chopper_gunner")) ? killstreak_bundles::get_max_health("chopper_gunner") : 5000;
    level.chopper_gunner.original_health = level.chopper_gunner.maxhealth;
    level.chopper_gunner.health = level.chopper_gunner.maxhealth;
    level.chopper_gunner.damagestate = 0;
    level.chopper_gunner helicopter::function_76f530c7(bundle);
    level.chopper_gunner setcandamage(1);
    target_set(level.chopper_gunner, (0, 0, -100));
    target_setallowhighsteering(level.chopper_gunner, 1);
    level.chopper_gunner.numflares = 1;
    level.chopper_gunner helicopter::create_flare_ent((0, 0, -150));
    level.chopper_gunner thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile(bundle, "death");
    level.chopper_gunner.is_still_valid_target_for_stinger_override = &function_c2bfa7e1;
    level.chopper_gunner thread function_d4896942(bundle);
    level.chopper_gunner thread function_31f9c728(bundle);
    level.chopper_gunner setrotorspeed(1);
    level thread helicopter::function_eca18f00(level.chopper_gunner, bundle.var_f90029e2);
    level.chopper_gunner util::make_sentient();
    level.chopper_gunner.maxvisibledist = 16384;
    level.chopper_gunner function_53d3b37a(bundle);
    level.chopper_gunner.totalrockethits = 0;
    level.chopper_gunner.turretrockethits = 0;
    level.chopper_gunner.overridevehicledamage = &function_77784598;
    self thread namespace_f9b02f80::play_killstreak_start_dialog("chopper_gunner", self.team, killstreak_id);
    level.chopper_gunner namespace_f9b02f80::play_pilot_dialog_on_owner("arrive", "chopper_gunner", killstreak_id);
    level.chopper_gunner thread killstreaks::player_killstreak_threat_tracking("chopper_gunner", 0.866025);
    self stats::function_e24eec31(bundle.ksweapon, #"used", 1);
    self clientfield::set_to_player("" + #"hash_7c907650b14abbbe", 1);
    profilestop();
    if (sessionmodeiszombiesgame() && is_true(level.var_68e3cf24)) {
        assert(isdefined(self.chopper_zone), "<dev string:x38>");
        var_6b3ce0fa = getvehiclenodearray("chopper_gunner_path_start", "targetname");
        foreach (node in var_6b3ce0fa) {
            if (node.script_noteworthy === self.chopper_zone) {
                startnode = node;
                break;
            }
        }
    } else {
        startnode = getvehiclenode("chopper_gunner_path_start", "targetname");
    }
    assert(isdefined(startnode), "<dev string:x56>");
    if (sessionmodeiswarzonegame() && !is_true(level.var_29cfe9dd)) {
        position = self.origin;
        if (isdefined(level.var_dacaad2f) && distance2dsquared(position, level.var_dacaad2f) > level.var_e8fd1435 * level.var_e8fd1435) {
            var_1ce870a0 = vectornormalize(level.var_dacaad2f - position);
            position += vectorscale(var_1ce870a0, level.var_e8fd1435);
        }
        trace = bullettrace(position + (0, 0, 10000), position - (0, 0, 10000), 0, undefined);
        targetpoint = trace[#"fraction"] > 1 ? (position[0], position[1], 0) : trace[#"position"];
        var_b0490eb9 = getheliheightlockheight(position);
        var_6be9958b = targetpoint[2];
        height = var_6be9958b + (var_b0490eb9 - var_6be9958b) * bundle.var_ff73e08c;
        pivot = struct::get("chopper_gunner_pivot", "targetname");
        yaw = function_26e7fb55(position, var_b0490eb9, self.angles);
        location = {#origin:position, #yaw:yaw};
        level.chopper_gunner vehicle::function_bb9b43a9(startnode, pivot.origin, pivot.angles, location, height);
        var_e31d6cb1 = position;
    } else {
        var_e31d6cb1 = level.mapcenter;
    }
    /#
        var_8cdd01c7 = getdvarint(#"hash_4536100039d07f70", 0);
        if (var_8cdd01c7 > 0) {
            level.chopper_gunner pathmove(startnode, (startnode.origin[0], startnode.origin[1], var_8cdd01c7), startnode.angles);
        }
    #/
    level.chopper_gunner thread vehicle::get_on_and_go_path(startnode);
    level.chopper_gunner thread function_696b3380();
    level.chopper_gunner killstreakrules::function_2e6ff61a("chopper_gunner", killstreak_id, {#origin:var_e31d6cb1, #team:level.chopper_gunner.team});
    if (level.gameended === 1) {
        return 0;
    }
    result = self function_dede0607(1);
    return result;
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 3, eflags: 0x5 linked
// Checksum 0x3c7af3a7, Offset: 0x1208
// Size: 0x1b8
function private function_26e7fb55(var_d44b8c3e, var_1838351, startangles) {
    startforward = anglestoforward(startangles);
    startforward = (startforward[0], startforward[1], 0);
    var_51cabd75 = 180 / 30;
    var_c8e01926 = undefined;
    var_37db735d = [];
    var_51c6fb78 = 0;
    forward = startforward;
    angles = startangles;
    var_f4f791a2 = startangles[1];
    while (var_51c6fb78 < var_51cabd75) {
        var_59a518e1 = [];
        var_90aa61b = var_d44b8c3e + vectorscale(forward, -24000);
        var_b0490eb9 = getheliheightlockheight(var_90aa61b);
        var_35637e22 = var_b0490eb9 - var_1838351;
        if (var_35637e22 < 2000) {
            return angles[1];
        }
        if (!isdefined(var_c8e01926) || var_35637e22 < var_c8e01926) {
            var_c8e01926 = var_35637e22;
            var_f4f791a2 = angles[1];
        }
        angles += (0, 30, 0);
        forward = anglestoforward(angles);
        var_51c6fb78++;
        waitframe(1);
    }
    return var_f4f791a2;
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 0, eflags: 0x1 linked
// Checksum 0x1a45241a, Offset: 0x13c8
// Size: 0x142
function function_696b3380() {
    self endon(#"death");
    var_c6ac5940 = 1;
    while (true) {
        if (!var_c6ac5940 && randomint(100) < 10) {
            offsettime = 0.5;
            self pathvariableoffset((0, 0, 90), offsettime);
            wait offsettime - 0.1;
            var_c6ac5940 = 1;
            continue;
        }
        offsettime = randomfloatrange(1, 3);
        var_fbe7ba4a = randomintrange(0, 30);
        var_24962759 = randomintrange(0, 50);
        self pathvariableoffset((0, var_fbe7ba4a, var_24962759), offsettime);
        var_c6ac5940 = 0;
        wait offsettime * 2;
    }
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 1, eflags: 0x1 linked
// Checksum 0x536e2ee6, Offset: 0x1518
// Size: 0x3f0
function function_dede0607(*isowner) {
    assert(isplayer(self));
    choppergunner = level.chopper_gunner;
    choppergunner.occupied = 1;
    self util::setusingremote("chopper_gunner");
    result = self killstreaks::init_ride_killstreak("chopper_gunner");
    if (result != "success") {
        if (result != "disconnect") {
            self killstreaks::clear_using_remote();
        }
        choppergunner.failed2enter = 1;
        choppergunner function_71c46904();
        choppergunner function_f1d43cb2();
        return false;
    }
    self.var_5c5fca5 = 1;
    bundle = killstreaks::get_script_bundle("chopper_gunner");
    assert(isdefined(bundle));
    choppergunner clientfield::set("" + #"hash_4ddf67f7aa0f6884", 1);
    choppergunner thread scene::play(#"chopper_gunner_door_open");
    choppergunner setanim(#"hash_7483c325182bab52");
    wait getanimlength(#"hash_7483c325182bab52");
    choppergunner clearanim(#"hash_7483c325182bab52", 0.2);
    choppergunner clientfield::set("" + #"hash_4ddf67f7aa0f6884", 0);
    if (!isdefined(self)) {
        function_cf58dcdd();
        return false;
    }
    choppergunner usevehicle(self, 2);
    choppergunner.usage[self.entnum] = 1;
    choppergunner thread audio::sndupdatevehiclecontext(1);
    choppergunner thread vehicle::monitor_missiles_locked_on_to_me(self);
    if (choppergunner.killstreak_timer_started) {
        self vehicle::set_vehicle_drivable_time(choppergunner.killstreak_duration, choppergunner.killstreak_end_time);
    } else {
        duration = isdefined(bundle.ksduration) ? bundle.ksduration : 60000;
        self vehicle::set_vehicle_drivable_time(duration, gettime() + duration);
    }
    if (!is_true(level.var_f717967)) {
        choppergunner thread watchplayerexitrequestthread(self);
    }
    self thread watchplayerteamchangethread(choppergunner);
    self setmodellodbias(isdefined(level.mothership_lod_bias) ? level.mothership_lod_bias : 8);
    self givededicatedshadow(choppergunner);
    return true;
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 1, eflags: 0x1 linked
// Checksum 0x96096c1a, Offset: 0x1910
// Size: 0xae
function function_294e90d4(ents) {
    ents[#"gunner"] hidefromplayer(level.chopper_gunner.owner);
    ents[#"fakearms"] hide();
    ents[#"fakearms"] showtoplayer(level.chopper_gunner.owner);
    level.chopper_gunner.gunner = ents[#"gunner"];
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 1, eflags: 0x1 linked
// Checksum 0xeaf57c1e, Offset: 0x19c8
// Size: 0x34
function function_4e4267e0(ents) {
    ents[#"gunner"] linkto(level.chopper_gunner);
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 0, eflags: 0x1 linked
// Checksum 0xc26a1825, Offset: 0x1a08
// Size: 0x4c
function init_shared() {
    callback::on_connect(&onplayerconnect);
    level.chopper_gunner = undefined;
    if (!isdefined(level.var_e8fd1435)) {
        level.var_e8fd1435 = 5000;
    }
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 0, eflags: 0x1 linked
// Checksum 0xd57bff13, Offset: 0x1a60
// Size: 0x2a
function onplayerconnect() {
    if (!isdefined(self.entnum)) {
        self.entnum = self getentitynumber();
    }
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 1, eflags: 0x1 linked
// Checksum 0x9e2bad51, Offset: 0x1a98
// Size: 0x108
function activatemaingunner(*killstreaktype) {
    attempts = 0;
    while (isdefined(level.chopper_gunner)) {
        if (!self killstreakrules::iskillstreakallowed("chopper_gunner", self.team)) {
            return 0;
        }
        attempts++;
        if (attempts > 50) {
            return 0;
        }
        wait 0.1;
    }
    self val::set(#"hash_183e74582795a108", "freezecontrols");
    result = self [[ level.var_2d4792e7 ]]();
    self val::reset(#"hash_183e74582795a108", "freezecontrols");
    if (level.gameended) {
        return 1;
    }
    if (!isdefined(result)) {
        return 0;
    }
    return result;
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 0, eflags: 0x1 linked
// Checksum 0xcc5b8f0a, Offset: 0x1ba8
// Size: 0x68
function function_71c46904() {
    if (!isdefined(self)) {
        return;
    }
    if (self.var_957d409b === 1) {
        return;
    }
    profilestart();
    killstreakrules::killstreakstop("chopper_gunner", self.originalteam, self.killstreak_id);
    self.var_957d409b = 1;
    level.chopper_gunner = undefined;
    profilestop();
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 0, eflags: 0x1 linked
// Checksum 0xfa4ed71a, Offset: 0x1c18
// Size: 0x34
function function_31d18ab9() {
    self endon(#"death");
    wait 5;
    self function_71c46904();
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 1, eflags: 0x1 linked
// Checksum 0xa03207cf, Offset: 0x1c58
// Size: 0xc4
function function_f1d43cb2(doexplosion) {
    if (is_true(doexplosion)) {
        self.var_f91f1564 = 1;
        self function_71c46904();
        function_cf58dcdd(self.owner, 0);
        self helicopter::function_e1058a3e();
        self notify(#"crash_done");
    }
    assert(self.var_957d409b === 1);
    self function_bc344300();
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 0, eflags: 0x1 linked
// Checksum 0x2699b116, Offset: 0x1d28
// Size: 0x84
function function_bc344300() {
    if (isdefined(self.flare_ent)) {
        self.flare_ent delete();
    }
    if (isdefined(self.gunner)) {
        self.gunner delete();
    }
    self helicopter::function_711c140b();
    self deletedelay();
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 0, eflags: 0x1 linked
// Checksum 0x6963bf46, Offset: 0x1db8
// Size: 0x6c
function ontimeoutcallback() {
    if (!is_true(level.var_43da6545) && isdefined(level.chopper_gunner) && isdefined(level.chopper_gunner.owner)) {
        function_cf58dcdd(level.chopper_gunner.owner);
    }
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 2, eflags: 0x1 linked
// Checksum 0x4d2ad80c, Offset: 0x1e30
// Size: 0x5c
function function_c2bfa7e1(ent, *weapon) {
    if (isdefined(weapon.var_7132bbb7)) {
        return false;
    }
    if (weapon.shuttingdown === 1) {
        return false;
    }
    if (weapon.completely_shutdown === 1) {
        return false;
    }
    return true;
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 1, eflags: 0x1 linked
// Checksum 0x7b37f685, Offset: 0x1e98
// Size: 0xda
function function_d4896942(bundle) {
    self endon(#"death");
    self.var_7132bbb7 = undefined;
    while (true) {
        self waittill(#"flare_deployed");
        self playsound(#"hash_713a3ce01967434e");
        self.var_7132bbb7 = 1;
        self namespace_f9b02f80::play_pilot_dialog_on_owner("damageEvaded", "chopper_gunner", self.killstreak_id);
        wait isdefined(bundle.var_2eeb71d2) ? bundle.var_2eeb71d2 : 5;
        self.var_7132bbb7 = undefined;
    }
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 1, eflags: 0x1 linked
// Checksum 0x3965d55d, Offset: 0x1f80
// Size: 0xb8
function function_31f9c728(bundle) {
    self endon(#"death");
    self.var_7132bbb7 = undefined;
    while (true) {
        waitresult = self waittill(#"stinger_fired_at_me");
        if (isdefined(waitresult.projectile)) {
            self childthread function_849819e9(waitresult.projectile, bundle, "exp_incoming_missile");
            self childthread function_6650cc9c(waitresult.projectile, bundle, "uin_ac130_alarm_missile_incoming");
        }
    }
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 3, eflags: 0x1 linked
// Checksum 0x71c247f2, Offset: 0x2040
// Size: 0x1dc
function function_849819e9(missile, bundle, var_61bbac7a) {
    assert(isentity(missile));
    assert(isstruct(bundle));
    assert(isdefined(var_61bbac7a));
    if (!isdefined(self)) {
        return;
    }
    missile endon(#"death");
    var_d1fb4ef3 = isdefined(bundle.var_7d5e1fc0) ? bundle.var_7d5e1fc0 : 0.75;
    while (isdefined(self.owner) && self.owner util::function_63d27d4e("chopper_gunner")) {
        dist = distance(missile.origin, self.origin);
        velocity = missile getvelocity();
        var_d794a748 = vectornormalize(velocity);
        missile_speed = vectordot(var_d794a748, velocity);
        if (missile_speed > 0) {
            if (dist < missile_speed * var_d1fb4ef3) {
                self playsoundtoplayer(var_61bbac7a, self.owner);
                return;
            }
        }
        wait 0.1;
    }
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 3, eflags: 0x1 linked
// Checksum 0xbeb65f00, Offset: 0x2228
// Size: 0x288
function function_6650cc9c(missile, bundle, var_2f984f68) {
    assert(isentity(missile));
    assert(isstruct(bundle));
    assert(isdefined(var_2f984f68));
    if (!isdefined(self)) {
        return;
    }
    missile endon(#"death");
    wait 0.2;
    neardist = isdefined(bundle.var_4004fbc) ? bundle.var_4004fbc : 10;
    fardist = isdefined(bundle.var_364ccfdc) ? bundle.var_364ccfdc : 100;
    range = fardist - neardist;
    if (range < 0) {
        return;
    }
    var_6f2344f0 = isdefined(bundle.var_9fb2ddca) ? bundle.var_9fb2ddca : 0.05;
    var_cd12ce4c = isdefined(bundle.var_6e3967de) ? bundle.var_6e3967de : 0.05;
    dist = undefined;
    while (isdefined(self.owner) && self.owner util::function_63d27d4e("chopper_gunner")) {
        old_dist = dist;
        dist = distance(missile.origin, self.origin);
        var_38fa5914 = isdefined(old_dist) && dist < old_dist;
        if (var_38fa5914) {
            self playsoundtoplayer(var_2f984f68, self.owner);
        }
        var_6ce65309 = (dist - neardist) / range;
        beep_interval = lerpfloat(var_6f2344f0, var_cd12ce4c, var_6ce65309);
        wait beep_interval;
    }
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 1, eflags: 0x1 linked
// Checksum 0xc3381220, Offset: 0x24b8
// Size: 0x104
function watchplayerteamchangethread(choppergunner) {
    choppergunner notify(#"hash_1c0d4b0d44e3517");
    choppergunner endon(#"hash_1c0d4b0d44e3517", #"death");
    assert(isplayer(self));
    player = self;
    player endon(#"gunner_left");
    player waittill(#"joined_team", #"disconnect", #"joined_spectators");
    ownerleft = choppergunner.ownerentnum == player.entnum;
    level thread function_cf58dcdd(player);
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 1, eflags: 0x1 linked
// Checksum 0xbe7d8b2, Offset: 0x25c8
// Size: 0x15a
function watchplayerexitrequestthread(player) {
    player notify(#"watchplayerexitrequestthread_singleton");
    player endon(#"watchplayerexitrequestthread_singleton");
    assert(isplayer(player));
    level endon(#"game_ended");
    player endon(#"disconnect", #"gunner_left");
    self endon(#"death");
    while (true) {
        timeused = 0;
        while (player usebuttonpressed()) {
            timeused += 0.05;
            if (timeused > 0.25) {
                self namespace_f9b02f80::play_pilot_dialog_on_owner("remoteOperatorRemoved", "chopper_gunner", self.killstreak_id);
                player thread function_cf58dcdd(player);
                return;
            }
            waitframe(1);
        }
        waitframe(1);
    }
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 3, eflags: 0x1 linked
// Checksum 0x448b9edf, Offset: 0x2730
// Size: 0x1f4
function function_bfb33872(choppergunner, eattacker, weapon) {
    if (target_istarget(choppergunner)) {
        target_remove(choppergunner);
    }
    if (issentient(choppergunner)) {
        choppergunner function_60d50ea4();
    }
    choppergunner.shuttingdown = 1;
    eattacker = self [[ level.figure_out_attacker ]](eattacker);
    if (isdefined(eattacker) && (!isdefined(choppergunner.owner) || choppergunner.owner util::isenemyplayer(eattacker))) {
        luinotifyevent(#"player_callout", 2, #"hash_5f3bf967cd47a97f", eattacker.entnum);
        challenges::destroyedaircraft(eattacker, weapon, 1, 1);
        eattacker challenges::addflyswatterstat(weapon, choppergunner);
        choppergunner killstreaks::function_73566ec7(eattacker, weapon, choppergunner.owner);
        choppergunner namespace_f9b02f80::play_destroyed_dialog_on_owner("chopper_gunner", choppergunner.killstreak_id);
        eattacker battlechatter::function_eebf94f6("chopper_gunner");
        eattacker stats::function_e24eec31(weapon, #"hash_3f3d8a93c372c67d", 1);
    }
    choppergunner thread function_80ae938e();
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 6, eflags: 0x1 linked
// Checksum 0x507eddb5, Offset: 0x2930
// Size: 0x4c
function function_aecfdb77(*brokennotify, eattacker, weapon, *pieceindex, *dir, *mod) {
    function_bfb33872(self, dir, mod);
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 2, eflags: 0x1 linked
// Checksum 0xb6e690a, Offset: 0x2988
// Size: 0x350
function function_cf58dcdd(player, var_a6648780 = 1) {
    profilestart();
    if (isbot(player)) {
        player ai::set_behavior_attribute("control", "commander");
    }
    if (isdefined(player)) {
        player vehicle::stop_monitor_missiles_locked_on_to_me();
        if (is_true(player.usingvehicle)) {
            player unlink();
        }
        player setmodellodbias(0);
        player givededicatedshadow(player);
        player notify(#"gunner_left");
        player.var_5c5fca5 = undefined;
        player killstreaks::clear_using_remote();
        player clientfield::set_to_player("" + #"hash_7c907650b14abbbe", 0);
    }
    if (!isdefined(level.chopper_gunner) || level.chopper_gunner.completely_shutdown === 1) {
        profilestop();
        return;
    }
    level.chopper_gunner clientfield::set("vehicletransition", 0);
    level.chopper_gunner.shuttingdown = 1;
    level.chopper_gunner.occupied = 0;
    level.chopper_gunner.hardpointtype = "chopper_gunner";
    level.chopper_gunner thread function_31d18ab9();
    if (target_istarget(level.chopper_gunner)) {
        target_remove(level.chopper_gunner);
    }
    if (issentient(level.chopper_gunner)) {
        level.chopper_gunner function_60d50ea4();
    }
    level.chopper_gunner vehicle::get_off_path();
    level.chopper_gunner thread audio::sndupdatevehiclecontext(0);
    if (var_a6648780) {
        planedir = anglestoforward(level.chopper_gunner.angles);
        var_15f570c1 = level.chopper_gunner.origin + vectorscale(planedir, 30000);
        level.chopper_gunner thread helicopter::heli_leave(var_15f570c1, 1);
    }
    level.chopper_gunner.completely_shutdown = 1;
    level.chopper_gunner.shuttingdown = 0;
    profilestop();
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 0, eflags: 0x1 linked
// Checksum 0x37d852c1, Offset: 0x2ce0
// Size: 0xc4
function function_ece62582() {
    if (isdefined(self) && isdefined(self.owner)) {
        org = self gettagorigin("tag_barrel");
        magnitude = 0.3;
        duration = 2;
        radius = 500;
        v_pos = self.origin;
        earthquake(magnitude, duration, org, 500);
        self playsound(#"hash_5314ffef2464b607");
    }
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 15, eflags: 0x1 linked
// Checksum 0xe6ef75e0, Offset: 0x2db0
// Size: 0x4bc
function function_77784598(*einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, *shitloc, *vdamageorigin, *psoffsettime, *damagefromunderneath, *modelindex, *partname, *vsurfacenormal) {
    if (damagefromunderneath == "MOD_TRIGGER_HURT") {
        return 0;
    }
    if (self.shuttingdown) {
        return 0;
    }
    vdamageorigin = self killstreaks::ondamageperweapon("chopper_gunner", shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, 0, undefined, 1, 1);
    if (vdamageorigin == 0) {
        return 0;
    }
    handleasrocketdamage = damagefromunderneath == "MOD_PROJECTILE" || damagefromunderneath == "MOD_EXPLOSIVE";
    if (modelindex.statindex == level.weaponshotgunenergy.statindex || modelindex.statindex == level.weaponpistolenergy.statindex) {
        handleasrocketdamage = 0;
    }
    if (handleasrocketdamage) {
        self function_ece62582();
        self playsound(#"hash_ddcd9d25e056016");
    }
    var_902cbab5 = self.health - vdamageorigin;
    if (self.damagestate < 1 && var_902cbab5 <= self.maxhealth * 0.75) {
        var_5aca61fb = "damaged";
        self.damagestate = 1;
        if (isdefined(self.var_5efaff3e)) {
            self clientfield::set("" + #"hash_46646871455cab15", 1);
        }
    }
    if (self.damagestate < 2 && self.health <= self.maxhealth * 0.35) {
        var_5aca61fb = "damaged1";
        self.damagestate = 2;
        if (isdefined(self.var_ba5009c3)) {
            self clientfield::set("" + #"hash_46646871455cab15", 2);
        }
    }
    if (isdefined(var_5aca61fb)) {
        self namespace_f9b02f80::play_pilot_dialog_on_owner(var_5aca61fb, "chopper_gunner", self.killstreak_id);
    }
    if (self.health > 0 && var_902cbab5 <= 0 && !self.shuttingdown) {
        self.shuttingdown = 1;
        if (!isdefined(self.destroyscoreeventgiven) && isdefined(shitloc) && (!isdefined(self.owner) || self.owner util::isenemyplayer(shitloc))) {
            shitloc = self [[ level.figure_out_attacker ]](shitloc);
            luinotifyevent(#"player_callout", 2, #"hash_5f3bf967cd47a97f", shitloc.entnum);
            self namespace_f9b02f80::play_destroyed_dialog_on_owner("chopper_gunner", self.killstreak_id);
            shitloc battlechatter::function_eebf94f6("chopper_gunner");
            challenges::destroyedaircraft(shitloc, modelindex, 1, 1);
            shitloc challenges::addflyswatterstat(modelindex, self);
            shitloc stats::function_e24eec31(modelindex, #"hash_3f3d8a93c372c67d", 1);
            self.destroyscoreeventgiven = 1;
        }
        self.var_d02ddb8e = modelindex;
        self thread function_80ae938e(partname, vsurfacenormal);
        return 0;
    }
    return vdamageorigin;
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 2, eflags: 0x1 linked
// Checksum 0x55d70be0, Offset: 0x3278
// Size: 0x114
function function_80ae938e(point, dir) {
    if (self.leave_by_damage_initiated === 1) {
        return;
    }
    self.leave_by_damage_initiated = 1;
    if (target_istarget(self)) {
        target_remove(self);
    }
    if (issentient(self)) {
        self function_60d50ea4();
    }
    self thread vehicle_death::helicopter_crash(point, dir, 2.75);
    self clientfield::set("" + #"hash_6cf1a3b26118d892", 1);
    self waittilltimeout(2.25, #"death");
    function_cf58dcdd(self.owner, 0);
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 2, eflags: 0x1 linked
// Checksum 0x312a034, Offset: 0x3398
// Size: 0x1f0
function playlockonsoundsthread(player, heli) {
    player endon(#"disconnect", #"gunner_left");
    heli endon(#"death", #"crashing", #"leaving");
    heli.locksounds = spawn("script_model", heli.origin);
    wait 0.1;
    heli.locksounds linkto(heli, "tag_origin");
    while (true) {
        heli waittill(#"locking on");
        while (true) {
            if (enemyislocking(heli)) {
                heli.locksounds playsoundtoplayer(#"hash_fa62d8cec85b1a0", player);
                wait 0.125;
            }
            if (enemylockedon(heli)) {
                heli.locksounds playsoundtoplayer(#"hash_1683ed70beb3f2", player);
                wait 0.125;
            }
            if (!enemyislocking(heli) && !enemylockedon(heli)) {
                heli.locksounds stopsounds();
                break;
            }
        }
    }
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 1, eflags: 0x1 linked
// Checksum 0xcae2b0ec, Offset: 0x3590
// Size: 0x28
function enemyislocking(heli) {
    return isdefined(heli.locking_on) && heli.locking_on;
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 1, eflags: 0x1 linked
// Checksum 0x5d51279b, Offset: 0x35c0
// Size: 0x28
function enemylockedon(heli) {
    return isdefined(heli.locked_on) && heli.locked_on;
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 1, eflags: 0x1 linked
// Checksum 0xb614225d, Offset: 0x35f0
// Size: 0xdc
function function_53d3b37a(bundle) {
    self.killstreak_duration = isdefined(bundle.ksduration) ? bundle.ksduration : 60000;
    self.killstreak_end_time = gettime() + self.killstreak_duration;
    self.killstreakendtime = int(self.killstreak_end_time);
    self thread killstreaks::waitfortimeout("chopper_gunner", self.killstreak_duration, &ontimeoutcallback, "delete", "death");
    self.killstreak_timer_started = 1;
    self updatedrivabletimeforalloccupants(self.killstreak_duration, self.killstreak_end_time);
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 2, eflags: 0x1 linked
// Checksum 0x3b8709dc, Offset: 0x36d8
// Size: 0x3c
function updatedrivabletimeforalloccupants(duration_ms, end_time_ms) {
    if (isdefined(self.owner)) {
        self.owner vehicle::set_vehicle_drivable_time(duration_ms, end_time_ms);
    }
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 0, eflags: 0x0
// Checksum 0xe2539f63, Offset: 0x3720
// Size: 0x64
function function_631f02c5() {
    self endon(#"killed");
    self.var_a1719a05 = (isdefined(self.var_a1719a05) ? self.var_a1719a05 : 0) + 1;
    wait 2.5;
    if (!isdefined(self)) {
        return;
    }
    self function_568f6426();
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 0, eflags: 0x1 linked
// Checksum 0x8e2bc475, Offset: 0x3790
// Size: 0xec
function function_568f6426() {
    switch (self.var_a1719a05) {
    case 0:
        break;
    case 1:
        dialogkey = "kill1";
        break;
    case 2:
        dialogkey = "kill2";
        break;
    case 3:
        dialogkey = "kill3";
        break;
    default:
        dialogkey = "killMultiple";
        break;
    }
    self.var_a1719a05 = 0;
    if (isdefined(dialogkey)) {
        self namespace_f9b02f80::play_pilot_dialog_on_owner(dialogkey, "chopper_gunner", self.killstreak_id);
    }
}

