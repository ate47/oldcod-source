#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\qrdrone;
#using scripts\killstreaks\remote_weapons;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\weapons\hacker_tool;
#using scripts\weapons\heatseekingmissile;

#namespace dart;

// Namespace dart/dart
// Params 0, eflags: 0x2
// Checksum 0x8845ab01, Offset: 0x2d8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"dart", &__init__, undefined, #"killstreaks");
}

// Namespace dart/dart
// Params 0, eflags: 0x0
// Checksum 0xcec84fe6, Offset: 0x328
// Size: 0x1f4
function __init__() {
    qrdrone::init_shared();
    killstreaks::register_killstreak("killstreak_dart", &activatedart);
    killstreaks::override_entity_camera_in_demo("dart", 1);
    killstreaks::register_alt_weapon("dart", getweapon(#"killstreak_remote"));
    killstreaks::register_alt_weapon("dart", getweapon(#"dart_blade"));
    killstreaks::register_alt_weapon("dart", getweapon(#"dart_turret"));
    clientfield::register("toplayer", "dart_update_ammo", 1, 2, "int");
    clientfield::register("toplayer", "fog_bank_3", 1, 1, "int");
    remote_weapons::registerremoteweapon("dart", #"", &startdartremotecontrol, &enddartremotecontrol, 1);
    visionset_mgr::register_info("visionset", "dart_visionset", 1, 90, 16, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
}

// Namespace dart/dart
// Params 1, eflags: 0x0
// Checksum 0x119b31f9, Offset: 0x528
// Size: 0x66
function wait_dart_timed_out(time) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"dart_throw_failed");
    self endon(#"dart_entered");
    wait time;
    self notify(#"dart_throw_timed_out");
}

// Namespace dart/dart
// Params 0, eflags: 0x0
// Checksum 0x109a0b4, Offset: 0x598
// Size: 0xb6
function wait_for_throw_status() {
    thread wait_dart_timed_out(5);
    notifystring = self waittill(#"death", #"disconnect", #"dart_entered", #"dart_throw_timed_out", #"dart_throw_failed");
    if (notifystring._notify == "dart_entered" || notifystring._notify == "death") {
        return true;
    }
    return false;
}

// Namespace dart/dart
// Params 1, eflags: 0x0
// Checksum 0x5ffd30af, Offset: 0x658
// Size: 0x2b4
function activatedart(killstreaktype) {
    player = self;
    assert(isplayer(player));
    if (!player killstreakrules::iskillstreakallowed("dart", player.team)) {
        return 0;
    }
    player disableoffhandweapons();
    missileweapon = player getcurrentweapon();
    if (!(isdefined(missileweapon) && (missileweapon.name == "dart" || missileweapon.name == "inventory_dart"))) {
        player enableoffhandweapons();
        return 0;
    }
    player thread watchthrow(missileweapon);
    notifystring = player waittill(#"weapon_change", #"grenade_fire", #"death", #"disconnect", #"joined_team", #"emp_jammed", #"emp_grenaded");
    if (notifystring._notify == "death" || notifystring._notify == "emp_jammed" || notifystring._notify == "emp_grenaded") {
        if (isdefined(player)) {
            if (player.waitingondartthrow) {
                player notify(#"dart_putaway");
            }
            player enableoffhandweapons();
        }
        return 0;
    }
    if (notifystring._notify == "grenade_fire") {
        return player wait_for_throw_status();
    }
    if (notifystring._notify == "weapon_change") {
        if (player.waitingondartthrow) {
            player notify(#"dart_putaway");
        }
        player enableoffhandweapons();
        return 0;
    }
    return 1;
}

// Namespace dart/dart
// Params 0, eflags: 0x0
// Checksum 0xf0003c7d, Offset: 0x918
// Size: 0x42
function cleanup_grenade() {
    self thread waitthendelete(0.05);
    self.origin += (0, 0, 1000);
}

// Namespace dart/dart
// Params 1, eflags: 0x0
// Checksum 0x42c3d481, Offset: 0x968
// Size: 0x33c
function watchthrow(missileweapon) {
    assert(isplayer(self));
    player = self;
    playerentnum = player.entnum;
    player endon(#"disconnect");
    player endon(#"joined_team");
    player endon(#"dart_putaway");
    level endon(#"game_ended");
    player.waitingondartthrow = 1;
    waitresult = player waittill(#"grenade_fire");
    grenade = waitresult.projectile;
    weapon = waitresult.weapon;
    player.waitingondartthrow = 0;
    if (weapon != missileweapon) {
        player notify(#"dart_throw_failed");
        return;
    }
    trace = player check_launch_space(grenade.origin);
    if (trace[#"fraction"] < 1) {
        player iprintlnbold(#"hash_150caa190a45d9eb");
        grenade cleanup_grenade();
        player notify(#"dart_throw_failed");
        return;
    }
    killstreak_id = player killstreakrules::killstreakstart("dart", player.team, undefined, 0);
    if (killstreak_id == -1) {
        grenade cleanup_grenade();
        player notify(#"dart_throw_failed");
        return;
    }
    player killstreaks::set_killstreak_delay_killcam("dart");
    player.resurrect_not_allowed_by = "dart";
    player stats::function_4f10b697(getweapon(#"dart"), #"used", 1);
    level thread popups::displaykillstreakteammessagetoall("dart", player);
    dart = player spawndart(grenade, killstreak_id, trace[#"position"]);
    player thread function_ca93e51b(missileweapon);
}

// Namespace dart/dart
// Params 1, eflags: 0x0
// Checksum 0xbed412ad, Offset: 0xcb0
// Size: 0xec
function function_ca93e51b(missileweapon) {
    player = self;
    player endon(#"disconnect");
    player endon(#"joined_team");
    player endon(#"death");
    player endon(#"dart_putaway");
    level endon(#"game_ended");
    player waittill(#"weapon_change");
    if (isdefined(player) && isalive(player)) {
        player takeweapon(missileweapon);
    }
}

// Namespace dart/dart
// Params 1, eflags: 0x0
// Checksum 0x27e2c04c, Offset: 0xda8
// Size: 0x11c
function hackedprefunction(hacker) {
    dart = self;
    visionset_mgr::deactivate("visionset", "dart_visionset", dart.owner);
    dart.owner clientfield::set_to_player("fog_bank_3", 0);
    dart.owner unlink();
    dart clientfield::set("vehicletransition", 0);
    dart.owner killstreaks::clear_using_remote();
    dart.owner killstreaks::unhide_compass();
    dart.owner vehicle::stop_monitor_missiles_locked_on_to_me();
    dart.owner vehicle::stop_monitor_damage_as_occupant();
    dart disabledartmissilelocking();
}

// Namespace dart/dart
// Params 1, eflags: 0x0
// Checksum 0x3467bc7e, Offset: 0xed0
// Size: 0xac
function hackedpostfunction(hacker) {
    dart = self;
    hacker startdartremotecontrol(dart);
    hacker killstreak_hacking::set_vehicle_drivable_time_starting_now(dart);
    hacker remote_weapons::useremoteweapon(dart, "dart", 0, 0);
    hacker killstreaks::set_killstreak_delay_killcam("dart");
    dart thread watchremotecontroldeactivate();
}

// Namespace dart/dart
// Params 0, eflags: 0x0
// Checksum 0x6405c29f, Offset: 0xf88
// Size: 0x106
function watchremotecontroldeactivate() {
    dart = self;
    dart notify(#"watchremotecontroldeactivate_remoteweapons");
    dart endon(#"watchremotecontroldeactivate_remoteweapons");
    dart endon(#"death", #"remote_weapon_end");
    dart.remoteowner endon(#"disconnect");
    while (dart.remoteowner attackbuttonpressed()) {
        waitframe(1);
    }
    while (true) {
        if (dart.remoteowner attackbuttonpressed()) {
            dart thread remote_weapons::endremotecontrolweaponuse(1);
            dart.lastusetime = gettime();
            return;
        }
        waitframe(1);
    }
}

// Namespace dart/dart
// Params 1, eflags: 0x0
// Checksum 0x2a234324, Offset: 0x1098
// Size: 0x4e
function dart_hacked_health_update(hacker) {
    dart = self;
    if (dart.health > dart.hackedhealth) {
        dart.health = dart.hackedhealth;
    }
}

// Namespace dart/dart
// Params 1, eflags: 0x0
// Checksum 0x2aa561b6, Offset: 0x10f0
// Size: 0xc2
function check_launch_space(origin) {
    player_angles = self getplayerangles();
    forward = anglestoforward(player_angles);
    spawn_origin = origin + vectorscale(forward, 50);
    radius = 10;
    return physicstrace(origin, spawn_origin, (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), self, 1);
}

// Namespace dart/dart
// Params 3, eflags: 0x0
// Checksum 0x7d7973fb, Offset: 0x11c0
// Size: 0x53c
function spawndart(grenade, killstreak_id, spawn_origin) {
    player = self;
    assert(isplayer(player));
    playerentnum = player.entnum;
    player_angles = player getplayerangles();
    grenade cleanup_grenade();
    params = level.killstreakbundle[#"dart"];
    if (!isdefined(params.ksvehicle)) {
        params.ksvehicle = "veh_dart_mp";
    }
    if (!isdefined(params.ksdartinitialspeed)) {
        params.ksdartinitialspeed = 35;
    }
    if (!isdefined(params.ksdartacceleration)) {
        params.ksdartacceleration = 35;
    }
    dart = spawnvehicle(params.ksvehicle, spawn_origin, player_angles, "dynamic_spawn_ai");
    if (isdefined(dart)) {
        player killstreaks::play_killstreak_start_dialog("dart", player.team, killstreak_id);
    }
    dart.is_shutting_down = 0;
    dart.team = player.team;
    dart setspeedimmediate(params.ksdartinitialspeed, params.ksdartacceleration);
    dart.maxhealth = killstreak_bundles::get_max_health("dart");
    dart.health = dart.maxhealth;
    dart.hackedhealth = killstreak_bundles::get_hacked_health("dart");
    dart.hackedhealthupdatecallback = &dart_hacked_health_update;
    dart killstreaks::configure_team("dart", killstreak_id, player, "small_vehicle");
    dart killstreak_hacking::enable_hacking("dart", &hackedprefunction, &hackedpostfunction);
    dart clientfield::set("enemyvehicle", 1);
    dart.killstreak_id = killstreak_id;
    dart.hardpointtype = "dart";
    dart thread killstreaks::waitfortimeout("dart", 30000, &stop_remote_weapon, "remote_weapon_end", "death");
    dart hacker_tool::registerwithhackertool(50, 2000);
    dart.overridevehicledamage = &dartdamageoverride;
    dart.detonateviaemp = &emp_damage_cb;
    dart.do_scripted_crash = 0;
    dart.delete_on_death = 1;
    dart.one_remote_use = 1;
    dart.vehcheckforpredictedcrash = 1;
    dart.predictedcollisiontime = 0.2;
    dart.glasscollision_alt = 1;
    dart.damagetaken = 0;
    dart.death_enter_cb = &waitremotecontrol;
    target_set(dart);
    dart vehicle::init_target_group();
    dart vehicle::add_to_target_group(dart);
    dart thread watchcollision();
    dart thread watchdeath();
    dart thread watchownernondeathevents();
    dart thread vehicle::watch_freeze_on_flash(1);
    dart.forcewaitremotecontrol = 1;
    player remote_weapons::useremoteweapon(dart, "dart", 1, 0, 1);
    dart thread watchremotecontroldeactivate();
    dart util::make_sentient();
    player notify(#"dart_entered");
    return dart;
}

// Namespace dart/dart
// Params 0, eflags: 0x0
// Checksum 0x177e5929, Offset: 0x1708
// Size: 0x66
function debug_origin() {
    self endon(#"death");
    while (true) {
        /#
            sphere(self.origin, 5, (1, 0, 0), 1, 1, 2, 120);
        #/
        waitframe(1);
    }
}

// Namespace dart/dart
// Params 0, eflags: 0x0
// Checksum 0x828a54b6, Offset: 0x1778
// Size: 0xf4
function waitremotecontrol() {
    dart = self;
    remote_controlled = isdefined(dart.control_initiated) && dart.control_initiated || isdefined(dart.controlled) && dart.controlled;
    if (remote_controlled) {
        notifystring = dart waittill(#"remote_weapon_end", #"dart_left");
        if (notifystring._notify == "remote_weapon_end") {
            dart waittill(#"dart_left");
        } else {
            dart waittill(#"remote_weapon_end");
        }
        return;
    }
    dart waittill(#"dart_left");
}

// Namespace dart/dart
// Params 1, eflags: 0x0
// Checksum 0xbd2b949, Offset: 0x1878
// Size: 0x21c
function startdartremotecontrol(dart) {
    player = self;
    assert(isplayer(player));
    if (!dart.is_shutting_down) {
        dart usevehicle(player, 0);
        player.resurrect_not_allowed_by = undefined;
        dart clientfield::set("vehicletransition", 1);
        dart thread watchammo();
        dart thread vehicle::monitor_missiles_locked_on_to_me(player);
        dart thread vehicle::monitor_damage_as_occupant(player);
        player vehicle::set_vehicle_drivable_time_starting_now(30000);
        player.no_fade2black = 1;
        dart.inheliproximity = 0;
        minheightoverride = undefined;
        minz_struct = struct::get_array("vehicle_oob_minz", "targetname");
        if (isdefined(minz_struct) && isdefined(minz_struct[0])) {
            minheightoverride = minz_struct[0].origin[2];
        }
        dart thread qrdrone::qrdrone_watch_distance(2000, minheightoverride);
        dart.distance_shutdown_override = &dartdistancefailure;
        dart enabledartmissilelocking();
        visionset_mgr::activate("visionset", "dart_visionset", player, 1, 90000, 1);
        player clientfield::set_to_player("fog_bank_3", 1);
    }
}

// Namespace dart/dart
// Params 2, eflags: 0x0
// Checksum 0x796907e3, Offset: 0x1aa0
// Size: 0x2c
function enddartremotecontrol(dart, exitrequestedbyowner) {
    dart thread leave_dart();
}

// Namespace dart/dart
// Params 0, eflags: 0x0
// Checksum 0x9887ef35, Offset: 0x1ad8
// Size: 0x3c
function dartdistancefailure() {
    self.owner globallogic_audio::play_taacom_dialog("distanceCheck", "dart");
    thread stop_remote_weapon();
}

// Namespace dart/dart
// Params 2, eflags: 0x0
// Checksum 0xd767c435, Offset: 0x1b20
// Size: 0x1ac
function stop_remote_weapon(attacker, weapon) {
    dart = self;
    dart.detonateviaemp = undefined;
    attacker = dart [[ level.figure_out_attacker ]](attacker);
    if (isdefined(attacker) && (!isdefined(dart.owner) || dart.owner util::isenemyplayer(attacker))) {
        challenges::destroyedaircraft(attacker, weapon, 1);
        attacker challenges::addflyswatterstat(weapon, dart);
        dart killstreaks::function_8acf563(attacker, weapon, dart.owner);
        luinotifyevent(#"player_callout", 2, #"hash_5cbeb6b82bac95e5", attacker.entnum);
        attacker battlechatter::function_b5530e2c("dart", weapon);
    }
    if (isdefined(attacker) && attacker != dart.owner) {
        dart killstreaks::play_destroyed_dialog_on_owner("dart", dart.killstreak_id);
    }
    dart thread remote_weapons::endremotecontrolweaponuse(0);
}

// Namespace dart/dart
// Params 15, eflags: 0x0
// Checksum 0xd55891b3, Offset: 0x1cd8
// Size: 0x152
function dartdamageoverride(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    dart = self;
    if (smeansofdeath == "MOD_TRIGGER_HURT" || isdefined(dart.is_shutting_down) && dart.is_shutting_down) {
        return 0;
    }
    player = dart.owner;
    idamage = killstreaks::ondamageperweapon("dart", eattacker, idamage, idflags, smeansofdeath, weapon, dart.maxhealth, &stop_remote_weapon, self.maxhealth * 0.4, undefined, 0, &emp_damage_cb, 1, 1);
    return idamage;
}

// Namespace dart/dart
// Params 2, eflags: 0x0
// Checksum 0x1088c67, Offset: 0x1e38
// Size: 0x3c
function emp_damage_cb(attacker, weapon) {
    dart = self;
    dart stop_remote_weapon(attacker, weapon);
}

// Namespace dart/dart
// Params 0, eflags: 0x0
// Checksum 0xa1ff250b, Offset: 0x1e80
// Size: 0x78
function darpredictedcollision() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"veh_predictedcollision");
        self notify(#"veh_collision", waitresult);
        if (waitresult.stype == "glass") {
            continue;
        }
        break;
    }
}

// Namespace dart/dart
// Params 0, eflags: 0x0
// Checksum 0x424b6a9f, Offset: 0x1f00
// Size: 0xf4
function watchcollision() {
    dart = self;
    dart endon(#"death");
    dart.owner endon(#"disconnect");
    dart thread darpredictedcollision();
    while (true) {
        waitresult = dart waittill(#"veh_collision");
        if (waitresult.stype === "glass") {
            continue;
        }
        dart setspeedimmediate(0);
        dart vehicle_death::death_fx();
        dart thread stop_remote_weapon();
        break;
    }
}

// Namespace dart/dart
// Params 0, eflags: 0x0
// Checksum 0x1c8b04b3, Offset: 0x2000
// Size: 0x8c
function watchdeath() {
    dart = self;
    player = dart.owner;
    player endon(#"dart_entered");
    dart endon(#"delete");
    dart waittill(#"death");
    dart thread leave_dart();
}

// Namespace dart/dart
// Params 2, eflags: 0x0
// Checksum 0x533af3d2, Offset: 0x2098
// Size: 0xdc
function watchownernondeathevents(endcondition1, endcondition2) {
    dart = self;
    player = dart.owner;
    player endon(#"dart_entered");
    dart endon(#"death");
    dart thread watchforgameend();
    player waittill(#"joined_team", #"disconnect", #"joined_spectators", #"emp_jammed");
    dart thread leave_dart();
}

// Namespace dart/dart
// Params 0, eflags: 0x0
// Checksum 0x7ada33a, Offset: 0x2180
// Size: 0x5c
function watchforgameend() {
    dart = self;
    dart endon(#"death");
    level waittill(#"game_ended");
    dart thread leave_dart();
}

// Namespace dart/dart
// Params 0, eflags: 0x0
// Checksum 0x6b7b1618, Offset: 0x21e8
// Size: 0x194
function watchammo() {
    dart = self;
    dart endon(#"death");
    player = dart.owner;
    player endon(#"disconnect");
    shotcount = 0;
    params = level.killstreakbundle[#"dart"];
    if (!isdefined(params.ksdartshotcount)) {
        params.ksdartshotcount = 0;
    }
    if (!isdefined(params.ksdartwaittimeafterlastshot)) {
        params.ksdartwaittimeafterlastshot = 1;
    }
    player clientfield::set_to_player("dart_update_ammo", params.ksdartshotcount);
    while (shotcount < params.ksdartshotcount) {
        dart waittill(#"weapon_fired");
        shotcount++;
        player clientfield::set_to_player("dart_update_ammo", params.ksdartshotcount - shotcount);
    }
    dart disabledriverfiring(1);
    if (shotcount > 0) {
        wait params.ksdartwaittimeafterlastshot;
        dart stop_remote_weapon();
    }
}

// Namespace dart/dart
// Params 0, eflags: 0x0
// Checksum 0x2052ef24, Offset: 0x2388
// Size: 0x780
function leave_dart() {
    dart = self;
    owner = dart.owner;
    if (isdefined(owner)) {
        visionset_mgr::deactivate("visionset", "dart_visionset", owner);
        owner clientfield::set_to_player("fog_bank_3", 0);
        owner qrdrone::destroyhud();
    }
    if (isdefined(dart) && dart.is_shutting_down == 1) {
        return;
    }
    dart.is_shutting_down = 1;
    dart clientfield::set("timeout_beep", 0);
    dart vehicle::lights_off();
    dart vehicle_death::death_fx();
    dart hide();
    dart_original_team = dart.originalteam;
    dart_killstreak_id = dart.killstreak_id;
    if (target_istarget(dart)) {
        target_remove(dart);
    }
    if (isalive(dart)) {
        dart notify(#"death");
    }
    params = level.killstreakbundle[#"dart"];
    if (!isdefined(params.ksdartexplosionouterradius)) {
        params.ksdartexplosionouterradius = 200;
    }
    if (!isdefined(params.ksdartexplosioninnerradius)) {
        params.ksdartexplosioninnerradius = 1;
    }
    if (!isdefined(params.ksdartexplosionouterdamage)) {
        params.ksdartexplosionouterdamage = 25;
    }
    if (!isdefined(params.ksdartexplosioninnerdamage)) {
        params.ksdartexplosioninnerdamage = 350;
    }
    if (!isdefined(params.ksdartexplosionmagnitude)) {
        params.ksdartexplosionmagnitude = 1;
    }
    physicsexplosionsphere(dart.origin, params.ksdartexplosionouterradius, params.ksdartexplosioninnerradius, params.ksdartexplosionmagnitude, params.ksdartexplosionouterdamage, params.ksdartexplosioninnerdamage);
    if (isdefined(owner)) {
        owner killstreaks::set_killstreak_delay_killcam("dart");
        dart radiusdamage(dart.origin, params.ksdartexplosionouterradius, params.ksdartexplosioninnerdamage, params.ksdartexplosionouterdamage, owner, "MOD_EXPLOSIVE", getweapon(#"dart"));
        owner thread play_bda_dialog(dart.pilotindex);
        if (isdefined(dart.controlled) && dart.controlled || isdefined(dart.control_initiated) && dart.control_initiated) {
            owner setclientuivisibilityflag("hud_visible", 0);
            owner unlink();
            dart clientfield::set("vehicletransition", 0);
            if (isdefined(params.ksexplosionrumble)) {
                owner playrumbleonentity(params.ksexplosionrumble);
            }
            owner vehicle::stop_monitor_missiles_locked_on_to_me();
            owner vehicle::stop_monitor_damage_as_occupant();
            dart disabledartmissilelocking();
            owner val::set(#"dart", "freezecontrols", 1);
            forward = anglestoforward(dart.angles);
            if (!isdefined(params.ksdartcamerawatchdistance)) {
                params.ksdartcamerawatchdistance = 350;
            }
            moveamount = vectorscale(forward, params.ksdartcamerawatchdistance * -1);
            size = 4;
            trace = physicstrace(dart.origin, dart.origin + moveamount, (size * -1, size * -1, size * -1), (size, size, size), undefined, 1);
            cam = spawn("script_model", trace[#"position"]);
            cam setmodel(#"tag_origin");
            cam linkto(dart);
            dart setspeedimmediate(0);
            owner camerasetposition(cam.origin);
            owner camerasetlookat(dart.origin);
            owner cameraactivate(1);
            if (!isdefined(params.ksdartcamerawatchduration)) {
                params.ksdartcamerawatchduration = 2;
            }
            wait params.ksdartcamerawatchduration;
            if (isdefined(owner)) {
                owner cameraactivate(0);
            }
            cam delete();
            if (isdefined(owner)) {
                owner val::reset(#"dart", "freezecontrols");
                owner setclientuivisibilityflag("hud_visible", 1);
            }
        }
        if (isdefined(owner)) {
            owner killstreaks::reset_killstreak_delay_killcam();
        }
    }
    killstreakrules::killstreakstop("dart", dart_original_team, dart_killstreak_id);
    if (isdefined(dart)) {
        dart notify(#"dart_left");
    }
}

// Namespace dart/dart
// Params 1, eflags: 0x0
// Checksum 0x74949b39, Offset: 0x2b10
// Size: 0x74
function deleteonconditions(condition) {
    dart = self;
    dart endon(#"delete");
    if (isdefined(condition)) {
        dart waittill(condition);
    }
    dart notify(#"delete");
    dart delete();
}

// Namespace dart/dart
// Params 1, eflags: 0x0
// Checksum 0x2044f2d, Offset: 0x2b90
// Size: 0x4c
function waitthendelete(waittime) {
    self endon(#"delete");
    self endon(#"death");
    wait waittime;
    self delete();
}

// Namespace dart/dart
// Params 1, eflags: 0x0
// Checksum 0xbab8f942, Offset: 0x2be8
// Size: 0x106
function play_bda_dialog(pilotindex) {
    self endon(#"game_ended");
    wait 0.5;
    if (!isdefined(self.dartbda) || self.dartbda == 0) {
        bdadialog = "killNone";
    } else if (self.dartbda == 1) {
        bdadialog = "kill1";
    } else if (self.dartbda == 2) {
        bdadialog = "kill2";
    } else if (self.dartbda == 3) {
        bdadialog = "kill3";
    } else if (self.dartbda > 3) {
        bdadialog = "killMultiple";
    }
    self globallogic_audio::play_taacom_dialog(bdadialog, "dart");
    self.dartbda = undefined;
}

// Namespace dart/dart
// Params 0, eflags: 0x0
// Checksum 0x1145f88c, Offset: 0x2cf8
// Size: 0xbc
function enabledartmissilelocking() {
    dart = self;
    player = dart.owner;
    weapon = dart seatgetweapon(0);
    player.get_stinger_target_override = &getdartmissiletargets;
    player.is_still_valid_target_for_stinger_override = &isstillvaliddartmissiletarget;
    player.is_valid_target_for_stinger_override = &isvaliddartmissiletarget;
    player.dart_killstreak_weapon = weapon;
    player thread heatseekingmissile::stingerirtloop(weapon);
}

// Namespace dart/dart
// Params 0, eflags: 0x0
// Checksum 0x2c6fa10f, Offset: 0x2dc0
// Size: 0x84
function disabledartmissilelocking() {
    dart = self;
    player = dart.owner;
    player.get_stinger_target_override = undefined;
    player.is_still_valid_target_for_stinger_override = undefined;
    player.is_valid_target_for_stinger_override = undefined;
    player.dart_killstreak_weapon = undefined;
    player notify(#"stinger_irt_off");
    player heatseekingmissile::clearirtarget();
}

// Namespace dart/dart
// Params 0, eflags: 0x0
// Checksum 0xca6f7ba6, Offset: 0x2e50
// Size: 0x6a
function getdartmissiletargets() {
    targets = arraycombine(target_getarray(), level.missileentities, 0, 0);
    targets = arraycombine(targets, level.players, 0, 0);
    return targets;
}

// Namespace dart/dart
// Params 1, eflags: 0x0
// Checksum 0xf1661b40, Offset: 0x2ec8
// Size: 0x140
function isvaliddartmissiletarget(ent) {
    player = self;
    if (!isdefined(ent)) {
        return false;
    }
    entisplayer = isplayer(ent);
    if (entisplayer && !isalive(ent)) {
        return false;
    }
    if (ent.ignoreme === 1) {
        return false;
    }
    dart = player getvehicleoccupied();
    if (!isdefined(dart)) {
        return false;
    }
    if (distancesquared(dart.origin, ent.origin) > player.dart_killstreak_weapon.lockonmaxrange * player.dart_killstreak_weapon.lockonmaxrange) {
        return false;
    }
    if (entisplayer && ent hasperk(#"specialty_nokillstreakreticle")) {
        return false;
    }
    return true;
}

// Namespace dart/dart
// Params 2, eflags: 0x0
// Checksum 0xf7fd99a3, Offset: 0x3010
// Size: 0x1ae
function isstillvaliddartmissiletarget(ent, weapon) {
    player = self;
    if (!(target_istarget(ent) || isplayer(ent)) && !(isdefined(ent.allowcontinuedlockonafterinvis) && ent.allowcontinuedlockonafterinvis)) {
        return false;
    }
    dart = player getvehicleoccupied();
    if (!isdefined(dart)) {
        return false;
    }
    entisplayer = isplayer(ent);
    if (entisplayer && !isalive(ent)) {
        return false;
    }
    if (ent.ignoreme === 1) {
        return false;
    }
    if (distancesquared(dart.origin, ent.origin) > player.dart_killstreak_weapon.lockonmaxrange * player.dart_killstreak_weapon.lockonmaxrange) {
        return false;
    }
    if (entisplayer && ent hasperk(#"specialty_nokillstreakreticle")) {
        return false;
    }
    if (!heatseekingmissile::insidestingerreticlelocked(ent, undefined, weapon)) {
        return false;
    }
    return true;
}

