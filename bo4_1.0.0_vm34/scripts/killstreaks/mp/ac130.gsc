#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\remote_weapons;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\teams\teams;
#using scripts\mp_common\util;
#using scripts\weapons\hacker_tool;
#using scripts\weapons\heatseekingmissile;

#namespace ac130;

// Namespace ac130/ac130
// Params 0, eflags: 0x2
// Checksum 0xae5648b1, Offset: 0x420
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"ac130", &__init__, undefined, #"killstreaks");
}

// Namespace ac130/ac130
// Params 0, eflags: 0x0
// Checksum 0xd22a7f09, Offset: 0x470
// Size: 0x296
function __init__() {
    profilestart();
    killstreaks::register_killstreak("killstreak_ac130", &activatemaingunner);
    killstreaks::register_alt_weapon("ac130", getweapon(#"killstreak_remote"));
    killstreaks::register_alt_weapon("ac130", getweapon(#"hash_17df39d53492b0bf"));
    killstreaks::register_alt_weapon("ac130", getweapon(#"hash_7b24d0d0d2823bca"));
    killstreaks::register_alt_weapon("ac130", getweapon(#"ac130_chaingun"));
    killstreaks::set_team_kill_penalty_scale("ac130", level.teamkillreducedpenalty);
    player::function_b0320e78(&function_a0bae9e1, 1);
    level.killstreaks[#"ac130"].threatonkill = 1;
    callback::on_connect(&onplayerconnect);
    callback::on_finalize_initialization(&function_6567e2dd);
    level thread waitforgameendthread();
    level.ac130 = undefined;
    clientfield::register("clientuimodel", "vehicle.selectedWeapon", 1, 2, "int");
    clientfield::register("clientuimodel", "vehicle.flareCount", 1, 2, "int");
    clientfield::register("clientuimodel", "vehicle.inAC130", 1, 1, "int");
    clientfield::register("toplayer", "inAC130", 1, 1, "int");
    profilestop();
}

// Namespace ac130/ac130
// Params 0, eflags: 0x0
// Checksum 0x6cd36108, Offset: 0x710
// Size: 0x44
function function_6567e2dd() {
    bundle = struct::get_script_bundle("killstreak", "killstreak_ac130");
    initrotatingrig(bundle);
}

// Namespace ac130/ac130
// Params 0, eflags: 0x0
// Checksum 0x8a8bb57b, Offset: 0x760
// Size: 0x2a
function onplayerconnect() {
    if (!isdefined(self.entnum)) {
        self.entnum = self getentitynumber();
    }
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0x3e28525f, Offset: 0x798
// Size: 0x1fc
function initrotatingrig(bundle) {
    if (isdefined(level.var_582c293f)) {
        map_center = airsupport::getmapcenter();
        rotator_offset = (isdefined(level.var_582c293f) ? level.var_582c293f : map_center[0], isdefined(level.var_217ed544) ? level.var_217ed544 : map_center[1], isdefined(level.var_e1a905f9) ? level.var_e1a905f9 : airsupport::getminimumflyheight() + 8000);
        level.var_30ff215 = spawn("script_model", rotator_offset);
    } else {
        rotator_offset = (isdefined(level.var_cf9ad6e6) ? level.var_cf9ad6e6 : 0, isdefined(level.var_3372940d) ? level.var_3372940d : 0, airsupport::getminimumflyheight() + 8000);
        level.var_30ff215 = spawn("script_model", airsupport::getmapcenter() + rotator_offset);
    }
    level.var_30ff215 setmodel(#"tag_origin");
    level.var_30ff215.angles = (0, 115, 0);
    level.var_30ff215 hide();
    level.var_30ff215 thread rotaterig(bundle);
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0x335416c, Offset: 0x9a0
// Size: 0x66
function rotaterig(bundle) {
    var_2a023071 = isdefined(bundle.var_e81fda52) ? bundle.var_e81fda52 : 300;
    while (true) {
        self rotateyaw(360, var_2a023071);
        wait var_2a023071;
    }
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0x794de9e, Offset: 0xa10
// Size: 0x118
function activatemaingunner(killstreaktype) {
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
    result = player spawnac130();
    player val::reset(#"spawnac130", "freezecontrols");
    if (level.gameended) {
        return 1;
    }
    if (!isdefined(result)) {
        return 0;
    }
    return result;
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0x6f08e392, Offset: 0xb30
// Size: 0x10c
function hackedprefunction(hacker) {
    heligunner = self;
    heligunner.owner unlink();
    level.ac130 clientfield::set("vehicletransition", 0);
    heligunner.owner setmodellodbias(0);
    heligunner.owner notify(#"gunner_left");
    heligunner.owner killstreaks::clear_using_remote();
    heligunner.owner killstreaks::unhide_compass();
    heligunner.owner vehicle::stop_monitor_missiles_locked_on_to_me();
    heligunner.owner vehicle::stop_monitor_damage_as_occupant();
    heligunner makevehicleunusable();
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0x34b73c1a, Offset: 0xc48
// Size: 0x21a
function hackedpostfunction(hacker) {
    heligunner = self;
    heligunner clientfield::set("enemyvehicle", 2);
    heligunner makevehicleusable();
    heligunner usevehicle(hacker, 1);
    level.ac130 clientfield::set("vehicletransition", 1);
    heligunner thread vehicle::monitor_missiles_locked_on_to_me(hacker);
    heligunner thread vehicle::monitor_damage_as_occupant(hacker);
    hacker killstreaks::hide_compass();
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

// Namespace ac130/ac130
// Params 0, eflags: 0x4
// Checksum 0xb97ff77a, Offset: 0xe70
// Size: 0x830
function private spawnac130() {
    player = self;
    player endon(#"disconnect");
    level endon(#"game_ended");
    assert(!isdefined(level.ac130));
    profilestart();
    if (isdefined(player.isplanting) && player.isplanting || isdefined(player.isdefusing) && player.isdefusing || player util::isusingremote() || player iswallrunning() || player oob::isoutofbounds()) {
        return 0;
    }
    killstreak_id = player killstreakrules::killstreakstart("ac130", player.team, undefined, 1);
    if (killstreak_id == -1) {
        return 0;
    }
    bundle = struct::get_script_bundle("killstreak", "killstreak_ac130");
    spawnpos = airsupport::getmapcenter() + (5000, 5000, 8000);
    level.ac130 = spawnvehicle(bundle.ksvehicle, spawnpos, (0, 0, 0), "ac130");
    level.ac130 killstreaks::configure_team("ac130", killstreak_id, player, "helicopter");
    level.ac130 killstreak_hacking::enable_hacking("ac130", &hackedprefunction, &hackedpostfunction);
    level.ac130.killstreak_id = killstreak_id;
    level.ac130.destroyfunc = &function_88c3b2ad;
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
    level.ac130.fx_flare = bundle.var_ca5ccea8;
    level.ac130 helicopter::create_flare_ent((0, 0, -150));
    level.ac130 thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("death");
    level.ac130.is_still_valid_target_for_stinger_override = &function_c3fc3750;
    level.ac130 thread function_56ca8b1b(bundle);
    level.ac130 thread function_f665e44f(bundle);
    level.ac130 setrotorspeed(1);
    level.ac130 function_9fd88c5a(bundle);
    level.ac130.totalrockethits = 0;
    level.ac130.turretrockethits = 0;
    level.ac130.overridevehicledamage = &function_359d8d85;
    level.ac130.hackedhealthupdatecallback = &function_99210ae0;
    level.ac130.detonateviaemp = &helicoptedetonateviaemp;
    player thread killstreaks::play_killstreak_start_dialog("ac130", player.team, killstreak_id);
    level.ac130 killstreaks::play_pilot_dialog_on_owner("arrive", "ac130", killstreak_id);
    player stats::function_4f10b697(bundle.ksweapon, #"used", 1);
    player thread waitforvtolshutdownthread(level.ac130);
    level.ac130 function_c1d73465(bundle);
    profilestop();
    result = player function_7367a99b(1);
    if (result && isbot(player)) {
        player thread function_12ae6fa7(level.ac130);
    }
    util::function_d1f9db00(21, player.team, player getentitynumber(), level.killstreaks[#"ac130"].uiname);
    return result;
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0xe659e254, Offset: 0x16a8
// Size: 0x1a4
function function_c1d73465(bundle) {
    veh = self;
    rotator = level.var_30ff215;
    attach_angle = 90;
    angle = randomint(360);
    radiusoffset = isdefined(bundle.var_ac70250d) ? bundle.var_ac70250d : isdefined(level.var_857af82) ? level.var_857af82 : 12000;
    xoffset = cos(angle) * radiusoffset;
    yoffset = sin(angle) * radiusoffset;
    zoffset = (isdefined(bundle.var_b729bf2) ? bundle.var_b729bf2 : 8000) - 8000;
    anglevector = (xoffset, yoffset, zoffset);
    var_2c13eca5 = getdvarfloat(#"hash_29a9f2bae7599f46", -27);
    veh linkto(rotator, "tag_origin", anglevector, (0, angle + attach_angle, var_2c13eca5));
}

// Namespace ac130/ac130
// Params 0, eflags: 0x0
// Checksum 0x8e119f20, Offset: 0x1858
// Size: 0x8e
function function_99210ae0() {
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

// Namespace ac130/ac130
// Params 0, eflags: 0x0
// Checksum 0x36c4d5df, Offset: 0x18f0
// Size: 0x6c
function waitforgameendthread() {
    level waittill(#"game_ended");
    if (isdefined(level.ac130) && isdefined(level.ac130.owner)) {
        function_18fc1592(level.ac130.owner, 1);
    }
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0x4744312, Offset: 0x1968
// Size: 0x182
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
        if (isdefined(ac130.flare_ent)) {
            ac130.flare_ent delete();
            ac130.flare_ent = undefined;
        }
        ac130 function_da8fd94f();
        function_18fc1592(ac130.owner, 1);
    }
    assert(ac130.var_f06324e4 == 1);
    ac130 delete();
    ac130 = undefined;
}

// Namespace ac130/ac130
// Params 0, eflags: 0x0
// Checksum 0xc62531fa, Offset: 0x1af8
// Size: 0x68
function function_da8fd94f() {
    if (!isdefined(self)) {
        return;
    }
    if (self.var_f06324e4 === 1) {
        return;
    }
    profilestart();
    killstreakrules::killstreakstop("ac130", self.originalteam, self.killstreak_id);
    self.var_f06324e4 = 1;
    level.ac130 = undefined;
    profilestop();
}

// Namespace ac130/ac130
// Params 0, eflags: 0x0
// Checksum 0xca0f03ee, Offset: 0x1b68
// Size: 0x44
function function_33886e20() {
    self endon(#"death");
    wait isdefined(5) ? 5 : 0;
    self function_da8fd94f();
}

// Namespace ac130/ac130
// Params 0, eflags: 0x0
// Checksum 0xc8de0516, Offset: 0x1bb8
// Size: 0x28
function function_88c3b2ad() {
    ac130 = self;
    ac130 notify(#"ac130_shutdown");
}

// Namespace ac130/ac130
// Params 0, eflags: 0x0
// Checksum 0xc050a8ed, Offset: 0x1be8
// Size: 0x54
function ontimeoutcallback() {
    if (isdefined(level.ac130) && isdefined(level.ac130.owner)) {
        function_18fc1592(level.ac130.owner, 1);
    }
}

// Namespace ac130/ac130
// Params 2, eflags: 0x0
// Checksum 0x887a8e64, Offset: 0x1c48
// Size: 0x5c
function function_c3fc3750(ent, weapon) {
    if (isdefined(ent.var_46e7456)) {
        return false;
    }
    if (ent.shuttingdown === 1) {
        return false;
    }
    if (ent.completely_shutdown === 1) {
        return false;
    }
    return true;
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0xdeeb156d, Offset: 0x1cb0
// Size: 0xfa
function function_56ca8b1b(bundle) {
    ac130 = self;
    ac130 endon(#"death", #"ac130_shutdown");
    ac130.var_46e7456 = undefined;
    while (true) {
        ac130 waittill(#"flare_deployed");
        ac130 playsound(#"hash_713a3ce01967434e");
        ac130.var_46e7456 = 1;
        self killstreaks::play_pilot_dialog_on_owner("damageEvaded", "ac130", self.killstreak_id);
        wait isdefined(bundle.var_38de229d) ? bundle.var_38de229d : 5;
        ac130.var_46e7456 = undefined;
    }
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0xc880fafe, Offset: 0x1db8
// Size: 0xe8
function function_f665e44f(bundle) {
    ac130 = self;
    ac130 endon(#"death", #"ac130_shutdown");
    ac130.var_46e7456 = undefined;
    while (true) {
        waitresult = ac130 waittill(#"stinger_fired_at_me");
        if (isdefined(waitresult.projectile)) {
            ac130 function_2500507e(waitresult.projectile, bundle, "exp_incoming_missile");
            ac130 function_d38c3011(waitresult.projectile, bundle, "uin_ac130_alarm_missile_incoming");
        }
    }
}

// Namespace ac130/ac130
// Params 3, eflags: 0x0
// Checksum 0xf2102be1, Offset: 0x1ea8
// Size: 0x1fc
function function_2500507e(missile, bundle, var_4744a25e) {
    assert(isentity(missile));
    assert(isstruct(bundle));
    assert(isdefined(var_4744a25e));
    ac130 = self;
    if (!isdefined(ac130)) {
        return;
    }
    missile endon(#"death");
    var_1d942b91 = isdefined(bundle.var_d66503cc) ? bundle.var_d66503cc : 0.75;
    while (isdefined(ac130.owner) && ac130.owner util::function_27255f5d("ac130")) {
        dist = distance(missile.origin, ac130.origin);
        velocity = missile getvelocity();
        missile_dir = vectornormalize(velocity);
        missile_speed = vectordot(missile_dir, velocity);
        if (missile_speed > 0) {
            if (dist < missile_speed * var_1d942b91) {
                ac130 playsoundtoplayer(var_4744a25e, ac130.owner);
                return;
            }
        }
        wait 0.1;
    }
}

// Namespace ac130/ac130
// Params 3, eflags: 0x0
// Checksum 0xc93f249e, Offset: 0x20b0
// Size: 0x2b8
function function_d38c3011(missile, bundle, var_77127a68) {
    assert(isentity(missile));
    assert(isstruct(bundle));
    assert(isdefined(var_77127a68));
    ac130 = self;
    if (!isdefined(ac130)) {
        return;
    }
    missile endon(#"death");
    wait 0.2;
    neardist = isdefined(bundle.var_988a6c3e) ? bundle.var_988a6c3e : 10;
    fardist = isdefined(bundle.var_3990047b) ? bundle.var_3990047b : 100;
    range = fardist - neardist;
    if (range < 0) {
        return;
    }
    var_6d7d5014 = isdefined(bundle.var_26cdd0a8) ? bundle.var_26cdd0a8 : 0.05;
    var_9a50651f = isdefined(bundle.var_ca068551) ? bundle.var_ca068551 : 0.05;
    dist = undefined;
    while (isdefined(ac130.owner) && ac130.owner util::function_27255f5d("ac130")) {
        old_dist = dist;
        dist = distance(missile.origin, ac130.origin);
        var_f2a20c2f = isdefined(old_dist) && dist < old_dist;
        if (var_f2a20c2f) {
            ac130 playsoundtoplayer(var_77127a68, ac130.owner);
        }
        normalizeddist = (dist - neardist) / range;
        beep_interval = lerpfloat(var_6d7d5014, var_9a50651f, normalizeddist);
        wait beep_interval;
    }
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0xda8d63c4, Offset: 0x2370
// Size: 0x118
function watchplayerteamchangethread(ac130) {
    ac130 notify(#"mothership_team_change");
    ac130 endon(#"mothership_team_change");
    assert(isplayer(self));
    player = self;
    player endon(#"gunner_left");
    player waittill(#"joined_team", #"disconnect", #"joined_spectators");
    ownerleft = ac130.ownerentnum == player.entnum;
    player thread function_18fc1592(player, ownerleft);
    if (ownerleft) {
        ac130 notify(#"ac130_shutdown");
    }
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0x6799e509, Offset: 0x2490
// Size: 0x18a
function watchplayerexitrequestthread(player) {
    player notify(#"watchplayerexitrequestthread_singleton");
    player endon(#"watchplayerexitrequestthread_singleton");
    assert(isplayer(player));
    ac130 = self;
    level endon(#"game_ended");
    player endon(#"disconnect");
    player endon(#"gunner_left");
    owner = ac130.ownerentnum == player.entnum;
    while (true) {
        timeused = 0;
        while (player usebuttonpressed()) {
            timeused += 0.05;
            if (timeused > 0.25) {
                ac130 killstreaks::play_pilot_dialog_on_owner("remoteOperatorRemoved", "ac130", ac130.killstreak_id);
                player thread function_18fc1592(player, owner);
                return;
            }
            waitframe(1);
        }
        waitframe(1);
    }
}

// Namespace ac130/ac130
// Params 1, eflags: 0x4
// Checksum 0x4fd9ff9f, Offset: 0x2628
// Size: 0x3f0
function private function_7367a99b(isowner) {
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
    bundle = getscriptbundle("killstreak_ac130");
    level.ac130 usevehicle(player, 1);
    level.ac130.usage[player.entnum] = 1;
    level.ac130 thread audio::sndupdatevehiclecontext(1);
    level.ac130 thread vehicle::monitor_missiles_locked_on_to_me(player);
    level.ac130 thread vehicle::monitor_damage_as_occupant(player);
    level.ac130 thread function_2553450b(player);
    if (level.ac130.killstreak_timer_started) {
        player vehicle::set_vehicle_drivable_time(level.ac130.killstreak_duration, level.ac130.killstreak_end_time);
    } else {
        duration = isdefined(bundle.ksduration) ? bundle.ksduration : 60000;
        player vehicle::set_vehicle_drivable_time(duration, gettime() + duration);
    }
    level.ac130 thread watchplayerexitrequestthread(player);
    player thread watchplayerteamchangethread(level.ac130);
    player setmodellodbias(isdefined(level.mothership_lod_bias) ? level.mothership_lod_bias : 8);
    player givededicatedshadow(level.ac130);
    if (true) {
        player thread hidecompassafterwait(0.1);
    }
    player clientfield::set_player_uimodel("vehicle.inAC130", 1);
    player clientfield::set_to_player("inAC130", 1);
    player killstreaks::thermal_glow(1);
    player thread function_a13c5ccc(level.ac130);
    return true;
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0x5db5e208, Offset: 0x2a20
// Size: 0xec
function function_a13c5ccc(ac130) {
    ac130 endon(#"death", #"ac130_shutdown");
    self endon(#"disconnect");
    map_center = airsupport::getmapcenter();
    wait 0.1;
    var_84ec4c11 = ac130 function_d813fea4(0);
    view_pos = self getplayercamerapos();
    self setplayerangles(vectortoangles(map_center - view_pos) - var_84ec4c11);
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0x4b48df8b, Offset: 0x2b18
// Size: 0x378
function function_2553450b(player) {
    ac130 = self;
    ac130 endon(#"delete", #"ac130_shutdown");
    player endon(#"disconnect", #"joined_team", #"joined_spectator", #"changed_specialist");
    var_3401e573 = -1;
    while (true) {
        ammo_in_clip = ac130 function_52c8c517(1);
        player clientfield::set_player_uimodel("vehicle.rocketAmmo", ammo_in_clip);
        var_451daa51 = ac130 function_159cc7cd(1);
        player clientfield::set_player_uimodel("vehicle.bindingCooldown" + 0 + ".cooldown", 1 - var_451daa51);
        ammo_in_clip = ac130 function_52c8c517(2);
        player clientfield::set_player_uimodel("vehicle.ammoCount", ammo_in_clip);
        var_451daa51 = ac130 function_159cc7cd(2);
        player clientfield::set_player_uimodel("vehicle.bindingCooldown" + 1 + ".cooldown", 1 - var_451daa51);
        ammo_in_clip = ac130 function_52c8c517(3);
        player clientfield::set_player_uimodel("vehicle.ammo2Count", ammo_in_clip);
        var_451daa51 = ac130 function_159cc7cd(3);
        player clientfield::set_player_uimodel("vehicle.bindingCooldown" + 2 + ".cooldown", 1 - var_451daa51);
        player clientfield::set_player_uimodel("vehicle.flareCount", ac130.numflares);
        seat_index = int(max(0, isdefined(ac130 getoccupantseat(player)) ? ac130 getoccupantseat(player) : 0));
        player clientfield::set_player_uimodel("vehicle.selectedWeapon", seat_index);
        if (var_3401e573 != seat_index && isdefined(ac130.killstreak_duration) && isdefined(ac130.killstreak_end_time)) {
            ac130 updatedrivabletimeforalloccupants(ac130.killstreak_duration, ac130.killstreak_end_time);
            var_3401e573 = seat_index;
        }
        wait 0.1;
    }
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0xeb53f9b3, Offset: 0x2e98
// Size: 0x4c
function hidecompassafterwait(waittime) {
    self endon(#"death");
    self endon(#"disconnect");
    wait waittime;
    self killstreaks::hide_compass();
}

// Namespace ac130/ac130
// Params 3, eflags: 0x0
// Checksum 0x8acce04c, Offset: 0x2ef0
// Size: 0x204
function mainturretdestroyed(ac130, eattacker, weapon) {
    ac130.owner iprintlnbold(#"hash_bbc64fd3a1e88d");
    if (target_istarget(ac130)) {
        target_remove(ac130);
    }
    ac130.shuttingdown = 1;
    eattacker = self [[ level.figure_out_attacker ]](eattacker);
    if (!isdefined(ac130.destroyscoreeventgiven) && isdefined(eattacker) && (!isdefined(ac130.owner) || ac130.owner util::isenemyplayer(eattacker))) {
        luinotifyevent(#"player_callout", 2, #"hash_bbc64fd3a1e88d", eattacker.entnum);
        challenges::destroyedaircraft(eattacker, weapon, 1);
        eattacker challenges::addflyswatterstat(weapon, ac130);
        scoreevents::processscoreevent(#"hash_47c2a64b85e116e5", eattacker, ac130.owner, weapon);
        ac130 killstreaks::play_destroyed_dialog_on_owner("ac130", ac130.killstreak_id);
        eattacker battlechatter::function_b5530e2c("ac130", weapon);
        ac130.destroyscoreeventgiven = 1;
    }
    ac130 thread function_5811f0e8();
}

// Namespace ac130/ac130
// Params 6, eflags: 0x0
// Checksum 0x3058f328, Offset: 0x3100
// Size: 0x84
function vtoldestructiblecallback(brokennotify, eattacker, weapon, pieceindex, dir, mod) {
    ac130 = self;
    ac130 endon(#"delete", #"ac130_shutdown");
    mainturretdestroyed(ac130, eattacker, weapon);
}

// Namespace ac130/ac130
// Params 3, eflags: 0x0
// Checksum 0xc6c7bf6b, Offset: 0x3190
// Size: 0x43e
function function_18fc1592(player, ownerleft, var_63553a7e = 0) {
    if (isbot(player)) {
        player ai::set_behavior_attribute("control", "commander");
    }
    if (!isdefined(level.ac130) || level.ac130.completely_shutdown === 1) {
        return;
    }
    if (isdefined(player)) {
        player vehicle::stop_monitor_missiles_locked_on_to_me();
        player vehicle::stop_monitor_damage_as_occupant();
    }
    if (isdefined(player) && isdefined(level.ac130) && isdefined(level.ac130.owner)) {
        if (isdefined(player.usingvehicle) && player.usingvehicle) {
            player unlink();
            level.ac130 clientfield::set("vehicletransition", 0);
            player killstreaks::take("ac130");
            player clientfield::set_player_uimodel("vehicle.inAC130", 0);
            player clientfield::set_to_player("inAC130", 0);
            player killstreaks::thermal_glow(0);
        }
    }
    level.ac130.shuttingdown = 1;
    level.ac130.occupied = 0;
    level.ac130.hardpointtype = "ac130";
    level.ac130 unlink();
    var_14dc73fd = 30000;
    planedir = anglestoforward(level.ac130.angles);
    var_f6085aac = level.ac130.origin + vectorscale(planedir, 30000);
    level.ac130 thread function_33886e20();
    if (target_istarget(level.ac130)) {
        target_remove(level.ac130);
    }
    if (var_63553a7e) {
        var_f6085aac += (0, 0, -8000);
    }
    level.ac130 thread helicopter::heli_leave(var_f6085aac, 1);
    level.ac130 thread audio::sndupdatevehiclecontext(0);
    if (var_63553a7e) {
        level.ac130 thread function_38e09412();
    }
    if (isdefined(player)) {
        player setmodellodbias(0);
        player givededicatedshadow(player);
        player killstreaks::unhide_compass();
        player notify(#"gunner_left");
        player killstreaks::clear_using_remote();
        if (level.gameended) {
            player val::set(#"game_end", "freezecontrols");
        }
    }
    level.ac130.completely_shutdown = 1;
    level.ac130.shuttingdown = 0;
}

// Namespace ac130/ac130
// Params 0, eflags: 0x0
// Checksum 0x7ec18d89, Offset: 0x35d8
// Size: 0xe4
function function_fd8b7518() {
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

// Namespace ac130/ac130
// Params 15, eflags: 0x0
// Checksum 0xd8103c2e, Offset: 0x36c8
// Size: 0x4ec
function function_359d8d85(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    ac130 = self;
    if (smeansofdeath == "MOD_TRIGGER_HURT") {
        return 0;
    }
    if (ac130.shuttingdown) {
        return 0;
    }
    idamage = self killstreaks::ondamageperweapon("ac130", eattacker, idamage, idflags, smeansofdeath, weapon, ac130.maxhealth, undefined, ac130.maxhealth * 0.4, undefined, 0, undefined, 1, 1);
    if (idamage == 0) {
        return 0;
    }
    handleasrocketdamage = smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_EXPLOSIVE";
    if (weapon.statindex == level.weaponshotgunenergy.statindex || weapon.statindex == level.weaponpistolenergy.statindex) {
        handleasrocketdamage = 0;
    }
    if (handleasrocketdamage) {
        ac130 function_fd8b7518();
        ac130 playsound(#"hash_ddcd9d25e056016");
    }
    var_821e8d75 = self.health - idamage;
    if (!(isdefined(self.var_73bced7f) && self.var_73bced7f) && var_821e8d75 <= self.maxhealth * 0.75) {
        self killstreaks::play_pilot_dialog_on_owner("damaged", "ac130", self.killstreak_id);
        self.var_73bced7f = 1;
    } else if (!(isdefined(self.var_9d472d2f) && self.var_9d472d2f) && self.health <= self.maxhealth * 0.35) {
        self killstreaks::play_pilot_dialog_on_owner("damaged1", "ac130", self.killstreak_id);
        self.var_9d472d2f = 1;
    }
    var_87553415 = self.maxhealth * 0.75;
    var_ff4a171e = self.maxhealth * 0.5;
    if (self.health > var_87553415 && var_821e8d75 <= var_87553415) {
        self thread function_a60963c1();
    } else if (self.health > var_ff4a171e && var_821e8d75 <= var_ff4a171e) {
        self thread function_e3b410f6();
    }
    if (self.health > 0 && var_821e8d75 < 0 && !ac130.shuttingdown) {
        ac130.shuttingdown = 1;
        if (!isdefined(ac130.destroyscoreeventgiven) && isdefined(eattacker) && (!isdefined(ac130.owner) || ac130.owner util::isenemyplayer(eattacker))) {
            eattacker = self [[ level.figure_out_attacker ]](eattacker);
            luinotifyevent(#"player_callout", 2, #"hash_bbc64fd3a1e88d", eattacker.entnum);
            ac130 killstreaks::play_destroyed_dialog_on_owner("ac130", ac130.killstreak_id);
            eattacker battlechatter::function_b5530e2c("ac130", weapon);
            ac130.destroyscoreeventgiven = 1;
        }
        ac130 thread function_5811f0e8();
        return 0;
    }
    return idamage;
}

// Namespace ac130/ac130
// Params 0, eflags: 0x0
// Checksum 0x6542da45, Offset: 0x3bc0
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

// Namespace ac130/ac130
// Params 0, eflags: 0x0
// Checksum 0x49945477, Offset: 0x3c28
// Size: 0xec
function function_5811f0e8() {
    ac130 = self;
    ac130 endon(#"death");
    if (self.leave_by_damage_initiated === 1) {
        return;
    }
    self.leave_by_damage_initiated = 1;
    if (target_istarget(ac130)) {
        target_remove(ac130);
    }
    ac130 thread remote_weapons::do_static_fx();
    failsafe_timeout = 5;
    ac130 waittilltimeout(failsafe_timeout, #"static_fx_done");
    var_63553a7e = 1;
    function_18fc1592(ac130.owner, 1, var_63553a7e);
}

// Namespace ac130/ac130
// Params 2, eflags: 0x0
// Checksum 0x32448040, Offset: 0x3d20
// Size: 0x34
function helicoptedetonateviaemp(attacker, weapon) {
    mainturretdestroyed(level.ac130, attacker, weapon);
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0xad18ed6e, Offset: 0x3d60
// Size: 0x8c
function missilecleanupthread(missile) {
    targetent = self;
    targetent endon(#"delete");
    targetent endon(#"death");
    missile waittill(#"death", #"delete");
    targetent delete();
}

// Namespace ac130/ac130
// Params 2, eflags: 0x0
// Checksum 0x469f9e57, Offset: 0x3df8
// Size: 0x210
function playlockonsoundsthread(player, heli) {
    player endon(#"disconnect");
    player endon(#"gunner_left");
    heli endon(#"death");
    heli endon(#"crashing");
    heli endon(#"leaving");
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

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0x92dd39c4, Offset: 0x4010
// Size: 0x28
function enemyislocking(heli) {
    return isdefined(heli.locking_on) && heli.locking_on;
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0xb70ead6, Offset: 0x4040
// Size: 0x28
function enemylockedon(heli) {
    return isdefined(heli.locked_on) && heli.locked_on;
}

// Namespace ac130/ac130
// Params 2, eflags: 0x0
// Checksum 0x9c023b73, Offset: 0x4070
// Size: 0x3a2
function function_960f85d9(startnode, destnodes) {
    self notify(#"flying");
    self endon(#"flying", #"crashing", #"leaving", #"death");
    bundle = getscriptbundle("killstreak_ac130");
    nextnode = getent(startnode.target, "targetname");
    assert(isdefined(nextnode), "<dev string:x30>");
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
        self function_9fd88c5a(bundle);
        profilestop();
        firstpass = 0;
    }
    wait waittime;
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0xfebaf5d0, Offset: 0x4420
// Size: 0x104
function function_9fd88c5a(bundle) {
    self.killstreak_duration = isdefined(bundle.ksduration) ? bundle.ksduration : self.killstreak_timer_start_using_hacked_time === 1 ? self killstreak_hacking::get_hacked_timeout_duration_ms() : 60000;
    self.killstreak_end_time = gettime() + self.killstreak_duration;
    self.killstreakendtime = int(self.killstreak_end_time);
    self thread killstreaks::waitfortimeout("ac130", self.killstreak_duration, &ontimeoutcallback, "delete", "death");
    self.killstreak_timer_started = 1;
    self updatedrivabletimeforalloccupants(self.killstreak_duration, self.killstreak_end_time);
}

// Namespace ac130/ac130
// Params 2, eflags: 0x0
// Checksum 0x6971720b, Offset: 0x4530
// Size: 0x3c
function updatedrivabletimeforalloccupants(duration_ms, end_time_ms) {
    if (isdefined(self.owner)) {
        self.owner vehicle::set_vehicle_drivable_time(duration_ms, end_time_ms);
    }
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0x3b0db53f, Offset: 0x4578
// Size: 0x300
function watchlocationchangethread(destnodes) {
    player = self;
    player endon(#"disconnect");
    player endon(#"gunner_left");
    ac130 = level.ac130;
    settings = getscriptbundle("killstreak_ac130");
    ac130 endon(#"delete", #"ac130_shutdown");
    player thread setplayermovedrecentlythread();
    player.moves = 0;
    while (true) {
        ac130 waittill(#"goal");
        if (player.moves > 0) {
            waittime = randomintrange(settings.var_a12ad507, settings.var_440a8d79);
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

// Namespace ac130/ac130
// Params 0, eflags: 0x0
// Checksum 0x1a3fe9a2, Offset: 0x4880
// Size: 0xde
function setplayermovedrecentlythread() {
    player = self;
    player endon(#"disconnect");
    player endon(#"gunner_left");
    ac130 = level.ac130;
    ac130 endon(#"delete", #"ac130_shutdown");
    mymove = self.moves;
    level.ac130.playermovedrecently = 1;
    wait 100;
    if (mymove === self.moves && isdefined(level.ac130)) {
        level.ac130.playermovedrecently = 0;
    }
}

// Namespace ac130/ac130
// Params 2, eflags: 0x0
// Checksum 0xb79cf8, Offset: 0x4968
// Size: 0x3fe
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

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0x5a0c74fc, Offset: 0x4d70
// Size: 0x2b2
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

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0x6a126f91, Offset: 0x5030
// Size: 0x246
function getoriginoffsets(goalnode) {
    startorigin = self.origin;
    endorigin = goalnode.origin;
    numtraces = 0;
    maxtraces = 40;
    traceoffset = (0, 0, -196);
    for (traceorigin = bullettrace(startorigin + traceoffset, endorigin + traceoffset, 0, self); distancesquared(traceorigin[#"position"], endorigin + traceoffset) > 10 && numtraces < maxtraces; traceorigin = bullettrace(startorigin + traceoffset, endorigin + traceoffset, 0, self)) {
        println("<dev string:x63>" + distancesquared(traceorigin[#"position"], endorigin + traceoffset));
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

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0xa339fb84, Offset: 0x5280
// Size: 0x2a4
function function_12ae6fa7(vehicle) {
    vehicle endon(#"ac130_shutdown");
    self endon(#"disconnect");
    vehicle makesentient();
    waitframe(1);
    while (self isremotecontrolling()) {
        enemy = undefined;
        enemies = self teams::getenemyplayers();
        enemies = array::randomize(enemies);
        foreach (potentialenemy in enemies) {
            if (isalive(potentialenemy)) {
                enemy = potentialenemy;
                break;
            }
        }
        if (isdefined(enemy)) {
            vectorfromenemy = vectornormalize(((vehicle.origin - enemy.origin)[0], (vehicle.origin - enemy.origin)[1], 0));
            vehicle turretsettarget(0, enemy);
            vehicle waittilltimeout(1, #"turret_on_target");
            vehicle vehicle_ai::fire_for_time(2 + randomfloat(0.8), 0, enemy);
            vehicle vehicle_ai::fire_for_rounds(1, 1, enemy);
            vehicle turretcleartarget(0);
            vehicle turretsettargetangles(0, (15, 0, 0));
            if (isdefined(enemy)) {
                wait 2 + randomfloat(0.5);
            }
        }
        wait 0.1;
    }
}

// Namespace ac130/ac130
// Params 9, eflags: 0x0
// Checksum 0x1fc5a529, Offset: 0x5530
// Size: 0x154
function function_a0bae9e1(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (!isdefined(einflictor) || !isdefined(einflictor.owner) || !isdefined(attacker) || !isdefined(weapon)) {
        return;
    }
    if (einflictor.owner == attacker && (weapon == getweapon(#"hash_17df39d53492b0bf") || weapon == getweapon(#"hash_7b24d0d0d2823bca"))) {
        isprimaryweapon = weapon == getweapon(#"hash_17df39d53492b0bf") ? 1 : 0;
        level.ac130 function_f3035bae(isprimaryweapon);
    }
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0xb62ed5a5, Offset: 0x5690
// Size: 0xa4
function function_f3035bae(isprimaryweapon) {
    self endon(#"killed");
    if (isprimaryweapon) {
        self.primarykill = (isdefined(self.primarykill) ? self.primarykill : 0) + 1;
    } else {
        self.secondarykill = (isdefined(self.secondarykill) ? self.secondarykill : 0) + 1;
    }
    wait 2.5;
    if (!isdefined(self)) {
        return;
    }
    self function_5b58d661(isprimaryweapon);
}

// Namespace ac130/ac130
// Params 1, eflags: 0x0
// Checksum 0x7ce78063, Offset: 0x5740
// Size: 0x1b4
function function_5b58d661(isprimaryweapon) {
    if (isprimaryweapon) {
        switch (self.primarykill) {
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
        self.primarykill = 0;
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
        self killstreaks::play_pilot_dialog_on_owner(dialogkey, "ac130", self.killstreak_id);
    }
}

// Namespace ac130/ac130
// Params 0, eflags: 0x0
// Checksum 0xf5f5447b, Offset: 0x5900
// Size: 0xbc
function function_a60963c1() {
    self endon(#"death");
    bundle = level.killstreaks[#"ac130"].script_bundle;
    playfxontag(bundle.var_5dff0b5e, self, "tag_fx_engine3");
    self playsound(level.heli_sound[#"crash"]);
    wait 0.1;
    playfxontag(bundle.var_5dff0b5e, self, "tag_fx_engine4");
}

// Namespace ac130/ac130
// Params 0, eflags: 0x0
// Checksum 0xb68ef39f, Offset: 0x59c8
// Size: 0xbc
function function_e3b410f6() {
    self endon(#"death");
    bundle = level.killstreaks[#"ac130"].script_bundle;
    playfxontag(bundle.var_feee1e1d, self, "tag_fx_engine1");
    self playsound(level.heli_sound[#"crash"]);
    wait 0.1;
    playfxontag(bundle.var_feee1e1d, self, "tag_fx_engine6");
}

// Namespace ac130/ac130
// Params 0, eflags: 0x0
// Checksum 0xea597ca0, Offset: 0x5a90
// Size: 0x74
function function_fcad4f99() {
    bundle = level.killstreaks[#"ac130"].script_bundle;
    playfxontag(bundle.ksexplosionfx, self, "tag_body_animate");
    self playsound("exp_ac130");
}

// Namespace ac130/ac130
// Params 0, eflags: 0x0
// Checksum 0x25931d8c, Offset: 0x5b10
// Size: 0x20c
function function_38e09412() {
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
        var_73949010 = randomfloatrange(3, 4);
        plane setplanebarrelroll(randomfloatrange(0.0833333, 0.111111), randomfloatrange(4, 5));
        plane_speed = plane getspeedmph();
        wait 0.7;
        plane setspeed(plane_speed * 1.5, 300);
        wait var_73949010 - 0.7;
    }
    plane function_fcad4f99();
    wait 0.1;
    plane ghost();
    wait 0.5;
}

