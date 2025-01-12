#using script_4721de209091b1a6;
#using scripts\core_common\ai_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\remote_weapons;
#using scripts\weapons\hacker_tool;
#using scripts\weapons\heatseekingmissile;

#namespace namespace_2d34cefc;

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0x5024816a, Offset: 0x4b0
// Size: 0xee
function function_70a657d8(var_9dedc222) {
    profilestart();
    init_shared();
    killstreaks::register_killstreak(var_9dedc222, &activatemaingunner);
    killstreaks::function_94c74046("ac130");
    killcam::function_4789a39a(#"hash_17df39d53492b0bf", &function_91ba5c69);
    killcam::function_4789a39a(#"hash_7b24d0d0d2823bca", &function_91ba5c69);
    killcam::function_4789a39a(#"ac130_chaingun", &function_91ba5c69);
    profilestop();
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 0, eflags: 0x1 linked
// Checksum 0xecfb12e0, Offset: 0x5a8
// Size: 0x108
function function_3675de8b() {
    bundle = level.killstreaks[#"ac130"].script_bundle;
    assert(isdefined(bundle));
    var_d57617dd = isdefined(bundle.var_dff95af) ? bundle.var_dff95af : 300;
    level.var_89350618 = killstreaks::function_f3875fb0(level.var_98fe5b4a, isdefined(level.var_b34c8ec8) ? level.var_b34c8ec8 : 9000, var_d57617dd, 1);
    if (isdefined(level.var_1b900c1d)) {
        [[ level.var_1b900c1d ]](getweapon("ac130"), &function_bff5c062);
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 0, eflags: 0x1 linked
// Checksum 0xb4e8faee, Offset: 0x6b8
// Size: 0x9f2
function spawnac130() {
    player = self;
    assert(!isdefined(level.ac130));
    profilestart();
    if (is_true(player.isplanting) || is_true(player.isdefusing) || player util::isusingremote() || player iswallrunning() || player oob::isoutofbounds()) {
        profilestop();
        return 0;
    }
    killstreak_id = player killstreakrules::killstreakstart("ac130", player.team, undefined, 1);
    if (killstreak_id == -1) {
        profilestop();
        return 0;
    }
    bundle = level.killstreaks[#"ac130"].script_bundle;
    assert(isdefined(bundle));
    spawnpos = level.mapcenter + (5000, 5000, 8000);
    level.ac130 = spawnvehicle(bundle.ksvehicle, spawnpos, (0, 0, 0), "ac130");
    level.ac130.identifier_weapon = getweapon("ac130");
    level.ac130 killstreaks::configure_team("ac130", killstreak_id, player, "helicopter");
    level.ac130 killstreak_hacking::enable_hacking("ac130", &hackedprefunction, &hackedpostfunction);
    level.ac130.killstreak_id = killstreak_id;
    level.ac130.destroyfunc = &function_a51c391f;
    level.ac130.hardpointtype = "ac130";
    level.ac130 clientfield::set("enemyvehicle", 1);
    level.ac130 vehicle::init_target_group();
    level.ac130.killstreak_timer_started = 0;
    level.ac130.allowdeath = 0;
    level.ac130.playermovedrecently = 0;
    level.ac130.soundmod = "default_loud";
    level.ac130 hacker_tool::registerwithhackertool(50, 10000);
    level.ac130.usage = [];
    level.destructible_callbacks[#"turret_destroyed"] = &vtoldestructiblecallback;
    level.ac130.shuttingdown = 0;
    level.ac130.completely_shutdown = 0;
    level.ac130 thread playlockonsoundsthread(player, level.ac130);
    level.ac130 thread helicopter::wait_for_killed();
    level.ac130.maxhealth = isdefined(killstreak_bundles::get_max_health("ac130")) ? killstreak_bundles::get_max_health("ac130") : 5000;
    level.ac130.original_health = level.ac130.maxhealth;
    level.ac130.health = level.ac130.maxhealth;
    level.ac130.damagetaken = 0;
    level.ac130 thread helicopter::heli_health("ac130");
    level.ac130 setcandamage(1);
    target_set(level.ac130, (0, 0, -100));
    target_setallowhighsteering(level.ac130, 1);
    level.ac130.numflares = 1;
    level.ac130.fx_flare = bundle.var_22ab738b;
    level.ac130 helicopter::create_flare_ent((0, 0, -150));
    level.ac130 thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile(bundle, "death");
    level.ac130.is_still_valid_target_for_stinger_override = &function_c2bfa7e1;
    level.ac130 thread function_d4896942(bundle);
    level.ac130 thread function_31f9c728(bundle);
    level.ac130 setrotorspeed(1);
    level.ac130 util::make_sentient();
    level.ac130.maxvisibledist = 16384;
    level.ac130 function_53d3b37a(bundle);
    level.ac130.totalrockethits = 0;
    level.ac130.turretrockethits = 0;
    level.ac130.overridevehicledamage = &function_dea7ec6a;
    level.ac130.hackedhealthupdatecallback = &function_7cdff810;
    level.ac130.detonateviaemp = &helicoptedetonateviaemp;
    player thread namespace_f9b02f80::play_killstreak_start_dialog("ac130", player.team, killstreak_id);
    level.ac130 namespace_f9b02f80::play_pilot_dialog_on_owner("arrive", "ac130", killstreak_id);
    level.ac130 thread killstreaks::player_killstreak_threat_tracking("ac130", 0.984808);
    player stats::function_e24eec31(bundle.ksweapon, #"used", 1);
    player thread waitforvtolshutdownthread(level.ac130);
    var_e47f3d4a = getdvarfloat(#"hash_29a9f2bae7599f46", -27);
    radius = isdefined(bundle.var_1f9faa0c) ? bundle.var_1f9faa0c : isdefined(level.var_8db9ea19) ? level.var_8db9ea19 : 12000;
    if (sessionmodeiswarzonegame()) {
        var_b0490eb9 = getheliheightlockheight(player.origin);
        trace = groundtrace((player.origin[0], player.origin[1], var_b0490eb9), player.origin - (0, 0, 5000), 0, level.ac130);
        var_6be9958b = trace[#"position"][2];
        var_b7d4ae34 = var_6be9958b + (var_b0490eb9 - var_6be9958b) * bundle.var_ff73e08c;
        level.var_89350618.origin = (player.origin[0], player.origin[1], var_b7d4ae34);
        level.var_e2a77deb = player.origin;
    }
    if (isdefined(level.var_def002d)) {
        level.ac130 killstreaks::function_d7123898(level.var_89350618, level.var_def002d, 1, var_e47f3d4a);
    } else {
        level.ac130 killstreaks::function_67d553c4(level.var_89350618, radius, 0, 1, var_e47f3d4a);
    }
    profilestop();
    if (level.gameended === 1) {
        return 0;
    }
    result = player function_4d980695(1);
    return result;
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0xa2bff14f, Offset: 0x10b8
// Size: 0x400
function function_4d980695(*isowner) {
    assert(isplayer(self));
    player = self;
    level.ac130.occupied = 1;
    player util::setusingremote("ac130");
    player.ignoreempjammed = 1;
    result = player killstreaks::init_ride_killstreak("ac130");
    player.ignoreempjammed = 0;
    if (result != "success") {
        if (result != "disconnect") {
            player killstreaks::clear_using_remote();
        }
        level.ac130.failed2enter = 1;
        level.ac130 notify(#"ac130_shutdown");
        return false;
    }
    bundle = level.killstreaks[#"ac130"].script_bundle;
    assert(isdefined(bundle));
    var_fbc8efd2 = 1;
    if (isdefined(level.var_36cf2603)) {
        var_fbc8efd2 = level.var_36cf2603;
    }
    level.ac130 usevehicle(player, var_fbc8efd2);
    level.ac130.usage[player.entnum] = 1;
    level.ac130 thread audio::sndupdatevehiclecontext(1);
    level.ac130 thread vehicle::monitor_missiles_locked_on_to_me(player);
    level.ac130 thread function_5cdcce1e(player);
    if (level.ac130.killstreak_timer_started) {
        player vehicle::set_vehicle_drivable_time(level.ac130.killstreak_duration, level.ac130.killstreak_end_time);
    } else {
        duration = isdefined(bundle.ksduration) ? bundle.ksduration : 60000;
        player vehicle::set_vehicle_drivable_time(duration, gettime() + duration);
    }
    if (!is_true(level.var_dab73f4a)) {
        level.ac130 thread watchplayerexitrequestthread(player);
    }
    player thread watchplayerteamchangethread(level.ac130);
    player setmodellodbias(isdefined(level.mothership_lod_bias) ? level.mothership_lod_bias : 8);
    player givededicatedshadow(level.ac130);
    player clientfield::set_player_uimodel("vehicle.inAC130", 1);
    player clientfield::set_to_player("inAC130", 1);
    player killstreaks::thermal_glow(1);
    player thread function_41f0e35b(level.ac130);
    return true;
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 0, eflags: 0x1 linked
// Checksum 0xd5d428ba, Offset: 0x14c0
// Size: 0xf4
function init_shared() {
    callback::on_connect(&onplayerconnect);
    level thread waitforgameendthread();
    level.ac130 = undefined;
    clientfield::register_clientuimodel("vehicle.selectedWeapon", 1, 2, "int", 0);
    clientfield::register_clientuimodel("vehicle.flareCount", 1, 2, "int", 0);
    clientfield::register_clientuimodel("vehicle.inAC130", 1, 1, "int", 0);
    clientfield::register("toplayer", "inAC130", 1, 1, "int");
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 2, eflags: 0x1 linked
// Checksum 0xa3d833c3, Offset: 0x15c0
// Size: 0x7c
function function_bff5c062(var_2f03ffd6, attackingplayer) {
    var_2f03ffd6 killstreaks::function_73566ec7(attackingplayer, getweapon(#"gadget_icepick"), var_2f03ffd6.owner);
    var_2f03ffd6.destroyscoreeventgiven = 1;
    function_8721028e(var_2f03ffd6.owner, 1, 1);
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 0, eflags: 0x1 linked
// Checksum 0x9c4460d2, Offset: 0x1648
// Size: 0x2a
function onplayerconnect() {
    if (!isdefined(self.entnum)) {
        self.entnum = self getentitynumber();
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0x310efed1, Offset: 0x1680
// Size: 0x118
function activatemaingunner(*killstreaktype) {
    player = self;
    attempts = 0;
    while (isdefined(level.ac130)) {
        if (!player killstreakrules::iskillstreakallowed("ac130", player.team)) {
            return 0;
        }
        attempts++;
        if (attempts > 50) {
            return 0;
        }
        wait 0.1;
    }
    player val::set(#"spawnac130", "freezecontrols");
    result = player [[ level.var_f987766c ]]();
    player val::reset(#"spawnac130", "freezecontrols");
    if (level.gameended) {
        return 1;
    }
    if (!isdefined(result)) {
        return 0;
    }
    return result;
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0x922d9d18, Offset: 0x17a0
// Size: 0xd4
function hackedprefunction(*hacker) {
    heligunner = self;
    heligunner.owner unlink();
    level.ac130 clientfield::set("vehicletransition", 0);
    heligunner.owner setmodellodbias(0);
    heligunner.owner notify(#"gunner_left");
    heligunner.owner killstreaks::clear_using_remote();
    heligunner.owner vehicle::stop_monitor_missiles_locked_on_to_me();
    heligunner makevehicleunusable();
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0x43a38fde, Offset: 0x1880
// Size: 0x1ca
function hackedpostfunction(hacker) {
    heligunner = self;
    heligunner clientfield::set("enemyvehicle", 2);
    heligunner makevehicleusable();
    heligunner usevehicle(hacker, 1);
    level.ac130 clientfield::set("vehicletransition", 1);
    heligunner thread vehicle::monitor_missiles_locked_on_to_me(hacker);
    heligunner thread watchplayerexitrequestthread(hacker);
    hacker setmodellodbias(isdefined(level.mothership_lod_bias) ? level.mothership_lod_bias : 8);
    heligunner.owner givededicatedshadow(level.ac130);
    hacker thread watchplayerteamchangethread(heligunner);
    hacker killstreaks::set_killstreak_delay_killcam("ac130");
    if (heligunner.killstreak_timer_started) {
        heligunner.killstreak_duration = heligunner killstreak_hacking::get_hacked_timeout_duration_ms();
        heligunner.killstreak_end_time = hacker killstreak_hacking::set_vehicle_drivable_time_starting_now(heligunner);
        heligunner.killstreakendtime = int(heligunner.killstreak_end_time);
        return;
    }
    heligunner.killstreak_timer_start_using_hacked_time = 1;
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 0, eflags: 0x1 linked
// Checksum 0x8217cc5a, Offset: 0x1a58
// Size: 0x82
function function_7cdff810() {
    ac130 = self;
    if (ac130.shuttingdown == 1) {
        return;
    }
    hackedhealth = killstreak_bundles::get_hacked_health("ac130");
    assert(isdefined(hackedhealth));
    if (ac130.health > hackedhealth) {
        ac130.health = hackedhealth;
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 0, eflags: 0x1 linked
// Checksum 0xb9387b83, Offset: 0x1ae8
// Size: 0x6c
function waitforgameendthread() {
    level waittill(#"game_ended");
    if (isdefined(level.ac130) && isdefined(level.ac130.owner)) {
        function_8721028e(level.ac130.owner, 1);
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0xb64c6885, Offset: 0x1b60
// Size: 0x1ba
function waitforvtolshutdownthread(ac130) {
    waitresult = ac130 waittill(#"ac130_shutdown");
    if (!isdefined(ac130)) {
        return;
    }
    if (ac130.completely_shutdown !== 1) {
        attacker = waitresult.attacker;
        if (isdefined(attacker)) {
            luinotifyevent(#"player_callout", 2, #"hash_20aa28bee9cfdd61", attacker.entnum);
        }
        if (target_istarget(ac130)) {
            target_remove(ac130);
        }
        if (issentient(ac130)) {
            ac130 function_60d50ea4();
        }
        if (isdefined(ac130.flare_ent)) {
            ac130.flare_ent delete();
            ac130.flare_ent = undefined;
        }
        ac130 function_cc756b8d();
        function_8721028e(ac130.owner, 1);
    }
    assert(ac130.var_957d409b === 1);
    ac130 deletedelay();
    ac130 = undefined;
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 0, eflags: 0x1 linked
// Checksum 0x1bcd5d09, Offset: 0x1d28
// Size: 0x68
function function_cc756b8d() {
    if (!isdefined(self)) {
        return;
    }
    if (self.var_957d409b === 1) {
        return;
    }
    profilestart();
    killstreakrules::killstreakstop("ac130", self.originalteam, self.killstreak_id);
    self.var_957d409b = 1;
    level.ac130 = undefined;
    profilestop();
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 0, eflags: 0x1 linked
// Checksum 0x74118c79, Offset: 0x1d98
// Size: 0x64
function function_31d18ab9() {
    self endon(#"death");
    self killstreakrules::function_d9f8f32b("ac130");
    wait isdefined(5) ? 5 : 0;
    self function_cc756b8d();
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 0, eflags: 0x1 linked
// Checksum 0xee054c1f, Offset: 0x1e08
// Size: 0x28
function function_a51c391f() {
    ac130 = self;
    ac130 notify(#"ac130_shutdown");
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 0, eflags: 0x1 linked
// Checksum 0x3f522acd, Offset: 0x1e38
// Size: 0x74
function ontimeoutcallback() {
    if (!is_true(level.var_43da6545) && isdefined(level.ac130) && isdefined(level.ac130.owner)) {
        function_8721028e(level.ac130.owner, 1);
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 2, eflags: 0x1 linked
// Checksum 0xe81e94bc, Offset: 0x1eb8
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

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0x36c91332, Offset: 0x1f20
// Size: 0xfa
function function_d4896942(bundle) {
    ac130 = self;
    ac130 endon(#"death", #"ac130_shutdown");
    ac130.var_7132bbb7 = undefined;
    while (true) {
        ac130 waittill(#"flare_deployed");
        ac130 playsound(#"hash_713a3ce01967434e");
        ac130.var_7132bbb7 = 1;
        self namespace_f9b02f80::play_pilot_dialog_on_owner("damageEvaded", "ac130", self.killstreak_id);
        wait isdefined(bundle.var_2eeb71d2) ? bundle.var_2eeb71d2 : 5;
        ac130.var_7132bbb7 = undefined;
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0x6c601c67, Offset: 0x2028
// Size: 0xe0
function function_31f9c728(bundle) {
    ac130 = self;
    ac130 endon(#"death", #"ac130_shutdown");
    ac130.var_7132bbb7 = undefined;
    while (true) {
        waitresult = ac130 waittill(#"stinger_fired_at_me");
        if (isdefined(waitresult.projectile)) {
            ac130 childthread function_849819e9(waitresult.projectile, bundle, "exp_incoming_missile");
            ac130 childthread function_6650cc9c(waitresult.projectile, bundle, "uin_ac130_alarm_missile_incoming");
        }
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 3, eflags: 0x1 linked
// Checksum 0x19d06dd4, Offset: 0x2110
// Size: 0x1ec
function function_849819e9(missile, bundle, var_61bbac7a) {
    assert(isentity(missile));
    assert(isstruct(bundle));
    assert(isdefined(var_61bbac7a));
    ac130 = self;
    if (!isdefined(ac130)) {
        return;
    }
    missile endon(#"death");
    var_d1fb4ef3 = isdefined(bundle.var_7d5e1fc0) ? bundle.var_7d5e1fc0 : 0.75;
    while (isdefined(ac130.owner) && ac130.owner util::function_63d27d4e("ac130")) {
        dist = distance(missile.origin, ac130.origin);
        velocity = missile getvelocity();
        var_d794a748 = vectornormalize(velocity);
        missile_speed = vectordot(var_d794a748, velocity);
        if (missile_speed > 0) {
            if (dist < missile_speed * var_d1fb4ef3) {
                ac130 playsoundtoplayer(var_61bbac7a, ac130.owner);
                return;
            }
        }
        wait 0.1;
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 3, eflags: 0x1 linked
// Checksum 0x2f62438, Offset: 0x2308
// Size: 0x298
function function_6650cc9c(missile, bundle, var_2f984f68) {
    assert(isentity(missile));
    assert(isstruct(bundle));
    assert(isdefined(var_2f984f68));
    ac130 = self;
    if (!isdefined(ac130)) {
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
    while (isdefined(ac130.owner) && ac130.owner util::function_63d27d4e("ac130")) {
        old_dist = dist;
        dist = distance(missile.origin, ac130.origin);
        var_38fa5914 = isdefined(old_dist) && dist < old_dist;
        if (var_38fa5914) {
            ac130 playsoundtoplayer(var_2f984f68, ac130.owner);
        }
        var_6ce65309 = (dist - neardist) / range;
        beep_interval = lerpfloat(var_6f2344f0, var_cd12ce4c, var_6ce65309);
        wait beep_interval;
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0x3abd5933, Offset: 0x25a8
// Size: 0x110
function watchplayerteamchangethread(ac130) {
    ac130 notify(#"mothership_team_change");
    ac130 endon(#"mothership_team_change");
    assert(isplayer(self));
    player = self;
    player endon(#"gunner_left");
    player waittill(#"joined_team", #"disconnect", #"joined_spectators");
    ownerleft = ac130.ownerentnum == player.entnum;
    player thread function_8721028e(player, ownerleft);
    if (ownerleft) {
        ac130 notify(#"ac130_shutdown");
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0x6df91a16, Offset: 0x26c0
// Size: 0x1ba
function watchplayerexitrequestthread(player) {
    player notify(#"watchplayerexitrequestthread_singleton");
    player endon(#"watchplayerexitrequestthread_singleton");
    assert(isplayer(player));
    ac130 = self;
    level endon(#"game_ended");
    player endon(#"disconnect", #"gunner_left");
    ac130 endon(#"death");
    owner = ac130.ownerentnum == player.entnum;
    while (true) {
        timeused = 0;
        while (player usebuttonpressed()) {
            timeused += float(function_60d95f53()) / 1000;
            if (timeused > 0.25) {
                ac130 namespace_f9b02f80::play_pilot_dialog_on_owner("remoteOperatorRemoved", "ac130", ac130.killstreak_id);
                player thread function_8721028e(player, owner, 0, 1);
                return;
            }
            waitframe(1);
        }
        waitframe(1);
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 2, eflags: 0x1 linked
// Checksum 0xe116aa8, Offset: 0x2888
// Size: 0x156
function cantargetplayer(player, *hardpointtype) {
    if (!isalive(hardpointtype) || hardpointtype.sessionstate != "playing") {
        return false;
    }
    if (hardpointtype.ignoreme === 1) {
        return false;
    }
    if (hardpointtype isnotarget()) {
        return false;
    }
    if (hardpointtype hasperk(#"hash_37f82f1d672c4870")) {
        return false;
    }
    if (!isdefined(hardpointtype.team)) {
        return false;
    }
    if (!util::function_fbce7263(hardpointtype.team, self.team)) {
        return false;
    }
    if (hardpointtype.team == #"spectator") {
        return false;
    }
    if (isdefined(hardpointtype.spawntime) && float(gettime() - hardpointtype.spawntime) / 1000 <= level.heli_target_spawnprotection) {
        return false;
    }
    return true;
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 2, eflags: 0x1 linked
// Checksum 0x763684d9, Offset: 0x29e8
// Size: 0x232
function function_7ec0bdc(player, ac130) {
    ac130 endon(#"death", #"ac130_shutdown");
    player endon(#"disconnect");
    targets = [];
    players = level.players;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (self cantargetplayer(player)) {
            if (isdefined(player)) {
                targets[targets.size] = player;
            }
        }
    }
    if (targets.size == 1) {
        return targets[0];
    }
    if (targets.size > 1) {
        foreach (target in targets) {
            killstreaks::update_player_threat(target);
        }
        highest = 0;
        currenttarget = undefined;
        foreach (target in targets) {
            if (isdefined(target.threatlevel) && target.threatlevel > highest) {
                highest = target.threatlevel;
                currenttarget = target;
            }
        }
        return currenttarget;
    }
    return undefined;
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0x3754e7f4, Offset: 0x2c28
// Size: 0x22
function function_4f178939(*ac130) {
    return randomintrangeinclusive(0, 3);
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0xe52959bf, Offset: 0x2c58
// Size: 0x22
function function_ce953cb1(*ac130) {
    return randomintrange(5, 10);
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 2, eflags: 0x1 linked
// Checksum 0x3b27fdba, Offset: 0x2c88
// Size: 0x198
function function_a514a080(player, ac130) {
    ac130 endon(#"death", #"ac130_shutdown");
    player endon(#"disconnect");
    ac130.var_7917e5a1 = 1;
    while (true) {
        target = function_7ec0bdc(player, ac130);
        if (isdefined(target)) {
            turretindex = function_4f178939(ac130);
            burstcount = function_ce953cb1(ac130);
            for (i = 0; i < burstcount; i++) {
                ac130 turretsettarget(0, target);
                ac130 fireweapon(turretindex, target, (randomintrange(10, 30), randomintrange(10, 30), randomintrange(10, 30)), ac130.owner);
                wait 0.2;
            }
        }
        wait randomintrange(3, 5);
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0x4f863950, Offset: 0x2e28
// Size: 0xfc
function function_41f0e35b(ac130) {
    ac130 endon(#"death", #"ac130_shutdown");
    self endon(#"disconnect");
    wait 0.1;
    var_74a46de6 = ac130 function_90d45d34(0);
    view_pos = self getplayercamerapos();
    var_a120a51b = level.mapcenter;
    if (isdefined(level.var_e2a77deb)) {
        var_a120a51b = level.var_e2a77deb;
    }
    self setplayerangles(vectortoangles(var_a120a51b - view_pos) - var_74a46de6);
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0x66ef8157, Offset: 0x2f30
// Size: 0x338
function function_5cdcce1e(player) {
    ac130 = self;
    ac130 endon(#"delete", #"ac130_shutdown");
    player endon(#"disconnect", #"joined_team", #"joined_spectator", #"changed_specialist");
    var_2990ddbd = -1;
    while (true) {
        ammo_in_clip = ac130 function_e2d89efe(1);
        player clientfield::set_player_uimodel("vehicle.rocketAmmo", ammo_in_clip);
        var_a4a44abc = ac130 function_fde0d99e(1);
        player clientfield::set_player_uimodel("vehicle.bindingCooldown0.cooldown", 1 - var_a4a44abc);
        ammo_in_clip = ac130 function_e2d89efe(2);
        player clientfield::set_player_uimodel("vehicle.ammoCount", ammo_in_clip);
        var_a4a44abc = ac130 function_fde0d99e(2);
        player clientfield::set_player_uimodel("vehicle.bindingCooldown1.cooldown", 1 - var_a4a44abc);
        ammo_in_clip = ac130 function_e2d89efe(3);
        player clientfield::set_player_uimodel("vehicle.ammo2Count", ammo_in_clip);
        var_a4a44abc = ac130 function_fde0d99e(3);
        player clientfield::set_player_uimodel("vehicle.bindingCooldown2.cooldown", 1 - var_a4a44abc);
        player clientfield::set_player_uimodel("vehicle.flareCount", ac130.numflares);
        seat_index = int(max(0, isdefined(ac130 getoccupantseat(player)) ? ac130 getoccupantseat(player) : 0));
        player clientfield::set_player_uimodel("vehicle.selectedWeapon", seat_index);
        if (var_2990ddbd != seat_index && isdefined(ac130.killstreak_duration) && isdefined(ac130.killstreak_end_time)) {
            ac130 updatedrivabletimeforalloccupants(ac130.killstreak_duration, ac130.killstreak_end_time);
            var_2990ddbd = seat_index;
        }
        wait 0.1;
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 3, eflags: 0x1 linked
// Checksum 0xa7faf7d5, Offset: 0x3270
// Size: 0x21c
function mainturretdestroyed(ac130, eattacker, weapon) {
    ac130.owner iprintlnbold(#"hash_bbc64fd3a1e88d");
    if (target_istarget(ac130)) {
        target_remove(ac130);
    }
    if (issentient(ac130)) {
        ac130 function_60d50ea4();
    }
    ac130.shuttingdown = 1;
    eattacker = self [[ level.figure_out_attacker ]](eattacker);
    if (isdefined(eattacker) && (!isdefined(ac130.owner) || ac130.owner util::isenemyplayer(eattacker))) {
        luinotifyevent(#"player_callout", 2, #"hash_bbc64fd3a1e88d", eattacker.entnum);
        challenges::destroyedaircraft(eattacker, weapon, 1, 1);
        eattacker challenges::addflyswatterstat(weapon, ac130);
        ac130 killstreaks::function_73566ec7(eattacker, weapon, ac130.owner);
        ac130 namespace_f9b02f80::play_destroyed_dialog_on_owner("ac130", ac130.killstreak_id);
        eattacker battlechatter::function_eebf94f6("ac130");
        eattacker stats::function_e24eec31(weapon, #"hash_3f3d8a93c372c67d", 1);
    }
    ac130 thread function_46d0e4e5();
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 6, eflags: 0x1 linked
// Checksum 0x7a700227, Offset: 0x3498
// Size: 0x84
function vtoldestructiblecallback(*brokennotify, eattacker, weapon, *pieceindex, *dir, *mod) {
    ac130 = self;
    ac130 endon(#"delete", #"ac130_shutdown");
    mainturretdestroyed(ac130, dir, mod);
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 4, eflags: 0x1 linked
// Checksum 0xeba63d04, Offset: 0x3528
// Size: 0x486
function function_8721028e(player, *ownerleft, var_dbcb1965 = 0, var_c3b5f258 = 0) {
    if (isbot(ownerleft)) {
        ownerleft ai::set_behavior_attribute("control", "commander");
    }
    if (!isdefined(level.ac130) || level.ac130.completely_shutdown === 1) {
        return;
    }
    profilestart();
    if (!is_true(level.ac130.var_7917e5a1)) {
        if (isdefined(ownerleft)) {
            ownerleft vehicle::stop_monitor_missiles_locked_on_to_me();
        }
        if (isdefined(ownerleft) && isdefined(level.ac130) && isdefined(level.ac130.owner)) {
            if (isdefined(ownerleft.usingvehicle) && ownerleft.usingvehicle) {
                ownerleft unlink();
                level.ac130 clientfield::set("vehicletransition", 0);
                ownerleft clientfield::set_player_uimodel("vehicle.inAC130", 0);
                ownerleft clientfield::set_to_player("inAC130", 0);
                ownerleft killstreaks::thermal_glow(0);
            }
        }
    }
    if (!var_c3b5f258) {
        level.ac130.shuttingdown = 1;
        level.ac130.occupied = 0;
        level.ac130.hardpointtype = "ac130";
        level.ac130 unlink();
        planedir = anglestoforward(level.ac130.angles);
        var_15f570c1 = level.ac130.origin + vectorscale(planedir, 30000);
        level.ac130 thread function_31d18ab9();
        if (target_istarget(level.ac130)) {
            target_remove(level.ac130);
        }
        if (issentient(level.ac130)) {
            level.ac130 function_60d50ea4();
        }
        if (var_dbcb1965) {
            var_15f570c1 += (0, 0, -8000);
        }
        level.ac130 thread helicopter::heli_leave(var_15f570c1, 1);
        level.ac130 thread audio::sndupdatevehiclecontext(0);
        if (var_dbcb1965) {
            level.ac130 thread function_60e3edcc();
        }
    }
    if (!is_true(level.ac130.var_7917e5a1) && isdefined(ownerleft)) {
        ownerleft setmodellodbias(0);
        ownerleft givededicatedshadow(ownerleft);
        ownerleft notify(#"gunner_left");
        ownerleft killstreaks::clear_using_remote();
    }
    if (!var_c3b5f258) {
        level.ac130.completely_shutdown = 1;
        level.ac130.shuttingdown = 0;
    }
    if (var_c3b5f258) {
        level.ac130 thread function_a514a080(ownerleft, level.ac130);
    }
    profilestop();
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 0, eflags: 0x1 linked
// Checksum 0x93077082, Offset: 0x39b8
// Size: 0xd4
function function_c4aa4bb2() {
    ac130 = self;
    if (isdefined(ac130) && isdefined(ac130.owner)) {
        org = ac130 gettagorigin("tag_barrel");
        magnitude = 0.3;
        duration = 2;
        radius = 500;
        v_pos = ac130.origin;
        earthquake(magnitude, duration, org, 500);
        ac130 playsound(#"hash_5314ffef2464b607");
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 15, eflags: 0x1 linked
// Checksum 0x7a246489, Offset: 0x3a98
// Size: 0x52c
function function_dea7ec6a(*einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, *vpoint, *vdir, *shitloc, *vdamageorigin, *psoffsettime, *damagefromunderneath, *modelindex, *partname, *vsurfacenormal) {
    ac130 = self;
    if (partname == "MOD_TRIGGER_HURT") {
        return 0;
    }
    if (ac130.shuttingdown) {
        return 0;
    }
    damagefromunderneath = self killstreaks::ondamageperweapon("ac130", psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal, ac130.maxhealth, undefined, ac130.maxhealth * 0.4, undefined, 0, undefined, 1, 1);
    if (damagefromunderneath == 0) {
        return 0;
    }
    handleasrocketdamage = partname == "MOD_PROJECTILE" || partname == "MOD_EXPLOSIVE";
    if (vsurfacenormal.statindex == level.weaponshotgunenergy.statindex || vsurfacenormal.statindex == level.weaponpistolenergy.statindex) {
        handleasrocketdamage = 0;
    }
    if (handleasrocketdamage) {
        ac130 function_c4aa4bb2();
        ac130 playsound(#"hash_ddcd9d25e056016");
    }
    var_902cbab5 = self.health - damagefromunderneath;
    if (!is_true(self.var_5b3f091f) && var_902cbab5 <= self.maxhealth * 0.75) {
        self namespace_f9b02f80::play_pilot_dialog_on_owner("damaged", "ac130", self.killstreak_id);
        self.var_5b3f091f = 1;
    } else if (!is_true(self.var_7e6efe74) && self.health <= self.maxhealth * 0.35) {
        self namespace_f9b02f80::play_pilot_dialog_on_owner("damaged1", "ac130", self.killstreak_id);
        self.var_7e6efe74 = 1;
    }
    var_a07db9e0 = self.maxhealth * 0.75;
    var_c5d67baf = self.maxhealth * 0.5;
    if (self.health > var_a07db9e0 && var_902cbab5 <= var_a07db9e0) {
        self thread function_d55529();
    } else if (self.health > var_c5d67baf && var_902cbab5 <= var_c5d67baf) {
        self thread function_ae354bc7();
    }
    if (self.health > 0 && var_902cbab5 < 0 && !ac130.shuttingdown) {
        ac130.shuttingdown = 1;
        if (!isdefined(ac130.destroyscoreeventgiven) && isdefined(psoffsettime) && (!isdefined(ac130.owner) || ac130.owner util::isenemyplayer(psoffsettime))) {
            psoffsettime = self [[ level.figure_out_attacker ]](psoffsettime);
            luinotifyevent(#"player_callout", 2, #"hash_bbc64fd3a1e88d", psoffsettime.entnum);
            ac130 namespace_f9b02f80::play_destroyed_dialog_on_owner("ac130", ac130.killstreak_id);
            psoffsettime battlechatter::function_eebf94f6("ac130");
            challenges::destroyedaircraft(psoffsettime, vsurfacenormal, 1, 1);
            psoffsettime challenges::addflyswatterstat(vsurfacenormal, ac130);
            psoffsettime stats::function_e24eec31(vsurfacenormal, #"hash_3f3d8a93c372c67d", 1);
            ac130.destroyscoreeventgiven = 1;
        }
        ac130.var_d02ddb8e = vsurfacenormal;
        ac130 thread function_46d0e4e5();
        return 0;
    }
    return damagefromunderneath;
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 0, eflags: 0x0
// Checksum 0x6be39007, Offset: 0x3fd0
// Size: 0x5e
function wait_and_explode() {
    self endon(#"death");
    wait 2;
    if (isdefined(self)) {
        self vehicle::do_death_fx();
        wait 0.25;
        if (isdefined(self)) {
            self notify(#"ac130_shutdown");
        }
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 0, eflags: 0x1 linked
// Checksum 0xc2f5e0c4, Offset: 0x4038
// Size: 0x114
function function_46d0e4e5() {
    ac130 = self;
    ac130 endon(#"death");
    if (self.leave_by_damage_initiated === 1) {
        return;
    }
    self.leave_by_damage_initiated = 1;
    if (target_istarget(ac130)) {
        target_remove(ac130);
    }
    if (issentient(ac130)) {
        ac130 function_60d50ea4();
    }
    ac130 thread remote_weapons::do_static_fx();
    failsafe_timeout = 5;
    ac130 waittilltimeout(failsafe_timeout, #"static_fx_done");
    var_dbcb1965 = 1;
    function_8721028e(ac130.owner, 1, var_dbcb1965);
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 2, eflags: 0x1 linked
// Checksum 0x1cf1c693, Offset: 0x4158
// Size: 0x34
function helicoptedetonateviaemp(attacker, weapon) {
    mainturretdestroyed(level.ac130, attacker, weapon);
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x0
// Checksum 0x2a4c67af, Offset: 0x4198
// Size: 0x84
function missilecleanupthread(missile) {
    targetent = self;
    targetent endon(#"delete", #"death");
    missile waittill(#"death", #"delete");
    targetent delete();
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 2, eflags: 0x1 linked
// Checksum 0xcf458e4f, Offset: 0x4228
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

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0xe5c06f19, Offset: 0x4420
// Size: 0x28
function enemyislocking(heli) {
    return isdefined(heli.locking_on) && heli.locking_on;
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0xe563ac6e, Offset: 0x4450
// Size: 0x28
function enemylockedon(heli) {
    return isdefined(heli.locked_on) && heli.locked_on;
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 2, eflags: 0x0
// Checksum 0x1228c72c, Offset: 0x4480
// Size: 0x39a
function function_cd679760(startnode, destnodes) {
    self notify(#"flying");
    self endon(#"flying", #"crashing", #"leaving", #"death");
    bundle = level.killstreaks[#"ac130"].script_bundle;
    assert(isdefined(bundle));
    nextnode = getent(startnode.target, "targetname");
    assert(isdefined(nextnode), "<dev string:x38>");
    self setspeed(150, 80);
    self setneargoalnotifydist(100);
    self setgoal(nextnode.origin + (0, 0, 0), 1);
    self waittill(#"near_goal");
    firstpass = 1;
    if (!self.playermovedrecently) {
        node = self updateareanodes(destnodes, 0);
        level.ac130.currentnode = node;
        targetnode = getent(node.target, "targetname");
        traveltonode(targetnode);
        if (isdefined(targetnode.script_airspeed) && isdefined(targetnode.script_accel)) {
            heli_speed = targetnode.script_airspeed;
            heli_accel = targetnode.script_accel;
        } else {
            heli_speed = 150 + randomint(20);
            heli_accel = 40 + randomint(10);
        }
        self setspeed(heli_speed, heli_accel);
        self setgoal(targetnode.origin + (0, 0, 0), 1);
        self setgoalyaw(targetnode.angles[1]);
    }
    if (!isdefined(targetnode) || !isdefined(targetnode.script_delay)) {
        self waittill(#"near_goal");
        waittime = 10 + randomint(5);
    } else {
        self waittill(#"goal");
        waittime = targetnode.script_delay;
    }
    if (firstpass) {
        profilestart();
        self function_53d3b37a(bundle);
        profilestop();
        firstpass = 0;
    }
    wait waittime;
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0x36a490d5, Offset: 0x4828
// Size: 0x104
function function_53d3b37a(bundle) {
    self.killstreak_duration = isdefined(bundle.ksduration) ? bundle.ksduration : self.killstreak_timer_start_using_hacked_time === 1 ? self killstreak_hacking::get_hacked_timeout_duration_ms() : 60000;
    self.killstreak_end_time = gettime() + self.killstreak_duration;
    self.killstreakendtime = int(self.killstreak_end_time);
    self thread killstreaks::waitfortimeout("ac130", self.killstreak_duration, &ontimeoutcallback, "delete", "death");
    self.killstreak_timer_started = 1;
    self updatedrivabletimeforalloccupants(self.killstreak_duration, self.killstreak_end_time);
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 2, eflags: 0x1 linked
// Checksum 0xbc8d25cf, Offset: 0x4938
// Size: 0x3c
function updatedrivabletimeforalloccupants(duration_ms, end_time_ms) {
    if (isdefined(self.owner)) {
        self.owner vehicle::set_vehicle_drivable_time(duration_ms, end_time_ms);
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x0
// Checksum 0x6c5bd831, Offset: 0x4980
// Size: 0x2f0
function watchlocationchangethread(destnodes) {
    player = self;
    player endon(#"disconnect", #"gunner_left");
    ac130 = level.ac130;
    bundle = level.killstreaks[#"ac130"].script_bundle;
    assert(isdefined(bundle));
    ac130 endon(#"delete", #"ac130_shutdown");
    player thread setplayermovedrecentlythread();
    player.moves = 0;
    while (true) {
        ac130 waittill(#"goal");
        if (player.moves > 0) {
            waittime = randomintrange(bundle.var_efac0f7a, bundle.var_18d458d2);
            wait float(waittime) / 1000;
        }
        player.moves++;
        node = self updateareanodes(destnodes, 1);
        ac130.currentnode = node;
        targetnode = getent(node.target, "targetname");
        player playlocalsound(#"mpl_cgunner_nav");
        ac130 traveltonode(targetnode);
        if (isdefined(targetnode.script_airspeed) && isdefined(targetnode.script_accel)) {
            heli_speed = targetnode.script_airspeed;
            heli_accel = targetnode.script_accel;
        } else {
            heli_speed = 80 + randomint(20);
            heli_accel = 40 + randomint(10);
        }
        ac130 setspeed(heli_speed, heli_accel);
        ac130 setgoal(targetnode.origin + (0, 0, 0), 1);
        ac130 setgoalyaw(targetnode.angles[1]);
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 0, eflags: 0x1 linked
// Checksum 0xa62bd0c5, Offset: 0x4c78
// Size: 0xd6
function setplayermovedrecentlythread() {
    player = self;
    player endon(#"disconnect", #"gunner_left");
    ac130 = level.ac130;
    ac130 endon(#"delete", #"ac130_shutdown");
    mymove = self.moves;
    level.ac130.playermovedrecently = 1;
    wait 100;
    if (mymove === self.moves && isdefined(level.ac130)) {
        level.ac130.playermovedrecently = 0;
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 2, eflags: 0x1 linked
// Checksum 0xeac0a67e, Offset: 0x4d58
// Size: 0x416
function updateareanodes(areanodes, forcemove) {
    validenemies = [];
    foreach (node in areanodes) {
        node.validplayers = [];
        node.nodescore = 0;
    }
    foreach (player in level.players) {
        if (!isalive(player)) {
            continue;
        }
        if (player.team == self.team) {
            continue;
        }
        foreach (node in areanodes) {
            if (distancesquared(player.origin, node.origin) > 1048576) {
                continue;
            }
            node.validplayers[node.validplayers.size] = player;
        }
    }
    bestnode = undefined;
    foreach (node in areanodes) {
        if (isdefined(level.ac130.currentnode) && node == level.ac130.currentnode) {
            continue;
        }
        helinode = getent(node.target, "targetname");
        foreach (player in node.validplayers) {
            node.nodescore += 1;
            if (bullettracepassed(player.origin + (0, 0, 32), helinode.origin, 0, player)) {
                node.nodescore += 3;
            }
        }
        if (forcemove && distancesquared(level.ac130.origin, helinode.origin) < 40000) {
            node.nodescore = -1;
        }
        if (!isdefined(bestnode) || node.nodescore > bestnode.nodescore) {
            bestnode = node;
        }
    }
    return bestnode;
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0x8a38bd4, Offset: 0x5178
// Size: 0x28a
function traveltonode(goalnode) {
    originoffets = getoriginoffsets(goalnode);
    if (originoffets[#"start"] != self.origin) {
        if (isdefined(goalnode.script_airspeed) && isdefined(goalnode.script_accel)) {
            heli_speed = goalnode.script_airspeed;
            heli_accel = goalnode.script_accel;
        } else {
            heli_speed = 30 + randomint(20);
            heli_accel = 15 + randomint(15);
        }
        self setspeed(heli_speed, heli_accel);
        self setgoal(originoffets[#"start"] + (0, 0, 30), 0);
        self setgoalyaw(goalnode.angles[1]);
        self waittill(#"goal");
    }
    if (originoffets[#"end"] != goalnode.origin) {
        if (isdefined(goalnode.script_airspeed) && isdefined(goalnode.script_accel)) {
            heli_speed = goalnode.script_airspeed;
            heli_accel = goalnode.script_accel;
        } else {
            heli_speed = 30 + randomint(20);
            heli_accel = 15 + randomint(15);
        }
        self setspeed(heli_speed, heli_accel);
        self setgoal(originoffets[#"end"] + (0, 0, 30), 0);
        self setgoalyaw(goalnode.angles[1]);
        self waittill(#"goal");
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0xde993e8b, Offset: 0x5410
// Size: 0x214
function getoriginoffsets(goalnode) {
    startorigin = self.origin;
    endorigin = goalnode.origin;
    numtraces = 0;
    maxtraces = 40;
    traceoffset = (0, 0, -196);
    for (traceorigin = bullettrace(startorigin + traceoffset, endorigin + traceoffset, 0, self); distancesquared(traceorigin[#"position"], endorigin + traceoffset) > 10 && numtraces < maxtraces; traceorigin = bullettrace(startorigin + traceoffset, endorigin + traceoffset, 0, self)) {
        println("<dev string:x6e>" + distancesquared(traceorigin[#"position"], endorigin + traceoffset));
        if (startorigin[2] < endorigin[2]) {
            startorigin += (0, 0, 128);
        } else if (startorigin[2] > endorigin[2]) {
            endorigin += (0, 0, 128);
        } else {
            startorigin += (0, 0, 128);
            endorigin += (0, 0, 128);
        }
        numtraces++;
    }
    offsets = [];
    offsets[#"start"] = startorigin;
    offsets[#"end"] = endorigin;
    return offsets;
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0x9743d1ee, Offset: 0x5630
// Size: 0xa4
function function_631f02c5(isprimaryweapon) {
    self endon(#"killed");
    if (isprimaryweapon) {
        self.var_1824934b = (isdefined(self.var_1824934b) ? self.var_1824934b : 0) + 1;
    } else {
        self.secondarykill = (isdefined(self.secondarykill) ? self.secondarykill : 0) + 1;
    }
    wait 2.5;
    if (!isdefined(self)) {
        return;
    }
    self function_568f6426(isprimaryweapon);
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 1, eflags: 0x1 linked
// Checksum 0xcc4db419, Offset: 0x56e0
// Size: 0x1b4
function function_568f6426(isprimaryweapon) {
    if (isprimaryweapon) {
        switch (self.var_1824934b) {
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
        self.var_1824934b = 0;
    } else {
        switch (self.secondarykill) {
        case 0:
            break;
        case 1:
            dialogkey = "secondaryKill1";
            break;
        case 2:
            dialogkey = "secondaryKill2";
            break;
        case 3:
            dialogkey = "secondaryKill3";
            break;
        default:
            dialogkey = "secondarykillMultiple";
            break;
        }
        self.secondarykill = 0;
    }
    if (isdefined(dialogkey)) {
        self namespace_f9b02f80::play_pilot_dialog_on_owner(dialogkey, "ac130", self.killstreak_id);
    }
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 0, eflags: 0x1 linked
// Checksum 0x21436960, Offset: 0x58a0
// Size: 0xbc
function function_d55529() {
    self endon(#"death");
    bundle = level.killstreaks[#"ac130"].script_bundle;
    playfxontag(bundle.var_545fa8c2, self, "tag_fx_engine3");
    self playsound(level.heli_sound[#"crash"]);
    wait 0.1;
    playfxontag(bundle.var_545fa8c2, self, "tag_fx_engine4");
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 0, eflags: 0x1 linked
// Checksum 0x90aa6593, Offset: 0x5968
// Size: 0xbc
function function_ae354bc7() {
    self endon(#"death");
    bundle = level.killstreaks[#"ac130"].script_bundle;
    playfxontag(bundle.var_465c35a5, self, "tag_fx_engine1");
    self playsound(level.heli_sound[#"crash"]);
    wait 0.1;
    playfxontag(bundle.var_465c35a5, self, "tag_fx_engine6");
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 0, eflags: 0x1 linked
// Checksum 0xc741bb9f, Offset: 0x5a30
// Size: 0xe4
function function_cd29787b() {
    bundle = level.killstreaks[#"ac130"].script_bundle;
    playfxontag(bundle.ksexplosionfx, self, "tag_body_animate");
    if (isdefined(bundle.var_bb6c29b4) && isdefined(self.var_d02ddb8e) && self.var_d02ddb8e == getweapon(#"shock_rifle")) {
        playfxontag(bundle.var_bb6c29b4, self, "tag_body_animate");
    }
    self playsound("exp_ac130");
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 0, eflags: 0x1 linked
// Checksum 0x8565bdbd, Offset: 0x5b20
// Size: 0x20c
function function_60e3edcc() {
    plane = self;
    plane endon(#"death");
    wait randomfloatrange(0.1, 0.2);
    if (false) {
        goalx = randomfloatrange(650, 700);
        goaly = randomfloatrange(650, 700);
        if (randomintrange(0, 2) > 0) {
            goalx *= -1;
        }
        if (randomintrange(0, 2) > 0) {
            goaly *= -1;
        }
        var_8518e93e = randomfloatrange(3, 4);
        plane setplanebarrelroll(randomfloatrange(0.0833333, 0.111111), randomfloatrange(4, 5));
        plane_speed = plane getspeedmph();
        wait 0.7;
        plane setspeed(plane_speed * 1.5, 300);
        wait var_8518e93e - 0.7;
    }
    plane function_cd29787b();
    wait 0.1;
    plane ghost();
    wait 0.5;
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 3, eflags: 0x0
// Checksum 0x860e690d, Offset: 0x5d38
// Size: 0x7c
function function_8920217c(var_eef27eea = 0, var_dc40d987 = 0, var_c06eaeb5 = 0) {
    level.var_98fe5b4a = [var_eef27eea, var_dc40d987];
    level.var_b34c8ec8 = var_c06eaeb5;
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 3, eflags: 0x0
// Checksum 0x230e3e99, Offset: 0x5dc0
// Size: 0xe0
function function_672f2acd(var_eb87911a, var_c3c587fa, var_a382eb14) {
    assert(isdefined(level.var_89350618));
    level.var_98fe5b4a = [var_eb87911a[0], var_eb87911a[1]];
    level.var_b34c8ec8 = var_eb87911a[2];
    level.var_89350618.origin = var_eb87911a;
    level.var_e2a77deb = var_c3c587fa;
    if (!isdefined(level.var_e2a77deb)) {
        level.var_e2a77deb = (var_eb87911a[0], var_eb87911a[1], 0);
    }
    level.var_def002d = var_a382eb14;
}

// Namespace namespace_2d34cefc/namespace_2d34cefc
// Params 2, eflags: 0x5 linked
// Checksum 0x18d68cff, Offset: 0x5ea8
// Size: 0x54
function private function_91ba5c69(*attacker, *inflictor) {
    if (isdefined(level.ac130) && is_true(level.ac130.var_7917e5a1)) {
        return level.ac130;
    }
}

