#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\wasp;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\killstreaks\ai\lead_drone;
#using scripts\killstreaks\ai\wing_drone;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\qrdrone;
#using scripts\killstreaks\remote_weapons;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\weapons\heatseekingmissile;

#namespace drone_squadron;

// Namespace drone_squadron/drone_squadron
// Params 0, eflags: 0x2
// Checksum 0xfe97ce53, Offset: 0x2e8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"drone_squadron", &__init__, undefined, #"killstreaks");
}

// Namespace drone_squadron/drone_squadron
// Params 0, eflags: 0x0
// Checksum 0xbdff2542, Offset: 0x338
// Size: 0x224
function __init__() {
    qrdrone::init_shared();
    wing_drone::init_shared();
    killstreaks::register_killstreak("killstreak_drone_squadron", &function_580007ff);
    killstreaks::register_alt_weapon("drone_squadron", getweapon(#"killstreak_remote"));
    killstreaks::register_alt_weapon("drone_squadron", getweapon(#"hash_26ffb92552ae26be"));
    killstreaks::register_alt_weapon("drone_squadron", getweapon(#"hash_5fbda3ef4b135b49"));
    remote_weapons::registerremoteweapon("drone_squadron", #"hash_7c833954874f735d", &function_52b54771, &function_1e502d22, 0);
    level.killstreaks[#"drone_squadron"].threatonkill = 1;
    visionset_mgr::register_info("visionset", "drone_squadron_visionset", 1, 120, 16, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
    callback::on_joined_team(&function_efc7454f);
    callback::on_joined_spectate(&function_efc7454f);
    callback::on_disconnect(&function_efc7454f);
    callback::on_player_killed(&function_efc7454f);
}

// Namespace drone_squadron/drone_squadron
// Params 2, eflags: 0x0
// Checksum 0x10b90d8, Offset: 0x568
// Size: 0x3e4
function calcspawnorigin(origin, angles) {
    heightoffset = killstreaks::function_9a3c718e();
    mins = (-5, -5, 0);
    maxs = (5, 5, 10);
    startpoints = [];
    testangles = [];
    testangles[0] = (0, 0, 0);
    testangles[1] = (0, 30, 0);
    testangles[2] = (0, -30, 0);
    testangles[3] = (0, 60, 0);
    testangles[4] = (0, -60, 0);
    testangles[3] = (0, 90, 0);
    testangles[4] = (0, -90, 0);
    bestorigin = origin;
    bestangles = angles;
    bestfrac = 0;
    for (i = 0; i < testangles.size; i++) {
        startpoint = origin + (0, 0, heightoffset);
        endpoint = startpoint + vectorscale(anglestoforward((0, angles[1], 0) + testangles[i]), 70);
        mask = 1 | 2;
        trace = physicstrace(startpoint, endpoint, mins, maxs, self, mask);
        if (isdefined(trace[#"entity"]) && isplayer(trace[#"entity"])) {
            continue;
        }
        if (trace[#"fraction"] > bestfrac) {
            bestfrac = trace[#"fraction"];
            bestorigin = trace[#"position"];
            bestangles = (0, angles[1], 0) + testangles[i];
            if (bestfrac == 1) {
                break;
            }
        }
    }
    if (bestfrac > 0) {
        if (distance2dsquared(origin, bestorigin) < 400) {
            return undefined;
        }
        trace = physicstrace(bestorigin, bestorigin + (0, 0, 50), mins, maxs, self, mask);
        var_e161fddb = trace[#"position"];
        var_f820f3e7 = getclosestpointonnavvolume(bestorigin, "navvolume_big", 2000);
        if (isdefined(var_f820f3e7)) {
            var_e161fddb = var_f820f3e7;
        }
        placement = spawnstruct();
        placement.origin = var_e161fddb;
        placement.angles = bestangles;
        return placement;
    }
    return undefined;
}

// Namespace drone_squadron/drone_squadron
// Params 1, eflags: 0x0
// Checksum 0x960349ad, Offset: 0x958
// Size: 0x964
function function_580007ff(killstreaktype) {
    assert(isplayer(self));
    player = self;
    if (!isnavvolumeloaded()) {
        /#
            iprintlnbold("<dev string:x30>");
        #/
        self iprintlnbold(#"hash_62ced7a8acdaa034");
        return false;
    }
    if (player isplayerswimming()) {
        self iprintlnbold(#"hash_425241374bdd61f0");
        return false;
    }
    spawnpos = calcspawnorigin(player.origin, player.angles);
    if (!isdefined(spawnpos)) {
        self iprintlnbold(#"hash_425241374bdd61f0");
        return false;
    }
    killstreak_id = player killstreakrules::killstreakstart("drone_squadron", player.team, 0, 1);
    if (killstreak_id == -1) {
        return false;
    }
    player stats::function_4f10b697(getweapon(#"drone_squadron"), #"used", 1);
    drone_squadron = spawnvehicle("veh_drone_squadron_mp", spawnpos.origin, spawnpos.angles, "dynamic_spawn_ai");
    drone_squadron killstreaks::configure_team("drone_squadron", killstreak_id, player, "small_vehicle", undefined, &configureteampost);
    drone_squadron killstreak_hacking::enable_hacking("drone_squadron", &hackedcallbackpre, &hackedcallbackpost);
    drone_squadron.killstreak_id = killstreak_id;
    drone_squadron.killstreak_end_time = gettime() + 60000;
    drone_squadron.original_vehicle_type = drone_squadron.vehicletype;
    drone_squadron.ignore_vehicle_underneath_splash_scalar = 1;
    drone_squadron clientfield::set("enemyvehicle", 1);
    drone_squadron.hardpointtype = "drone_squadron";
    drone_squadron.soundmod = "player";
    drone_squadron.maxhealth = killstreak_bundles::get_max_health("drone_squadron");
    drone_squadron.lowhealth = killstreak_bundles::get_low_health("drone_squadron");
    drone_squadron.health = drone_squadron.maxhealth;
    drone_squadron.hackedhealth = killstreak_bundles::get_hacked_health("drone_squadron");
    drone_squadron.rocketdamage = drone_squadron.maxhealth / 2 + 1;
    drone_squadron.playeddamaged = 0;
    drone_squadron.treat_owner_damage_as_friendly_fire = 1;
    drone_squadron.ignore_team_kills = 1;
    drone_squadron.goalradius = 4000;
    drone_squadron.goalheight = 500;
    drone_squadron.enable_guard = 1;
    drone_squadron.always_face_enemy = 1;
    drone_squadron thread killstreaks::waitfortimeout("drone_squadron", 60000, &ontimeout, "drone_squadron_shutdown");
    drone_squadron thread killstreaks::waitfortimecheck(60000 * 0.5, &ontimecheck, "death", "drone_squadron_shutdown");
    drone_squadron thread watchwater();
    drone_squadron thread watchdeath();
    drone_squadron thread watchshutdown();
    drone_squadron vehicle::init_target_group();
    drone_squadron vehicle::add_to_target_group(drone_squadron);
    drone_squadron setrotorspeed(1);
    drone_squadron.protectent = self;
    params = level.killstreakbundle[#"drone_squadron"];
    immediate_use = isdefined(params.ksuseimmediately) ? params.ksuseimmediately : 0;
    if (!isdefined(drone_squadron.wing_drone)) {
        drone_squadron.wing_drone = [];
    }
    drone_right = anglestoright(drone_squadron.angles);
    var_b5cf4f3f = drone_right * -1;
    var_48ff21bd = anglestoforward(drone_squadron.angles) * -1;
    waitframe(1);
    var_a4e2807d = drone_squadron.origin + drone_right * 128 + var_48ff21bd * 128;
    wing_drone = spawnvehicle("spawner_boct_mp_wing_drone", var_a4e2807d, drone_squadron.angles, "wing_drone_ai");
    wing_drone.leader = drone_squadron;
    wing_drone setteam(drone_squadron.team);
    wing_drone.team = drone_squadron.team;
    wing_drone.formation = "right";
    wing_drone setrotorspeed(1);
    wing_drone.protectent = self;
    drone_squadron.wing_drone[drone_squadron.wing_drone.size] = wing_drone;
    player.drone_squadron = drone_squadron;
    player.var_f8e601b0 = 1;
    waitframe(1);
    var_a4e2807d = drone_squadron.origin + var_b5cf4f3f * 128 + var_48ff21bd * 128;
    wing_drone = spawnvehicle("spawner_boct_mp_wing_drone", var_a4e2807d, drone_squadron.angles, "wing_drone_ai");
    wing_drone.leader = drone_squadron;
    wing_drone setteam(drone_squadron.team);
    wing_drone.team = drone_squadron.team;
    wing_drone.formation = "left";
    wing_drone setrotorspeed(1);
    wing_drone.protectent = self;
    drone_squadron.wing_drone[drone_squadron.wing_drone.size] = wing_drone;
    self killstreaks::play_killstreak_start_dialog("drone_squadron", self.team, killstreak_id);
    drone_squadron killstreaks::play_pilot_dialog_on_owner("arrive", "drone_squadron", killstreak_id);
    drone_squadron thread watchgameended();
    drone_squadron thread vehicle::watch_freeze_on_flash(3);
    foreach (drone in drone_squadron.wing_drone) {
        drone thread vehicle::watch_freeze_on_flash(3);
        drone callback::function_1dea870d(#"on_vehicle_killed", &function_f3f17304);
    }
    return true;
}

// Namespace drone_squadron/drone_squadron
// Params 1, eflags: 0x0
// Checksum 0xe49efcac, Offset: 0x12c8
// Size: 0xec
function hackedcallbackpre(hacker) {
    drone_squadron = self;
    drone_squadron.owner unlink();
    drone_squadron clientfield::set("vehicletransition", 0);
    if (drone_squadron.controlled === 1) {
        visionset_mgr::deactivate("visionset", "drone_squadron_visionset", drone_squadron.owner);
    }
    drone_squadron.owner remote_weapons::removeandassignnewremotecontroltrigger(drone_squadron.usetrigger);
    drone_squadron remote_weapons::endremotecontrolweaponuse(1);
    function_1e502d22(drone_squadron, 1);
}

// Namespace drone_squadron/drone_squadron
// Params 1, eflags: 0x0
// Checksum 0x40b0c99c, Offset: 0x13c0
// Size: 0x76
function hackedcallbackpost(hacker) {
    drone_squadron = self;
    hacker remote_weapons::useremoteweapon(drone_squadron, "drone_squadron", 0);
    drone_squadron notify(#"watchremotecontroldeactivate_remoteweapons");
    drone_squadron.killstreak_end_time = hacker killstreak_hacking::set_vehicle_drivable_time_starting_now(drone_squadron);
}

// Namespace drone_squadron/drone_squadron
// Params 2, eflags: 0x0
// Checksum 0xfcc9be5d, Offset: 0x1440
// Size: 0x34
function configureteampost(owner, ishacked) {
    drone_squadron = self;
    drone_squadron thread watchteamchange();
}

// Namespace drone_squadron/drone_squadron
// Params 0, eflags: 0x0
// Checksum 0x18af498c, Offset: 0x1480
// Size: 0x78
function watchgameended() {
    drone_squadron = self;
    drone_squadron endon(#"death");
    level waittill(#"game_ended");
    drone_squadron.abandoned = 1;
    drone_squadron.selfdestruct = 1;
    drone_squadron notify(#"drone_squadron_shutdown");
}

// Namespace drone_squadron/drone_squadron
// Params 1, eflags: 0x0
// Checksum 0x4fec21c3, Offset: 0x1500
// Size: 0x224
function function_52b54771(drone_squadron) {
    player = self;
    assert(isplayer(player));
    drone_squadron usevehicle(player, 0);
    drone_squadron clientfield::set("vehicletransition", 1);
    drone_squadron thread audio::sndupdatevehiclecontext(1);
    drone_squadron thread vehicle::monitor_missiles_locked_on_to_me(player);
    drone_squadron.inheliproximity = 0;
    drone_squadron.treat_owner_damage_as_friendly_fire = 0;
    drone_squadron.ignore_team_kills = 0;
    minheightoverride = undefined;
    minz_struct = struct::get_array("vehicle_oob_minz", "targetname");
    if (isdefined(minz_struct) && isdefined(minz_struct[0])) {
        minheightoverride = minz_struct[0].origin[2];
    }
    drone_squadron thread qrdrone::qrdrone_watch_distance(2000, minheightoverride);
    drone_squadron.distance_shutdown_override = &function_28921c3f;
    drone_squadron.owner killstreaks::thermal_glow(1);
    player vehicle::set_vehicle_drivable_time(60000, drone_squadron.killstreak_end_time);
    visionset_mgr::activate("visionset", "drone_squadron_visionset", player, 1, 90000, 1);
    if (isdefined(drone_squadron.playerdrivenversion)) {
        drone_squadron setvehicletype(drone_squadron.playerdrivenversion);
    }
}

// Namespace drone_squadron/drone_squadron
// Params 2, eflags: 0x0
// Checksum 0x13e69695, Offset: 0x1730
// Size: 0x224
function function_1e502d22(drone_squadron, exitrequestedbyowner) {
    drone_squadron.treat_owner_damage_as_friendly_fire = 1;
    drone_squadron.ignore_team_kills = 1;
    if (isdefined(drone_squadron.owner)) {
        drone_squadron.owner vehicle::stop_monitor_missiles_locked_on_to_me();
        if (drone_squadron.controlled === 1) {
            visionset_mgr::deactivate("visionset", "drone_squadron_visionset", drone_squadron.owner);
        }
        if (isbot(drone_squadron.owner)) {
            drone_squadron.owner ai::set_behavior_attribute("control", "commander");
        }
    }
    params = level.killstreakbundle[#"drone_squadron"];
    shutdown_on_exit = isdefined(params.ksshutdownonexit) ? params.ksshutdownonexit : 0;
    if (exitrequestedbyowner || shutdown_on_exit) {
        if (isdefined(drone_squadron.owner)) {
            drone_squadron.owner qrdrone::destroyhud();
            drone_squadron.owner killstreaks::thermal_glow(0);
            drone_squadron.owner unlink();
            drone_squadron clientfield::set("vehicletransition", 0);
        }
        drone_squadron thread audio::sndupdatevehiclecontext(0);
    }
    if (isdefined(drone_squadron.original_vehicle_type)) {
        drone_squadron.vehicletype = drone_squadron.original_vehicle_type;
    }
    if (shutdown_on_exit) {
        drone_squadron ontimeout();
    }
}

// Namespace drone_squadron/drone_squadron
// Params 0, eflags: 0x0
// Checksum 0xb2f7198a, Offset: 0x1960
// Size: 0x140
function ontimeout() {
    drone_squadron = self;
    drone_squadron.owner globallogic_audio::play_taacom_dialog("timeout", "drone_squadron");
    function_1c76ec57(drone_squadron.owner);
    params = level.killstreakbundle[#"drone_squadron"];
    if (isdefined(drone_squadron.owner)) {
        radiusdamage(drone_squadron.origin, params.ksexplosionouterradius, params.ksexplosioninnerdamage, params.ksexplosionouterdamage, drone_squadron.owner, "MOD_EXPLOSIVE", getweapon("drone_squadron"));
        if (isdefined(params.ksexplosionrumble)) {
            drone_squadron.owner playrumbleonentity(params.ksexplosionrumble);
        }
    }
    drone_squadron notify(#"drone_squadron_shutdown");
}

// Namespace drone_squadron/drone_squadron
// Params 0, eflags: 0x0
// Checksum 0x29b2885d, Offset: 0x1aa8
// Size: 0x34
function ontimecheck() {
    self killstreaks::play_pilot_dialog_on_owner("timecheck", "drone_squadron", self.killstreak_id);
}

// Namespace drone_squadron/drone_squadron
// Params 0, eflags: 0x0
// Checksum 0x14280d80, Offset: 0x1ae8
// Size: 0x4e
function function_28921c3f() {
    if (isdefined(self.owner)) {
        self.owner globallogic_audio::play_taacom_dialog("distanceCheck", "drone_squadron");
    }
    self notify(#"drone_squadron_shutdown");
}

// Namespace drone_squadron/drone_squadron
// Params 1, eflags: 0x0
// Checksum 0x5ee39c8c, Offset: 0x1b40
// Size: 0xcc
function function_f3f17304(params) {
    attacker = params.eattacker;
    weapon = params.weapon;
    attacker = self [[ level.figure_out_attacker ]](attacker);
    if (isdefined(attacker) && (!isdefined(self.owner) || self.owner util::isenemyplayer(attacker))) {
        if (isplayer(attacker)) {
            scoreevents::processscoreevent(#"hash_8bf3519db5f0fd4", attacker, self.owner, weapon);
        }
    }
}

// Namespace drone_squadron/drone_squadron
// Params 0, eflags: 0x0
// Checksum 0x77a2b9bb, Offset: 0x1c18
// Size: 0x25c
function watchdeath() {
    drone_squadron = self;
    waitresult = drone_squadron waittill(#"death");
    attacker = waitresult.attacker;
    weapon = waitresult.weapon;
    modtype = waitresult.mod;
    drone_squadron notify(#"drone_squadron_shutdown");
    attacker = self [[ level.figure_out_attacker ]](attacker);
    if (isdefined(attacker) && (!isdefined(self.owner) || self.owner util::isenemyplayer(attacker))) {
        if (isplayer(attacker)) {
            challenges::destroyedaircraft(attacker, weapon, drone_squadron.controlled === 1);
            attacker challenges::addflyswatterstat(weapon, self);
            attacker stats::function_4f10b697(weapon, #"hash_45a6b982e3144181", 1);
            drone_squadron killstreaks::function_8acf563(attacker, weapon, drone_squadron.owner);
            attacker battlechatter::function_b5530e2c("drone_squadron", weapon);
            if (modtype == "MOD_RIFLE_BULLET" || modtype == "MOD_PISTOL_BULLET") {
            }
            luinotifyevent(#"player_callout", 2, #"hash_32fcc2097e294f0a", attacker.entnum);
        }
        if (isdefined(drone_squadron) && isdefined(drone_squadron.owner)) {
            drone_squadron killstreaks::play_destroyed_dialog_on_owner("drone_squadron", drone_squadron.killstreak_id);
        }
    }
}

// Namespace drone_squadron/drone_squadron
// Params 0, eflags: 0x0
// Checksum 0x513a76c6, Offset: 0x1e80
// Size: 0xa0
function watchteamchange() {
    self notify(#"hash_7e3a7db8b681733");
    self endon(#"hash_7e3a7db8b681733");
    drone_squadron = self;
    drone_squadron endon(#"drone_squadron_shutdown");
    drone_squadron.owner waittill(#"joined_team", #"disconnect", #"joined_spectators");
    drone_squadron notify(#"drone_squadron_shutdown");
}

// Namespace drone_squadron/drone_squadron
// Params 0, eflags: 0x0
// Checksum 0xf87982e0, Offset: 0x1f28
// Size: 0xe0
function watchwater() {
    drone_squadron = self;
    drone_squadron endon(#"drone_squadron_shutdown");
    while (true) {
        wait 0.1;
        trace = physicstrace(self.origin + (0, 0, 10), self.origin + (0, 0, 6), (-2, -2, -2), (2, 2, 2), self, 4);
        if (trace[#"fraction"] < 1) {
            break;
        }
    }
    drone_squadron notify(#"drone_squadron_shutdown");
}

// Namespace drone_squadron/drone_squadron
// Params 0, eflags: 0x0
// Checksum 0xb6eb3097, Offset: 0x2010
// Size: 0x244
function watchshutdown() {
    drone_squadron = self;
    drone_squadron waittill(#"drone_squadron_shutdown");
    if (isdefined(drone_squadron.control_initiated) && drone_squadron.control_initiated || isdefined(drone_squadron.controlled) && drone_squadron.controlled) {
        drone_squadron remote_weapons::endremotecontrolweaponuse(0);
        while (isdefined(drone_squadron.control_initiated) && drone_squadron.control_initiated || isdefined(drone_squadron.controlled) && drone_squadron.controlled) {
            waitframe(1);
        }
    }
    if (isdefined(drone_squadron.owner)) {
        drone_squadron.owner qrdrone::destroyhud();
        drone_squadron.owner killstreaks::thermal_glow(0);
    }
    killstreakrules::killstreakstop("drone_squadron", drone_squadron.originalteam, drone_squadron.killstreak_id);
    function_1c76ec57(drone_squadron.owner);
    if (isalive(drone_squadron)) {
        if (isdefined(drone_squadron.wing_drone)) {
            drone_squadron.wing_drone = array::remove_undefined(drone_squadron.wing_drone);
            foreach (wing_drone in drone_squadron.wing_drone) {
                wing_drone kill();
            }
        }
        drone_squadron kill();
    }
}

// Namespace drone_squadron/drone_squadron
// Params 0, eflags: 0x0
// Checksum 0xe3cfee17, Offset: 0x2260
// Size: 0x330
function function_d90926cf() {
    self endon(#"death");
    self endon(#"drone_squadron_shutdown");
    self thread function_cd225242();
    while (true) {
        self.targets = [];
        self.wing_drone = array::remove_undefined(self.wing_drone);
        if (!isdefined(self.wing_drone) || !self.wing_drone.size) {
            return;
        }
        foreach (player in util::get_players()) {
            if (player.team == self.team) {
                continue;
            }
            if (!isalive(player)) {
                continue;
            }
            direction = self.owner getplayerangles();
            direction_vec = anglestoforward(direction);
            eye_pos = self.owner getplayercamerapos();
            direction_vec = (direction_vec[0] * 5000, direction_vec[1] * 5000, direction_vec[2] * 5000);
            trace = bullettrace(eye_pos, eye_pos + direction_vec, 1, self.owner, 1, 1, self);
            var_facb7601 = trace[#"position"];
            var_9fbeaf25 = vectornormalize(anglestoforward(direction));
            var_845f1157 = 5000 * 5000;
            if (distancesquared(eye_pos, player.origin) < var_845f1157) {
                if (player sightconetrace(eye_pos, self.owner, var_9fbeaf25, 8)) {
                    self.targets[self.targets.size] = player;
                }
            }
            self.targets[0] = arraygetclosest(var_facb7601, self.targets);
        }
        util::wait_network_frame(1);
    }
}

// Namespace drone_squadron/drone_squadron
// Params 0, eflags: 0x0
// Checksum 0x45d67004, Offset: 0x2598
// Size: 0x440
function function_cd225242() {
    assert(isdefined(self.owner));
    player = self.owner;
    leaddrone = self;
    player endon(#"death");
    leaddrone endon(#"death");
    leaddrone endon(#"drone_squadron_shutdown");
    function_21cd2472(player);
    function_d16e4af4(player);
    assert(isdefined(player.var_4ad7a62));
    assert(isdefined(player.var_d1bd2233));
    while (true) {
        if (isdefined(self.isstunned) && self.isstunned) {
            waitframe(1);
            continue;
        }
        if (!isdefined(player.var_63a72b3e)) {
            function_19c94ceb(player, undefined);
            function_1e2f9e65(leaddrone, undefined);
        } else if (!isalive(player.var_63a72b3e)) {
            function_19c94ceb(player, undefined);
            function_1e2f9e65(leaddrone, undefined);
        } else if (!function_c8ad960b(leaddrone)) {
            function_19c94ceb(player, undefined);
            function_1e2f9e65(leaddrone, undefined);
        }
        if (isdefined(player.var_ae7c5c9a) && !isalive(player.var_ae7c5c9a)) {
            function_6ffa905d(player, undefined);
        } else if (isdefined(leaddrone.targets) && !leaddrone.targets.size) {
            function_6ffa905d(player, undefined);
        }
        if (isdefined(leaddrone.targets) && leaddrone.targets.size && isdefined(leaddrone.targets[0])) {
            if (isdefined(player.var_63a72b3e) && player.var_63a72b3e == leaddrone.targets[0]) {
                waitframe(1);
                continue;
            }
        }
        if (isdefined(leaddrone.targets) && leaddrone.targets.size && isdefined(leaddrone.targets[0]) && isalive(leaddrone.targets[0])) {
            function_6ffa905d(player, leaddrone.targets[0]);
        }
        if (player jumpbuttonpressed()) {
            if (isdefined(leaddrone.targets) && leaddrone.targets.size > 0) {
                function_1e2f9e65(leaddrone, leaddrone.targets[0]);
                function_6ffa905d(player, undefined);
                function_19c94ceb(player, leaddrone.targets[0]);
            }
        }
        util::wait_network_frame(1);
    }
}

// Namespace drone_squadron/drone_squadron
// Params 2, eflags: 0x4
// Checksum 0xe50880c4, Offset: 0x29e0
// Size: 0x8e
function private function_1e2f9e65(leaddrone, target) {
    foreach (drone in leaddrone.wing_drone) {
        if (isdefined(drone)) {
            drone.favoriteenemy = target;
        }
    }
}

// Namespace drone_squadron/drone_squadron
// Params 1, eflags: 0x4
// Checksum 0x739750ab, Offset: 0x2a78
// Size: 0xce
function private function_c8ad960b(leaddrone) {
    var_a140d009 = leaddrone.wing_drone.size;
    validcount = 0;
    foreach (drone in leaddrone.wing_drone) {
        if (isdefined(drone) && isdefined(drone.favoriteenemy)) {
            validcount++;
        }
    }
    if (validcount >= var_a140d009) {
        return true;
    }
    return false;
}

// Namespace drone_squadron/drone_squadron
// Params 1, eflags: 0x4
// Checksum 0xd2217a5d, Offset: 0x2b50
// Size: 0xac
function private function_21cd2472(player) {
    player.var_4ad7a62 = gameobjects::get_next_obj_id();
    objective_add(player.var_4ad7a62, "active", undefined, #"hash_19883df3d28a354a");
    objective_setprogress(player.var_4ad7a62, 1);
    function_eeba3a5c(player.var_4ad7a62, 1);
    objective_setinvisibletoall(player.var_4ad7a62);
}

// Namespace drone_squadron/drone_squadron
// Params 2, eflags: 0x4
// Checksum 0xfda98c4f, Offset: 0x2c08
// Size: 0xcc
function private function_6ffa905d(player, target) {
    assert(isdefined(player.var_4ad7a62));
    if (isdefined(target)) {
        player.var_ae7c5c9a = target;
        objective_onentity(player.var_4ad7a62, target);
        objective_setvisibletoplayer(player.var_4ad7a62, player);
        return;
    }
    player.var_ae7c5c9a = undefined;
    objective_clearentity(player.var_4ad7a62);
    objective_setinvisibletoall(player.var_4ad7a62);
}

// Namespace drone_squadron/drone_squadron
// Params 1, eflags: 0x4
// Checksum 0x4087344, Offset: 0x2ce0
// Size: 0xac
function private function_d16e4af4(player) {
    player.var_d1bd2233 = gameobjects::get_next_obj_id();
    objective_add(player.var_d1bd2233, "active", undefined, #"hash_247ae058537c8726");
    objective_setprogress(player.var_d1bd2233, 1);
    function_eeba3a5c(player.var_d1bd2233, 1);
    objective_setinvisibletoall(player.var_d1bd2233);
}

// Namespace drone_squadron/drone_squadron
// Params 2, eflags: 0x4
// Checksum 0x511c8ba2, Offset: 0x2d98
// Size: 0xcc
function private function_19c94ceb(player, target) {
    assert(isdefined(player.var_d1bd2233));
    if (isdefined(target)) {
        player.var_63a72b3e = target;
        objective_onentity(player.var_d1bd2233, target);
        objective_setvisibletoplayer(player.var_d1bd2233, player);
        return;
    }
    player.var_63a72b3e = undefined;
    objective_clearentity(player.var_d1bd2233);
    objective_setinvisibletoall(player.var_d1bd2233);
}

// Namespace drone_squadron/drone_squadron
// Params 1, eflags: 0x4
// Checksum 0x82e2b2d3, Offset: 0x2e70
// Size: 0xc6
function private function_1c76ec57(player) {
    if (isdefined(player.var_d1bd2233)) {
        objective_delete(player.var_d1bd2233);
        gameobjects::release_obj_id(player.var_d1bd2233);
        player.var_63a72b3e = undefined;
        player.var_d1bd2233 = undefined;
    }
    if (isdefined(player.var_4ad7a62)) {
        objective_delete(player.var_4ad7a62);
        gameobjects::release_obj_id(player.var_4ad7a62);
        player.var_ae7c5c9a = undefined;
        player.var_4ad7a62 = undefined;
    }
    player.var_f8e601b0 = undefined;
}

// Namespace drone_squadron/drone_squadron
// Params 1, eflags: 0x4
// Checksum 0x3bebd935, Offset: 0x2f40
// Size: 0x54
function private function_efc7454f(params) {
    player = self;
    if (isdefined(player.var_f8e601b0) && player.var_f8e601b0) {
        function_1c76ec57(player);
    }
}

