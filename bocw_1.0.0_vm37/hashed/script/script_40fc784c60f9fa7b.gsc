#using script_1160d62024d6945b;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\killstreaks_util;

#namespace player_vehicle;

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x6
// Checksum 0xc0951753, Offset: 0x3c0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"player_vehicle", &preinit, undefined, undefined, undefined);
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x4
// Checksum 0x8797a249, Offset: 0x408
// Size: 0x254
function private preinit() {
    callback::on_vehicle_spawned(&on_vehicle_spawned);
    callback::on_vehicle_damage(&on_vehicle_damage);
    callback::on_vehicle_killed(&on_vehicle_killed);
    callback::on_player_damage(&on_player_damage);
    callback::on_player_killed(&on_player_killed);
    callback::on_end_game(&on_end_game);
    clientfield::register("vehicle", "overheat_fx", 1, 1, "int");
    clientfield::register("vehicle", "overheat_fx1", 1, 1, "int");
    clientfield::register("vehicle", "overheat_fx2", 1, 1, "int");
    clientfield::register("vehicle", "overheat_fx3", 1, 1, "int");
    clientfield::register("vehicle", "overheat_fx4", 1, 1, "int");
    clientfield::register("toplayer", "toggle_vehicle_sensor", 1, 1, "int");
    level.var_2513e40c = &function_2513e40c;
    level thread function_69c9e9a0();
    level.is_staircase_up = &is_staircase_up;
    level.var_80d8731e = 0;
    level.var_6ed50229 = 10;
    level.vehicle_tracking = [];
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x4
// Checksum 0x5643a44c, Offset: 0x668
// Size: 0x144
function private on_vehicle_spawned() {
    if (!is_true(self.isplayervehicle)) {
        return;
    }
    self function_4edde887();
    callback::callback(#"hash_5ca3a1f306039e1e");
    params = spawnstruct();
    params.origin = self.origin;
    params.var_45e1ab0 = self function_546791ef();
    self thread namespace_d0eacb0d::function_711f53df(self.vehicletype, self.origin, self.angles, &function_934f56ec, params);
    if (isdefined(self.settings.var_b40b5493)) {
        self influencers::create_influencer_generic(self.settings.var_b40b5493, self, "any");
    }
    level.vehicle_tracking[level.vehicle_tracking.size] = self;
    self function_7ae07b7();
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x4
// Checksum 0x1366ac61, Offset: 0x7b8
// Size: 0x2a4
function private function_4edde887() {
    if (isdefined(self.scriptbundlesettings)) {
        self.settings = getscriptbundle(self.scriptbundlesettings);
    }
    if (self function_b835102b() && !(self.vehicleclass === "boat") && !(self.vehicleclass === "helicopter") && !(self.vehicleclass === "plane")) {
        self function_3f24c5a(1);
    }
    self.var_ffdf490c = 1;
    self.script_disconnectpaths = 0;
    self.do_scripted_crash = 0;
    self.var_97f1b32a = 1;
    self.emped = 0;
    self.vehkilloccupantsondeath = 1;
    self.trackingindex = level.var_80d8731e;
    level.var_80d8731e++;
    target_set(self, (0, 0, 0));
    self callback::function_d8abfc3d(#"hash_1a32e0fdeb70a76b", &function_c25f7d1);
    if (isdefined(self.settings) && is_true(self.settings.var_2627e80a)) {
        self callback::function_d8abfc3d(#"hash_6e388f6a0df7bdac", &function_ef44d420);
    }
    if (isdefined(self.settings)) {
        if (is_true(self.settings.ismovingplatform)) {
            self setmovingplatformenabled(1, 0);
        }
    }
    if (!isairborne(self)) {
        self callback::on_vehicle_collision(&on_vehicle_collision);
    }
    if (!isairborne(self) && !(self.vehicleclass === "boat")) {
        self.disconnectpathdetail = 0;
        self function_d733412a(1);
    }
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x0
// Checksum 0xd2714844, Offset: 0xa68
// Size: 0xc2
function function_bc79899e() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::add_interrupt_connection("driving", "off", "exit_vehicle", &vehicle_ai::function_6664e3af);
    self vehicle_ai::add_interrupt_connection("driving", "off", "emped_vehicle", &vehicle_ai::function_6664e3af);
    self vehicle_ai::get_state_callbacks("driving").enter_func = &function_25b9a9b;
}

// Namespace player_vehicle/player_vehicle
// Params 2, eflags: 0x0
// Checksum 0x3850d4cc, Offset: 0xb38
// Size: 0x10c
function function_934f56ec(vehicle, params) {
    if (isairborne(vehicle)) {
        spawnoffset = (0, 0, vehicle.height);
        vehicle.origin = params.origin + spawnoffset;
    }
    vehicle makeusable();
    if (is_true(vehicle.isphysicsvehicle)) {
        vehicle setbrake(1);
    }
    if (!sessionmodeiszombiesgame() && is_true(getgametypesetting(#"hash_59ab05f71c3789c7"))) {
        target_remove(vehicle);
    }
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x4
// Checksum 0xdca7d89c, Offset: 0xc50
// Size: 0x54
function private function_7ae07b7() {
    if (self vehicle_ai::has_state("off")) {
        vehicle_ai::startinitialstate("off");
        return;
    }
    self function_ed173e0b();
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x4
// Checksum 0xe12b2f19, Offset: 0xcb0
// Size: 0x26
function private function_e95a0595() {
    if (isairborne(self)) {
        return false;
    }
    return true;
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x4
// Checksum 0x817ecc1b, Offset: 0xce0
// Size: 0x6c
function private function_25b9a9b(params) {
    params.var_c2e048f9 = 1;
    if (is_true(self.emped) || is_true(self.isjammed)) {
        return;
    }
    self vehicle_ai::defaultstate_driving_enter(params);
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x4
// Checksum 0x6bbfcafc, Offset: 0xd58
// Size: 0x104
function private function_1a852d1d() {
    if (is_true(self.emped) || is_true(self.isjammed)) {
        self takeplayercontrol();
        return;
    }
    if (isdefined(self.state_machines)) {
        return;
    }
    if (is_true(self.var_52e23e90)) {
        return;
    }
    turn_on();
    var_a56c96d1 = spawnstruct();
    var_a56c96d1.var_c2e048f9 = 1;
    var_a56c96d1.turn_off = &function_6c46026b;
    var_a56c96d1.var_7dabdc1b = !is_false(self.var_56b349b4);
    self vehicle_ai::defaultstate_driving_enter(var_a56c96d1);
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x0
// Checksum 0x2e6e029d, Offset: 0xe68
// Size: 0x72
function turn_on(params) {
    var_9cd704a7 = spawnstruct();
    var_9cd704a7.var_da88902a = 1;
    if (isdefined(params)) {
        var_9cd704a7.var_30a04b16 = params.var_30a04b16;
    }
    self vehicle_ai::defaultstate_off_exit(var_9cd704a7);
    self.var_52e23e90 = 1;
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x0
// Checksum 0xe8810ad0, Offset: 0xee8
// Size: 0x196
function turn_off() {
    if (is_true(self.var_52e23e90)) {
        self vehicle::function_7f0bbde3();
    }
    self vehicle::toggle_tread_fx(0);
    self vehicle::toggle_exhaust_fx(0);
    self vehicle::toggle_sounds(0);
    self vehicle::function_bbc1d940(0);
    self vehicle::lights_off();
    self vehicle::toggle_lights_group(1, 0);
    self vehicle::toggle_lights_group(2, 0);
    self vehicle::toggle_lights_group(3, 0);
    self vehicle::toggle_lights_group(4, 0);
    self vehicle::toggle_force_driver_taillights(0);
    self vehicle_ai::turnoffallambientanims();
    if (isairborne(self)) {
        self setphysacceleration((0, 0, -300));
        self setrotorspeed(0);
    }
    self.var_52e23e90 = undefined;
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x4
// Checksum 0x9cf71d44, Offset: 0x1088
// Size: 0x3c
function private function_6c46026b() {
    if (isdefined(self.state_machines)) {
        return;
    }
    self turn_off();
    self vehicle_ai::defaultstate_driving_exit();
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x4
// Checksum 0xc19c34f0, Offset: 0x10d0
// Size: 0x44
function private function_ed173e0b() {
    if (isdefined(self.state_machines)) {
        return;
    }
    var_9cd704a7 = spawnstruct();
    self vehicle_ai::defaultstate_off_enter(var_9cd704a7);
}

// Namespace player_vehicle/player_vehicle
// Params 2, eflags: 0x0
// Checksum 0x68806fff, Offset: 0x1120
// Size: 0x214
function is_staircase_up(attackingplayer = undefined, jammer = undefined) {
    if (!isvehicle(self)) {
        return;
    }
    self notify(#"emped_vehicle");
    self endon(#"emped_vehicle", #"death");
    params = spawnstruct();
    emp_duration = 30;
    if (isdefined(jammer) && isdefined(jammer.weapon) && isdefined(jammer.weapon.customsettings)) {
        var_4f1e1bed = getscriptbundle(jammer.weapon.customsettings);
        emp_duration = var_4f1e1bed.var_3bd9b483;
    } else if (isdefined(level.var_578f7c6d.customsettings.var_3bd9b483)) {
        emp_duration = level.var_578f7c6d.customsettings.var_3bd9b483;
    }
    params.param0 = emp_duration;
    params.param1 = attackingplayer;
    params.param2 = jammer;
    if (isplayer(attackingplayer)) {
        level callback::callback(#"vehicle_emped", {#attacker:attackingplayer, #vehicle:self});
    }
    if (isdefined(self.is_staircase_up)) {
        self [[ self.is_staircase_up ]](params);
        return;
    }
    self function_c9620f20(params);
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x0
// Checksum 0x489924ca, Offset: 0x1340
// Size: 0x4b4
function on_vehicle_damage(params) {
    vehicle = self;
    if (!is_true(vehicle.isplayervehicle)) {
        return;
    }
    if (isdefined(vehicle.session)) {
        damagedone = int(min(params.idamage, isdefined(vehicle.health) ? vehicle.health : params.idamage));
        if (isdefined(params.eattacker) && isplayer(params.eattacker) && params.eattacker isinvehicle() && !params.eattacker isremotecontrolling()) {
            var_364c1a03 = params.eattacker getvehicleoccupied();
            if (var_364c1a03 == vehicle) {
                vehicle.session.var_309ad81f += damagedone;
            } else if (isdefined(var_364c1a03.session)) {
                var_364c1a03.session.var_ecd1fe60 += damagedone;
                vehicle.session.var_770fd50d += damagedone;
            }
        } else if (isplayer(params.eattacker)) {
            vehicle.session.var_5ba0df6e += damagedone;
        } else {
            vehicle.session.var_309ad81f += damagedone;
        }
    }
    if (isplayer(params.eattacker) && isdefined(params.idamage)) {
        params.eattacker stats::function_d40764f3(#"vehicle_damage", int(params.idamage));
        occupants = vehicle getvehoccupants();
        if (isdefined(occupants) && occupants.size > 0) {
            params.eattacker stats::function_d40764f3(#"vehicle_damage_occupied", int(params.idamage));
        }
    }
    if (isdefined(params.smeansofdeath)) {
        occupants = vehicle getvehoccupants();
        if (isdefined(occupants) && occupants.size > 0) {
            foreach (occupant in occupants) {
                if (!isplayer(occupant)) {
                    continue;
                }
                switch (params.smeansofdeath) {
                case #"mod_projectile":
                    self playsoundtoplayer(#"hash_4cf0470b5276e61a", occupant);
                    break;
                case #"mod_rifle_bullet":
                case #"mod_pistol_bullet":
                    self playsoundtoplayer(#"prj_bullet_impact_player_vehicle", occupant);
                    break;
                }
            }
        }
    }
    vehicle vehicle_ai::update_damage_fx_level(params.idamage);
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x0
// Checksum 0x3a377bc2, Offset: 0x1800
// Size: 0x104
function on_vehicle_killed(params) {
    vehicle = self;
    if (!isdefined(level.var_c3f91417)) {
        return;
    }
    if (!is_true(vehicle.isplayervehicle)) {
        return;
    }
    if (isdefined(vehicle.session) && isdefined(params.weapon)) {
        attachments = util::function_2146bd83(params.weapon);
        weaponfullname = params.weapon.name + "+" + attachments;
        vehicle.session.weapon = hash(weaponfullname);
    }
    if (isdefined(level.var_c3f91417)) {
        vehicle clientfield::set("enemyvehicle", 0);
    }
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x0
// Checksum 0x1cc56266, Offset: 0x1910
// Size: 0x3e2
function on_player_damage(params) {
    victim = self;
    attacker = params.eattacker;
    damagedone = int(min(params.idamage, isdefined(victim.health) ? victim.health : params.idamage));
    if (victim isinvehicle() && !victim isremotecontrolling()) {
        vehicle = victim getvehicleoccupied();
        if (isdefined(vehicle.session)) {
            seatindex = vehicle getoccupantseat(victim);
            if (seatindex == 0) {
                vehicle.session.var_61ceb3c1 += damagedone;
            } else if (seatindex >= 1 && seatindex <= 4) {
                vehicle.session.var_c19a5249 += damagedone;
            } else if (seatindex >= 5 && seatindex <= 9) {
                vehicle.session.var_ffb0c509 += damagedone;
            }
        }
    }
    if (isplayer(attacker)) {
        if (attacker isinvehicle() && !attacker isremotecontrolling()) {
            vehicle = attacker getvehicleoccupied();
            if (isdefined(vehicle)) {
                if (params.smeansofdeath == "MOD_CRUSH") {
                    if (isdefined(victim)) {
                        victim playsound("veh_body_impact_flesh");
                    }
                    if (isdefined(vehicle.var_93dc9da9)) {
                        vehicle playsound(vehicle.var_93dc9da9);
                    }
                }
                if (isdefined(vehicle.session)) {
                    if (params.smeansofdeath === "MOD_CRUSH") {
                        vehicle.session.var_33f48e5a += damagedone;
                        return;
                    }
                    seatindex = vehicle getoccupantseat(attacker);
                    if (seatindex == 0) {
                        vehicle.session.var_c1b985ee += damagedone;
                        return;
                    }
                    if (seatindex >= 1 && seatindex <= 4) {
                        vehicle.session.var_f07350a4 += damagedone;
                        return;
                    }
                    if (seatindex >= 5 && seatindex <= 9) {
                        vehicle.session.var_45bf3627 += damagedone;
                    }
                }
            }
        }
    }
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x0
// Checksum 0x1c0e0046, Offset: 0x1d00
// Size: 0x274
function on_player_killed(params) {
    victim = self;
    attacker = params.eattacker;
    if (victim isinvehicle() && !victim isremotecontrolling()) {
        vehicle = victim getvehicleoccupied();
        if (isdefined(vehicle.session)) {
            seatindex = vehicle getoccupantseat(victim);
            if (seatindex == 0) {
                vehicle.session.var_888cce59++;
            } else if (seatindex >= 1 && seatindex <= 4) {
                vehicle.session.var_c5d87ed4++;
            } else if (seatindex >= 5 && seatindex <= 9) {
                vehicle.session.var_3893d13e++;
            }
        }
    }
    if (isplayer(attacker)) {
        if (attacker isinvehicle() && !attacker isremotecontrolling()) {
            vehicle = attacker getvehicleoccupied();
            if (isdefined(vehicle.session)) {
                if (params.smeansofdeath == "MOD_CRUSH") {
                    vehicle.session.vehicle_kills++;
                    return;
                }
                seatindex = vehicle getoccupantseat(attacker);
                if (seatindex == 0) {
                    vehicle.session.driver_kills++;
                    return;
                }
                if (seatindex >= 1 && seatindex <= 4) {
                    vehicle.session.gunner_kills++;
                    return;
                }
                if (seatindex >= 5 && seatindex <= 9) {
                    vehicle.session.passenger_kills++;
                }
            }
        }
    }
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x0
// Checksum 0x66fe83dc, Offset: 0x1f80
// Size: 0xca
function on_player_corpse(*params) {
    foreach (player in getplayers()) {
        if (is_true(player.var_2e8665de) && self === player.body) {
            self hide();
            return;
        }
    }
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x0
// Checksum 0x6dab8ab4, Offset: 0x2058
// Size: 0x1b0
function function_69c9e9a0() {
    level endon(#"game_ended");
    while (true) {
        waitresult = level waittill(#"hash_4aced1739d6627a2");
        vehicle = waitresult.vehicle;
        if (!isvehicle(vehicle)) {
            continue;
        }
        if (!is_true(vehicle.isplayervehicle)) {
            return;
        }
        callback::on_player_corpse(&on_player_corpse);
        occupants = vehicle getvehoccupants();
        foreach (occupant in occupants) {
            occupant unlink();
            occupant.var_2e8665de = 1;
            occupant dodamage(occupant.health * 100, occupant.origin);
        }
        vehicle deletedelay();
    }
}

// Namespace player_vehicle/player_vehicle
// Params 3, eflags: 0x0
// Checksum 0x3f6c088d, Offset: 0x2210
// Size: 0xa6
function function_c747eedd(vehicle, player, seatindex) {
    if (vehicle.vehicleclass === "boat") {
        if (vehicle function_7548ecb2() && is_true(vehicle.var_221879dc)) {
            if (seatindex === 0) {
                return false;
            }
        }
    }
    if (player flag::get("encumbered")) {
        return false;
    }
    return true;
}

// Namespace player_vehicle/player_vehicle
// Params 3, eflags: 0x0
// Checksum 0x553945df, Offset: 0x22c0
// Size: 0x88
function function_2513e40c(vehicle, player, seatindex) {
    if (!function_c747eedd(vehicle, player, seatindex)) {
        return false;
    }
    if (player item_world::function_8e0d14c1(1)) {
        return false;
    }
    if (isdefined(level.var_402b86e) && player [[ level.var_402b86e ]]()) {
        return false;
    }
    return true;
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x4
// Checksum 0x64a5672e, Offset: 0x2350
// Size: 0x42
function private function_d69d0773() {
    if (!isdefined(self.var_d6a1af09)) {
        self.var_d6a1af09 = 0;
    }
    if (gettime() - self.var_d6a1af09 >= 250) {
        self.var_d6a1af09 = gettime();
        return true;
    }
    return false;
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x4
// Checksum 0xa00f9ad7, Offset: 0x23a0
// Size: 0x39c
function private on_vehicle_collision(params) {
    if (!function_d69d0773()) {
        return;
    }
    if (isdefined(self.var_4ca92b57)) {
        var_1fdf316c = self.var_4ca92b57;
    } else {
        var_1fdf316c = 30;
    }
    if (isdefined(self.var_57371c71)) {
        var_a7796a79 = self.var_57371c71;
    } else {
        var_a7796a79 = 60;
    }
    if (isdefined(self.var_84fed14b)) {
        mindamage = self.var_84fed14b;
    } else {
        mindamage = 50;
    }
    if (isdefined(self.var_d6691161)) {
        maxdamage = self.var_d6691161;
    } else {
        maxdamage = 250;
    }
    if (isdefined(self.var_5d662124)) {
        var_1831f049 = self.var_5d662124;
    } else {
        var_1831f049 = 1;
    }
    if (isdefined(self.var_5002d77c)) {
        var_a1805d6e = self.var_5002d77c;
    } else {
        var_a1805d6e = 0.65;
    }
    self callback::callback(#"hash_551381cffdc79048", params);
    var_2ad7f33b = params.intensity;
    if (isdefined(var_2ad7f33b) && var_2ad7f33b > var_1fdf316c) {
        applydamage = mapfloat(var_1fdf316c, var_a7796a79, mindamage, maxdamage, var_2ad7f33b);
        if (isdefined(params.normal) && params.normal[2] < -0.5) {
            impactdot = vectordot(anglestoup(self.angles), -1 * params.normal);
            if (impactdot > var_a1805d6e) {
                applydamage *= 0;
            }
        }
        if (isdefined(params.entity) && isvehicle(params.entity)) {
            riders = params.entity getvehoccupants();
            if (isdefined(riders) && isdefined(riders[0])) {
                attacker = riders[0];
            } else {
                attacker = self;
            }
        }
        if (isdefined(params.entity)) {
            self dodamage(applydamage, self.origin, attacker);
        }
    }
    if (isdefined(params.entity) && issentient(params.entity)) {
        if (isdefined(var_2ad7f33b) && var_2ad7f33b > 12) {
            applydamage = mapfloat(12, 50, 50, 1000, var_2ad7f33b);
            params.entity dodamage(applydamage * var_1831f049, self.origin, self);
        }
    }
}

// Namespace player_vehicle/event_e6d021cc
// Params 1, eflags: 0x40
// Checksum 0x2d062001, Offset: 0x2748
// Size: 0xfc
function event_handler[event_e6d021cc] function_f7794c85(*eventstruct) {
    self.challenge_sprint_end = gettime();
    wait 0.75;
    if (!isvehicle(self) || !self function_2c2c30e0()) {
        return;
    }
    self function_8cf138bb();
    self.takedamage = 0;
    self.var_e8ec304d = 1;
    self namespace_d0eacb0d::on_vehicle_killed();
    self clientfield::set("stopallfx", 1);
    self clientfield::set("flickerlights", 1);
    self launchvehicle((0, 0, 0), (0, 0, 0), 0, 1);
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x4
// Checksum 0xd85d51d9, Offset: 0x2850
// Size: 0x1c
function private function_df786031() {
    return isdefined(self.locking_on) && self.locking_on > 0;
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x4
// Checksum 0xc10f3d9, Offset: 0x2878
// Size: 0x1c
function private function_ea4291d3() {
    return isdefined(self.locked_on) && self.locked_on > 0;
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x4
// Checksum 0x164af3dc, Offset: 0x28a0
// Size: 0x14e
function private function_b3caeebc(player) {
    self endon(#"death");
    player endon(#"exit_vehicle", #"death");
    while (true) {
        if (self function_ea4291d3()) {
            player clientfield::set_player_uimodel("vehicle.missileLock", 2);
            self playsoundtoplayer(#"hash_445c9fb1793c4259", player);
            wait 0.25;
            continue;
        }
        if (self function_df786031()) {
            player clientfield::set_player_uimodel("vehicle.missileLock", 1);
            self playsoundtoplayer(#"hash_107b6827696673cb", player);
            wait 0.25;
            continue;
        }
        player clientfield::set_player_uimodel("vehicle.missileLock", 0);
        self waittill(#"locking on");
    }
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x0
// Checksum 0x9815a2df, Offset: 0x29f8
// Size: 0xd8
function function_28e59742() {
    occupants = self getvehoccupants();
    if (isdefined(occupants)) {
        foreach (occupant in occupants) {
            if (!isplayer(occupant)) {
                continue;
            }
            occupant clientfield::set_player_uimodel("vehicle.incomingMissile", 0);
        }
    }
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x0
// Checksum 0x7e4b5b79, Offset: 0x2ad8
// Size: 0x154
function function_c25f7d1(params) {
    self endon(#"death", #"hash_158a0007d6fac6ed");
    occupants = self getvehoccupants();
    foreach (occupant in occupants) {
        if (!isplayer(occupant)) {
            continue;
        }
        occupant clientfield::set_player_uimodel("vehicle.incomingMissile", 1);
        occupant thread function_6aa73a2a(params.projectile, self);
    }
    params.projectile waittill(#"projectile_impact_explode", #"death");
    self function_28e59742();
}

// Namespace player_vehicle/player_vehicle
// Params 2, eflags: 0x4
// Checksum 0x46c75312, Offset: 0x2c38
// Size: 0x190
function private function_6aa73a2a(missile, vehicle) {
    self endon(#"death", #"exit_vehicle", #"hash_158a0007d6fac6ed");
    missile endon(#"death");
    vehicle endon(#"death");
    range = 8000 - 10;
    dist = undefined;
    while (true) {
        old_dist = dist;
        dist = distance(missile.origin, self.origin);
        var_38fa5914 = isdefined(old_dist) && dist < old_dist;
        if (var_38fa5914) {
            vehicle playsoundtoplayer(#"uin_ac130_alarm_missile_incoming", self);
        }
        normalizeddist = (dist - 10) / range;
        beep_interval = lerpfloat(0.05, 0.2, normalizeddist);
        wait beep_interval;
    }
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x0
// Checksum 0x508afd39, Offset: 0x2dd0
// Size: 0x5c
function function_adc0649a() {
    assert(isvehicle(self));
    return is_true(self.emped) || is_true(self.isjammed);
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x0
// Checksum 0x339ce424, Offset: 0x2e38
// Size: 0x306
function function_3054737a(player) {
    vehicle = self;
    if (game.state == #"pregame" || !isplayer(player) || player isremotecontrolling() || isdefined(vehicle.session)) {
        return;
    }
    vehicle.session = {#vehicle:vehicle.vehicletype, #var_2dbaf8ca:vehicle.origin[0], #var_1ff15d37:vehicle.origin[1], #var_16f7d5d0:vehicle.origin[0], #var_4ba3155:vehicle.origin[1], #var_c87538d9:vehicle.trackingindex, #start_time:gettime(), #end_time:0, #start_health:vehicle.health, #end_health:vehicle.health, #first_player:int(player getxuid(1)), #var_efe98761:1, #var_309ad81f:0, #var_5ba0df6e:0, #var_770fd50d:0, #var_33f48e5a:0, #var_ecd1fe60:0, #vehicle_kills:0, #var_61ceb3c1:0, #var_c1b985ee:0, #var_888cce59:0, #driver_kills:0, #var_c19a5249:0, #var_f07350a4:0, #var_c5d87ed4:0, #gunner_kills:0, #var_ffb0c509:0, #var_45bf3627:0, #var_3893d13e:0, #passenger_kills:0, #weapon:#""};
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x0
// Checksum 0xf0b44664, Offset: 0x3148
// Size: 0x116
function function_2d00376() {
    if (game.state == #"pregame") {
        return;
    }
    vehicle = self;
    if (isdefined(vehicle.session)) {
        vehicle.session.end_time = function_f8d53445();
        vehicle.session.end_health = int(max(0, vehicle.health));
        vehicle.session.var_16f7d5d0 = vehicle.origin[0];
        vehicle.session.var_4ba3155 = vehicle.origin[1];
        function_92d1707f(#"hash_4fd470ea26ade803", vehicle.session);
        vehicle.session = undefined;
    }
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x4
// Checksum 0xaed022e5, Offset: 0x3268
// Size: 0x20c
function private function_f442b1c() {
    var_e61d6eb0 = [];
    foreach (vehicle in level.vehicle_tracking) {
        if (!isdefined(vehicle)) {
            continue;
        }
        data = {#pos_x:vehicle.origin[0], #pos_y:vehicle.origin[1], #pos_z:vehicle.origin[2], #type:vehicle.vehicletype, #used:is_true(vehicle.used)};
        if (!isdefined(var_e61d6eb0)) {
            var_e61d6eb0 = [];
        } else if (!isarray(var_e61d6eb0)) {
            var_e61d6eb0 = array(var_e61d6eb0);
        }
        var_e61d6eb0[var_e61d6eb0.size] = data;
        if (var_e61d6eb0.size >= 100) {
            function_92d1707f(#"hash_55f923de6ff3632b", #"entries", var_e61d6eb0);
            var_e61d6eb0 = [];
            wait 0.1;
        }
    }
    if (var_e61d6eb0.size > 0) {
        function_92d1707f(#"hash_55f923de6ff3632b", #"entries", var_e61d6eb0);
    }
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x0
// Checksum 0x9e6aa1bf, Offset: 0x3480
// Size: 0x6c
function on_end_game(*params) {
    vehicles = getvehiclearray();
    for (i = 0; i < vehicles.size; i++) {
        vehicles[i] function_2d00376();
    }
    thread function_f442b1c();
}

// Namespace player_vehicle/enter_vehicle
// Params 1, eflags: 0x40
// Checksum 0xc282d056, Offset: 0x34f8
// Size: 0x452
function event_handler[enter_vehicle] codecallback_vehicleenter(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    vehicle = eventstruct.vehicle;
    seatindex = eventstruct.seat_index;
    if (!is_true(vehicle.isplayervehicle)) {
        return;
    }
    if (killstreaks::is_killstreak_weapon(self.currentweapon)) {
        self killstreaks::switch_to_last_non_killstreak_weapon();
    }
    vehicle.last_enter = gettime();
    if (is_true(vehicle.isphysicsvehicle)) {
        vehicle setbrake(0);
    }
    self clientfield::set_player_uimodel("vehicle.vehicleAttackMode", 0);
    vehicle callback::callback(#"hash_666d48a558881a36", {#player:self, #eventstruct:eventstruct});
    occupants = vehicle getvehoccupants();
    if (isdefined(vehicle) && isdefined(self.team)) {
        vehicle.team = self.team;
    }
    if (!is_false(vehicle.var_cd4099ea)) {
        if (seatindex === 0) {
            vehicle function_1a852d1d();
        }
    }
    if (isdefined(vehicle.settings) && is_true(vehicle.settings.var_2627e80a)) {
        if (seatindex === 0) {
            if (is_true(vehicle.var_304cf9da)) {
                vehicle vehicle::function_bbc1d940(1);
            }
        }
        var_1861e0b1 = vehicle clientfield::get("toggle_horn_sound");
        if (is_true(var_1861e0b1)) {
            self clientfield::set_to_player("toggle_vehicle_sensor", 1);
        }
    }
    isemped = vehicle function_adc0649a();
    vehicle function_388973e4(isemped);
    vehicle thread function_b3caeebc(self);
    if (isdefined(level.var_c3f91417)) {
        vehicle clientfield::set("enemyvehicle", 1);
    }
    if (!isdefined(vehicle.maxhealth)) {
        vehicle.maxhealth = vehicle.healthdefault;
    }
    if (isdefined(level.vehicle_tracking)) {
        foreach (var_c9fc0d83 in level.vehicle_tracking) {
            if (var_c9fc0d83 === vehicle) {
                var_c9fc0d83.used = 1;
            }
        }
    }
    if (!isdefined(vehicle.session)) {
        vehicle function_3054737a(self);
        return;
    }
    vehicle.session.var_efe98761 = int(max(vehicle.session.var_efe98761, occupants.size));
}

// Namespace player_vehicle/exit_vehicle
// Params 1, eflags: 0x40
// Checksum 0x412dea08, Offset: 0x3958
// Size: 0x360
function event_handler[exit_vehicle] codecallback_vehicleexit(eventstruct) {
    profilestart();
    if (!isplayer(self)) {
        profilestop();
        return;
    }
    vehicle = eventstruct.vehicle;
    seatindex = eventstruct.seat_index;
    if (!is_true(vehicle.isplayervehicle)) {
        profilestop();
        return;
    }
    vehicle.var_8e382c5f = gettime();
    self clientfield::set_player_uimodel("vehicle.incomingMissile", 0);
    self clientfield::set_player_uimodel("vehicle.missileLock", 0);
    vehicle callback::callback(#"hash_55f29e0747697500", {#player:self, #eventstruct:eventstruct});
    if (isdefined(vehicle.settings) && is_true(vehicle.settings.var_2627e80a)) {
        self clientfield::set_to_player("toggle_vehicle_sensor", 0);
    }
    if (vehicle function_ea4291d3()) {
        callback::callback("on_exit_locked_on_vehicle", {#vehicle:vehicle, #player:self, #seatindex:seatindex});
    }
    occupants = vehicle getvehoccupants();
    if (occupants.size == 0) {
        vehicle function_2d00376();
    }
    if (vehicle.var_bd9434ec !== 1) {
        if (!isdefined(occupants) || !occupants.size) {
            vehicle.team = #"neutral";
            if (isdefined(level.var_c3f91417)) {
                vehicle clientfield::set("enemyvehicle", 0);
            }
        }
    }
    if (!is_false(vehicle.var_cd4099ea)) {
        if (!isdefined(occupants) || !occupants.size) {
            vehicle function_6c46026b();
            if (is_true(vehicle.var_ffdf490c)) {
                vehicle thread function_ffdf490c();
            }
        }
    }
    if (isdefined(vehicle.var_260e3593) && seatindex === vehicle.var_260e3593) {
        self function_b9604c53(vehicle);
    }
    if (seatindex !== 0) {
        profilestop();
        return;
    }
    if (is_true(vehicle.var_97f1b32a)) {
        vehicle.var_735382e = self;
        vehicle.var_a816f2cd = gettime();
    }
    profilestop();
}

// Namespace player_vehicle/event_363c2131
// Params 1, eflags: 0x40
// Checksum 0xa943d3a8, Offset: 0x3cc0
// Size: 0x84
function event_handler[event_363c2131] function_3a4d53f8(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    vehicle = eventstruct.vehicle;
    vehicle callback::callback(#"hash_80ab24b716412e1", {#player:self, #eventstruct:eventstruct});
}

// Namespace player_vehicle/change_seat
// Params 1, eflags: 0x40
// Checksum 0xc02ce93b, Offset: 0x3d50
// Size: 0x41c
function event_handler[change_seat] function_2aa4e6cf(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    vehicle = eventstruct.vehicle;
    seatindex = eventstruct.seat_index;
    oldseatindex = eventstruct.old_seat_index;
    if (!is_true(vehicle.isplayervehicle)) {
        return;
    }
    if (oldseatindex === 0) {
        if (is_true(vehicle.var_97f1b32a)) {
            vehicle.var_735382e = self;
            vehicle.var_a816f2cd = gettime();
        }
    } else if (seatindex === 0) {
        if (vehicle vehicle_ai::function_329f45a4() && !is_true(self.var_d271cf82)) {
            if (vehicle vehicle_ai::has_state("landed") && vehicle vehicle_ai::get_current_state() === "off") {
                vehicle vehicle_ai::set_state("landed");
            } else if (vehicle vehicle_ai::has_state("recovery") && vehicle vehicle_ai::get_current_state() === "spiral") {
                vehicle vehicle_ai::set_state("recovery");
            } else if (vehicle vehicle_ai::has_state("driving")) {
                vehicle vehicle_ai::set_state("driving");
            } else if (!is_false(vehicle.var_cd4099ea)) {
                vehicle function_1a852d1d();
            }
            if (isdefined(vehicle.settings) && is_true(vehicle.settings.var_2627e80a)) {
                if (is_true(vehicle.var_304cf9da)) {
                    vehicle vehicle::function_bbc1d940(1);
                }
                var_1861e0b1 = vehicle clientfield::get("toggle_horn_sound");
                if (is_true(var_1861e0b1)) {
                    self clientfield::set_to_player("toggle_vehicle_sensor", 1);
                }
            }
        } else {
            vehicle takeplayercontrol();
        }
    }
    if (isdefined(vehicle.var_260e3593)) {
        if (isdefined(seatindex) && seatindex == vehicle.var_260e3593) {
            self function_3afc1410(vehicle);
        } else if (isdefined(oldseatindex) && oldseatindex == vehicle.var_260e3593) {
            self function_b9604c53(vehicle);
        }
    }
    vehicle callback::callback(#"hash_2c1cafe2a67dfef8", {#player:self, #eventstruct:eventstruct});
    isemped = vehicle function_adc0649a();
    vehicle function_388973e4(isemped);
}

// Namespace player_vehicle/event_44d3f985
// Params 1, eflags: 0x40
// Checksum 0x5448d9b1, Offset: 0x4178
// Size: 0xbc
function event_handler[event_44d3f985] function_2d7f6e48(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    if (isdefined(eventstruct.seat_index) && eventstruct.seat_index >= 5 && eventstruct.seat_index <= 9) {
        if (eventstruct.var_e3e139f === 1) {
            self clientfield::set_player_uimodel("vehicle.vehicleAttackMode", 1);
            return;
        }
        self clientfield::set_player_uimodel("vehicle.vehicleAttackMode", 0);
    }
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x0
// Checksum 0xf295b03f, Offset: 0x4240
// Size: 0xd4
function function_8cf138bb() {
    if (!isvehicle(self)) {
        return;
    }
    occupants = self getvehoccupants();
    if (isdefined(occupants) && occupants.size) {
        for (i = 0; i < occupants.size; i++) {
            seat = self getoccupantseat(occupants[i]);
            if (isdefined(seat)) {
                self usevehicle(occupants[i], seat);
            }
        }
    }
    self makevehicleunusable();
}

// Namespace player_vehicle/event_99100cb2
// Params 1, eflags: 0x40
// Checksum 0x5eb6a92f, Offset: 0x4320
// Size: 0xec
function event_handler[event_99100cb2] function_22d9386e(*eventstruct) {
    if (!is_true(self.isplayervehicle)) {
        return;
    }
    if (is_true(self.var_a195943)) {
        return;
    }
    self function_8cf138bb();
    waterheight = getwaterheight(self.origin, 100, -10000);
    if (waterheight != -131072 && self.origin[2] < waterheight) {
        self.health = 5;
        return;
    }
    self dodamage(self.health - 5, self.origin);
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x0
// Checksum 0xb4671e24, Offset: 0x4418
// Size: 0x1b8
function function_ef44d420(params) {
    self vehicle::toggle_lights_group(1, !params.var_d8ceeba3);
    self vehicle::toggle_lights_group(2, !params.var_d8ceeba3);
    self vehicle::toggle_lights_group(3, !params.var_d8ceeba3);
    self vehicle::toggle_lights_group(4, params.var_d8ceeba3);
    occupants = self getvehoccupants();
    if (isdefined(occupants)) {
        foreach (occupant in occupants) {
            if (!isplayer(occupant)) {
                continue;
            }
            if (is_true(occupant function_bee2bbc7())) {
                continue;
            }
            if (params.var_d8ceeba3) {
                occupant clientfield::set_to_player("toggle_vehicle_sensor", 1);
                continue;
            }
            occupant clientfield::set_to_player("toggle_vehicle_sensor", 0);
        }
    }
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x4
// Checksum 0xe92a9adb, Offset: 0x45d8
// Size: 0xa4
function private function_ffdf490c() {
    if (!isdefined(self) || self.health < 1) {
        return;
    }
    self endon(#"death");
    util::wait_network_frame();
    for (group = 1; group < 4; group++) {
        self vehicle::toggle_lights_group(group, 1);
    }
    self vehicle::toggle_force_driver_taillights(1);
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x4
// Checksum 0xeda0b520, Offset: 0x4688
// Size: 0xaa
function private function_85aaed19(seat_index) {
    switch (seat_index) {
    case 0:
        return "overheat_fx";
    case 1:
        return "overheat_fx1";
    case 2:
        return "overheat_fx2";
    case 3:
        return "overheat_fx3";
    case 4:
        return "overheat_fx4";
    default:
        return undefined;
    }
}

// Namespace player_vehicle/player_vehicle
// Params 2, eflags: 0x0
// Checksum 0x540f64e4, Offset: 0x4740
// Size: 0xbe
function function_5bce3f3a(seat_index, *var_ddd294e3) {
    self endon(#"death");
    clientfield = function_85aaed19(var_ddd294e3);
    while (true) {
        var_24139930 = self isvehicleturretoverheating(var_ddd294e3);
        if (var_24139930) {
            self clientfield::set(clientfield, 1);
        } else {
            self clientfield::set(clientfield, 0);
        }
        waitframe(1);
    }
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x4
// Checksum 0x2aeb52cf, Offset: 0x4808
// Size: 0xaa
function private function_41cb03eb(seat_index) {
    switch (seat_index) {
    case 0:
        return "tag_turret";
    case 1:
        return "tag_gunner_turret1";
    case 2:
        return "tag_gunner_turret2";
    case 3:
        return "tag_gunner_turret3";
    case 4:
        return "tag_gunner_turret4";
    default:
        return undefined;
    }
}

// Namespace player_vehicle/player_vehicle
// Params 3, eflags: 0x0
// Checksum 0x86d01f72, Offset: 0x48c0
// Size: 0x234
function update_turret_fire(vehicle, seat_index, var_c269692d) {
    self endon(#"death", #"disconnect", #"exit_vehicle", #"change_seat");
    vehicle endon(#"death");
    if (vehicle.var_96c0f900[seat_index] == 0) {
        vehicle disablegunnerfiring(seat_index - 1, 1);
        return;
    }
    while (true) {
        params = vehicle waittill(#"gunner_weapon_fired");
        if (params.gunner_index === seat_index) {
            vehicle.var_96c0f900[seat_index] = vehicle.var_96c0f900[seat_index] - var_c269692d;
            var_251a3d58 = function_41cb03eb(seat_index);
            if (isdefined(var_251a3d58)) {
                damageparts = [];
                if (!isdefined(damageparts)) {
                    damageparts = [];
                } else if (!isarray(damageparts)) {
                    damageparts = array(damageparts);
                }
                damageparts[damageparts.size] = var_251a3d58;
                vehicle function_902cf00a(damageparts, int(var_c269692d));
            }
            if (vehicle.var_96c0f900[seat_index] < 0) {
                vehicle.var_96c0f900[seat_index] = 0;
            }
            if (vehicle.var_96c0f900[seat_index] == 0) {
                vehicle disablegunnerfiring(seat_index - 1, 1);
                break;
            }
        }
    }
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x0
// Checksum 0x5bc8e69e, Offset: 0x4b00
// Size: 0x64
function function_388973e4(disable) {
    self disabledriverfiring(disable);
    for (gunnerindex = 0; gunnerindex < 4; gunnerindex++) {
        self disablegunnerfiring(gunnerindex, disable);
    }
}

// Namespace player_vehicle/player_vehicle
// Params 2, eflags: 0x0
// Checksum 0x24fbdb4d, Offset: 0x4b70
// Size: 0x2e
function function_cc30c4bb(gesture, seat_index) {
    self.var_66329fbb = gesture;
    self.var_260e3593 = seat_index;
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x4
// Checksum 0xaa877fc9, Offset: 0x4ba8
// Size: 0x90
function private function_f43c0cb7(vehicle) {
    if (self function_104d7b4d()) {
        return false;
    }
    if (self isswitchingweapons()) {
        return false;
    }
    if (self isreloading()) {
        return false;
    }
    if (isdefined(vehicle.var_66329fbb) && self isgestureplaying(vehicle.var_66329fbb)) {
        return false;
    }
    return true;
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x4
// Checksum 0x199b1535, Offset: 0x4c40
// Size: 0xa0
function private function_3afc1410(vehicle) {
    self endon(#"death", #"exit_vehicle", #"change_seat");
    if (!isdefined(vehicle.var_66329fbb)) {
        return;
    }
    while (true) {
        if (function_f43c0cb7(vehicle)) {
            self playgestureviewmodel(vehicle.var_66329fbb);
        }
        wait 0.05;
    }
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x4
// Checksum 0x32233c81, Offset: 0x4ce8
// Size: 0x3c
function private function_b9604c53(vehicle) {
    if (isdefined(vehicle.var_66329fbb)) {
        self stopgestureviewmodel(vehicle.var_66329fbb);
    }
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x4
// Checksum 0xb57af32f, Offset: 0x4d30
// Size: 0x222
function private function_17949e01() {
    self notify("7e583e84c115261d");
    self endon("7e583e84c115261d");
    self endon(#"death");
    mag = getdvarfloat(#"hash_2612e4b1db15d42e", 150);
    height = getdvarfloat(#"hash_57e0d780126c4f57", 100);
    var_80831eb5 = 0;
    while (true) {
        self waittill(#"beached");
        while (true) {
            waitresult = self waittill(#"touch", #"unbeached");
            if (waitresult._notify == #"touch" && isdefined(waitresult.entity) && isplayer(waitresult.entity)) {
                time = gettime();
                if (time > var_80831eb5 && waitresult.entity isonslide()) {
                    force = anglestoforward(waitresult.entity getplayerangles());
                    force *= mag;
                    force += (0, 0, height);
                    self launchvehicle(force, self.origin);
                    var_80831eb5 = time + 1500;
                }
                continue;
            }
            if (!self function_7548ecb2()) {
                break;
            }
        }
    }
}

// Namespace player_vehicle/player_vehicle
// Params 2, eflags: 0x0
// Checksum 0xaa7a7620, Offset: 0x4f60
// Size: 0x54
function deletemeonnotify(enttowatch, note) {
    self endon(#"death");
    if (!isdefined(enttowatch)) {
        return;
    }
    enttowatch waittill(note);
    self delete();
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x0
// Checksum 0xebd2b20d, Offset: 0x4fc0
// Size: 0x39e
function function_e8e41bbb() {
    self notify("3d69f86f18070829");
    self endon("3d69f86f18070829");
    self endon(#"death");
    self.var_221879dc = 0;
    if (self function_7ca7a7e5()) {
        return;
    }
    if (isdefined(self.settings) && is_true(self.settings.var_95ebe8e0)) {
        self thread function_17949e01();
    }
    fxorg = undefined;
    while (true) {
        speed = length(self getvelocity());
        if (self function_7548ecb2() && speed < 5) {
            if (!self.var_221879dc) {
                driver = self getseatoccupant(0);
                if (isplayer(driver)) {
                    self usevehicle(driver, 0);
                }
                if (isdefined(self.settings)) {
                    if (isdefined(self.settings.var_b5c8e89a) && isdefined(self.settings.var_95861ca4)) {
                        if (isdefined(fxorg)) {
                            fxorg delete();
                        }
                        fxorg = spawn("script_model", self gettagorigin(self.settings.var_95861ca4));
                        fxorg.targetname = "vehicle_beach_fx";
                        if (isdefined(fxorg)) {
                            fxorg setmodel(#"tag_origin");
                            fxorg enablelinkto();
                            fxorg linkto(self, self.settings.var_95861ca4, (0, 0, 0), (0, 0, 0));
                            playfxontag(self.settings.var_b5c8e89a, fxorg, "tag_origin");
                            fxorg thread deletemeonnotify(self, "death");
                        }
                    }
                    if (isdefined(self.settings.var_a8fa65d7)) {
                        self playsound(self.settings.var_a8fa65d7);
                    }
                }
                self.var_221879dc = 1;
                self notify(#"beached");
            }
        } else if (self.var_221879dc && !self function_7548ecb2()) {
            self.var_221879dc = 0;
            if (isdefined(fxorg)) {
                fxorg delete();
            }
            self notify(#"unbeached");
            wait 5;
        }
        waitframe(1);
    }
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x0
// Checksum 0xff8129c7, Offset: 0x5368
// Size: 0x12
function function_971ca64b() {
    self.var_b71d69e0 = 1;
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x0
// Checksum 0xdc51de6c, Offset: 0x5388
// Size: 0x24
function function_a2626745() {
    self.var_b71d69e0 = 0;
    self thread function_e8e41bbb();
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x0
// Checksum 0x1f2f46af, Offset: 0x53b8
// Size: 0x26
function function_7ca7a7e5() {
    if (is_true(self.var_b71d69e0)) {
        return true;
    }
    return false;
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x0
// Checksum 0x43198ec4, Offset: 0x53e8
// Size: 0x144
function function_9e6e374a(*params) {
    if (isdefined(self)) {
        if (isdefined(level.var_fc1bbaef)) {
            [[ level.var_fc1bbaef ]](self);
        }
        self clientfield::set("stunned", 0);
        self vehicle_ai::emp_startup_fx();
        self vehicle::toggle_emp_fx(0);
        self vehicle::function_bbc1d940(1);
        self vehicle::toggle_sounds(1);
        if (isdefined(level.var_fc1bbaef)) {
            [[ level.var_fc1bbaef ]](self);
        }
        self.abnormal_status.emped = 0;
        if (vehicle_ai::function_329f45a4()) {
            if (!is_false(self.var_cd4099ea)) {
                self function_1a852d1d();
            }
        }
        self function_388973e4(0);
    }
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x0
// Checksum 0xe9eb8be4, Offset: 0x5538
// Size: 0x27c
function function_c9620f20(params) {
    self vehicle::toggle_emp_fx(1);
    self vehicle::function_bbc1d940(0);
    self vehicle::toggle_sounds(0);
    if (is_true(self.var_52e23e90)) {
        self vehicle::function_7f0bbde3();
        self playsound(#"hash_d6643b88d0186ae");
    }
    self function_388973e4(1);
    self.var_52e23e90 = undefined;
    if (isdefined(self.settings) && is_true(self.settings.var_2627e80a)) {
        params.var_d8ceeba3 = 0;
        self function_ef44d420(params);
    }
    if (!isdefined(self.abnormal_status)) {
        self.abnormal_status = spawnstruct();
    }
    self clientfield::set("stunned", 1);
    self.abnormal_status.emped = 1;
    self.abnormal_status.attacker = params.param1;
    self.abnormal_status.inflictor = params.param2;
    time = params.param0;
    assert(isdefined(time));
    util::cooldown("emped_timer", time);
    while (!util::iscooldownready("emped_timer") && isalive(self)) {
        timeleft = max(util::getcooldownleft("emped_timer"), 0.5);
        wait timeleft;
    }
    self function_9e6e374a(params);
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x0
// Checksum 0x7cd286ef, Offset: 0x57c0
// Size: 0x2ac
function function_d3da7e1e() {
    self notify("72a57ef89728170a");
    self endon("72a57ef89728170a");
    self endon(#"death", #"exit_vehicle", #"change_seat");
    while (true) {
        waitresult = self waittill(#"weapon_fired");
        var_1c7142e7 = waitresult.projectile;
        assert(isdefined(var_1c7142e7), "<dev string:x38>");
        target = self turretgettarget(0);
        assert(isdefined(target), "<dev string:x61>");
        var_251a3d58 = function_41cb03eb(0);
        if (getdvarint(#"hash_39f8801b6af77347", 0) != 0) {
            maxangle = getdvarint(#"hash_5ba61c3a70e5b26", 50);
            turretangles = self function_96c6ae11(0);
            if (turretangles > maxangle) {
                continue;
            }
        }
        foreach (projectile in var_1c7142e7) {
            targetent = spawn("script_origin", target);
            projectile missile_settarget(targetent);
            projectile thread function_11b95c7f(targetent);
            /#
                if (getdvarint(#"hash_4e5f56d5a1a9fea4", 0) > 0) {
                    projectile thread function_2f3dd76f(targetent);
                }
            #/
        }
    }
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x4
// Checksum 0x76438414, Offset: 0x5a78
// Size: 0x34
function private function_11b95c7f(targetent) {
    self waittill(#"death");
    targetent delete();
}

/#

    // Namespace player_vehicle/player_vehicle
    // Params 1, eflags: 0x4
    // Checksum 0x59d397b5, Offset: 0x5ab8
    // Size: 0x56
    function private function_2f3dd76f(targetent) {
        self endon(#"death");
        while (true) {
            sphere(targetent.origin, 30, (0, 1, 0));
            waitframe(1);
        }
    }

#/
