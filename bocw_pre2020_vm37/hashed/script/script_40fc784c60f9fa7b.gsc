#using script_1160d62024d6945b;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\killstreaks_util;

#namespace player_vehicle;

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x6
// Checksum 0x7fffc4d5, Offset: 0x3c0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"player_vehicle", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x5 linked
// Checksum 0xab3a821b, Offset: 0x408
// Size: 0x208
function private function_70a657d8() {
    callback::on_vehicle_spawned(&on_vehicle_spawned);
    callback::on_vehicle_damage(&on_vehicle_damage);
    callback::on_vehicle_killed(&on_vehicle_killed);
    callback::on_player_damage(&on_player_damage);
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
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x5 linked
// Checksum 0xdafa0c84, Offset: 0x618
// Size: 0x114
function private on_vehicle_spawned() {
    if (!is_true(self.isplayervehicle)) {
        return;
    }
    self function_4edde887();
    callback::callback(#"hash_5ca3a1f306039e1e");
    params = spawnstruct();
    params.origin = self.origin;
    self thread namespace_d0eacb0d::function_711f53df(self.vehicletype, self.origin, self.angles, &function_934f56ec, params);
    if (isdefined(self.settings.var_b40b5493)) {
        self influencers::create_influencer_generic(self.settings.var_b40b5493, self, "any");
    }
    self function_7ae07b7();
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x5 linked
// Checksum 0xa55c2768, Offset: 0x738
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
// Params 0, eflags: 0x1 linked
// Checksum 0x164f3daf, Offset: 0x9e8
// Size: 0xc2
function function_bc79899e() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::add_interrupt_connection("driving", "off", "exit_vehicle", &vehicle_ai::function_6664e3af);
    self vehicle_ai::add_interrupt_connection("driving", "off", "emped_vehicle", &vehicle_ai::function_6664e3af);
    self vehicle_ai::get_state_callbacks("driving").enter_func = &function_25b9a9b;
}

// Namespace player_vehicle/player_vehicle
// Params 2, eflags: 0x1 linked
// Checksum 0x305322da, Offset: 0xab8
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
// Params 0, eflags: 0x5 linked
// Checksum 0xc6ecd81f, Offset: 0xbd0
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
// Checksum 0xb60c07e4, Offset: 0xc30
// Size: 0x26
function private function_e95a0595() {
    if (isairborne(self)) {
        return false;
    }
    return true;
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x5 linked
// Checksum 0x8dcbff43, Offset: 0xc60
// Size: 0x6c
function private function_25b9a9b(params) {
    params.var_c2e048f9 = 1;
    if (is_true(self.emped) || is_true(self.isjammed)) {
        return;
    }
    self vehicle_ai::defaultstate_driving_enter(params);
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x5 linked
// Checksum 0xca9c600d, Offset: 0xcd8
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
// Params 1, eflags: 0x1 linked
// Checksum 0xeca4bf0a, Offset: 0xde8
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
// Params 0, eflags: 0x1 linked
// Checksum 0x777d9a1a, Offset: 0xe68
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
// Params 0, eflags: 0x5 linked
// Checksum 0xcca5cf29, Offset: 0x1008
// Size: 0x3c
function private function_6c46026b() {
    if (isdefined(self.state_machines)) {
        return;
    }
    self turn_off();
    self vehicle_ai::defaultstate_driving_exit();
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x5 linked
// Checksum 0x9665e0f5, Offset: 0x1050
// Size: 0x44
function private function_ed173e0b() {
    if (isdefined(self.state_machines)) {
        return;
    }
    var_9cd704a7 = spawnstruct();
    self vehicle_ai::defaultstate_off_enter(var_9cd704a7);
}

// Namespace player_vehicle/player_vehicle
// Params 2, eflags: 0x1 linked
// Checksum 0x778874ab, Offset: 0x10a0
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
// Params 1, eflags: 0x1 linked
// Checksum 0xf2358bd4, Offset: 0x12c0
// Size: 0x3f4
function on_vehicle_damage(params) {
    vehicle = self;
    if (!is_true(vehicle.isplayervehicle)) {
        return;
    }
    if (isdefined(vehicle.session)) {
        if (isdefined(params.eattacker) && is_true(params.eattacker.isplayervehicle)) {
            var_364c1a03 = params.eattacker;
            if (var_364c1a03 == vehicle) {
                vehicle.session.var_309ad81f += params.idamage;
                return;
            } else if (isdefined(var_364c1a03.session)) {
                var_364c1a03.session.var_ecd1fe60 += params.idamage;
                vehicle.session.var_770fd50d += params.idamage;
                return;
            }
        }
        vehicle.session.var_5ba0df6e += params.idamage;
    }
    if (isdefined(params) && isplayer(params.eattacker) && isdefined(params.idamage)) {
        params.eattacker stats::function_d40764f3(#"vehicle_damage", int(params.idamage));
        occupants = vehicle getvehoccupants();
        if (isdefined(occupants) && occupants.size > 0) {
            params.eattacker stats::function_d40764f3(#"vehicle_damage_occupied", int(params.idamage));
        }
    }
    if (isdefined(params) && isdefined(params.smeansofdeath)) {
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
                    self playsoundtoplayer(#"hash_6dd3a55ee3658ca", occupant);
                    break;
                }
            }
        }
    }
    vehicle vehicle_ai::update_damage_fx_level(params.idamage);
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x1 linked
// Checksum 0x4218d763, Offset: 0x16c0
// Size: 0x74
function on_vehicle_killed(*params) {
    vehicle = self;
    if (!isdefined(level.var_c3f91417)) {
        return;
    }
    if (!is_true(vehicle.isplayervehicle)) {
        return;
    }
    if (isdefined(level.var_c3f91417)) {
        vehicle clientfield::set("enemyvehicle", 0);
    }
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x1 linked
// Checksum 0x8371aa21, Offset: 0x1740
// Size: 0x1fe
function on_player_damage(params) {
    victim = self;
    attacker = params.eattacker;
    if (isdefined(victim) && is_true(victim.usingvehicle)) {
        vehicle = victim getvehicleoccupied();
        if (isdefined(vehicle) && isdefined(vehicle.session)) {
            vehicle.session.var_ffb0c509 += params.idamage;
        }
    }
    if (isdefined(attacker) && is_true(attacker.usingvehicle) && isplayer(attacker)) {
        vehicle = attacker getvehicleoccupied();
        if (isdefined(vehicle)) {
            if (params.smeansofdeath == "MOD_CRUSH") {
                if (isdefined(vehicle.session)) {
                    vehicle.session.var_33f48e5a += params.idamage;
                }
                if (isdefined(victim)) {
                    victim playsound("veh_body_impact_flesh");
                }
                if (isdefined(vehicle.var_93dc9da9)) {
                    vehicle playsound(vehicle.var_93dc9da9);
                }
                return;
            }
            if (isdefined(vehicle.session)) {
                vehicle.session.var_45bf3627 += params.idamage;
            }
        }
    }
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x0
// Checksum 0xb5be327e, Offset: 0x1948
// Size: 0x128
function on_player_killed(params) {
    victim = self;
    attacker = params.eattacker;
    if (is_true(victim.usingvehicle)) {
        vehicle = victim getvehicleoccupied();
        if (isdefined(vehicle) && isdefined(vehicle.session)) {
            vehicle.session.var_3893d13e++;
        }
    }
    if (is_true(attacker.usingvehicle)) {
        vehicle = attacker getvehicleoccupied();
        if (isdefined(vehicle) && isdefined(vehicle.session)) {
            if (params.smeansofdeath == "MOD_CRUSH") {
                vehicle.session.vehicle_kills++;
                return;
            }
            vehicle.session.passenger_kills++;
        }
    }
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x1 linked
// Checksum 0xa6f91143, Offset: 0x1a78
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
// Params 0, eflags: 0x1 linked
// Checksum 0x55c2d79f, Offset: 0x1b50
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
// Params 3, eflags: 0x1 linked
// Checksum 0xa86ae5eb, Offset: 0x1d08
// Size: 0x84
function function_c747eedd(vehicle, *player, seatindex) {
    if (player.vehicleclass === "boat") {
        if (player function_7548ecb2() && is_true(player.var_221879dc)) {
            if (seatindex === 0) {
                return false;
            }
        }
    }
    return true;
}

// Namespace player_vehicle/player_vehicle
// Params 3, eflags: 0x1 linked
// Checksum 0x8857d8dd, Offset: 0x1d98
// Size: 0x5e
function function_2513e40c(vehicle, player, seatindex) {
    if (!function_c747eedd(vehicle, player, seatindex)) {
        return false;
    }
    if (player item_world::function_8e0d14c1(1)) {
        return false;
    }
    return true;
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x5 linked
// Checksum 0x88826b16, Offset: 0x1e00
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
// Params 1, eflags: 0x5 linked
// Checksum 0xaa8018f, Offset: 0x1e50
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
            var_d3f8fc8a = vectordot(anglestoup(self.angles), -1 * params.normal);
            if (var_d3f8fc8a > var_a1805d6e) {
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

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x5 linked
// Checksum 0xa0fc556a, Offset: 0x21f8
// Size: 0x2bc
function private function_7ed26e27(vehicle) {
    if (is_true(level.var_3146aa25)) {
        return;
    }
    if (!isdefined(vehicle) || !isvehicle(vehicle) || is_true(vehicle.var_3e742dc1) || self.takedamage == 0) {
        return;
    }
    vehiclespeed = vehicle getspeedmph();
    if (!isdefined(vehiclespeed)) {
        return;
    }
    if (vehiclespeed >= getdvarfloat(#"hash_3be3de0273ba927c", 30)) {
        trace = groundtrace(self.origin + (0, 0, 10), self.origin - (0, 0, 235), 0, self, 0, 0);
        if (trace[#"fraction"] == 1 || trace[#"surfacetype"] === "water") {
            return;
        }
        var_1fdf316c = getdvarfloat(#"hash_3be3de0273ba927c", 30);
        var_a7796a79 = getdvarfloat(#"hash_142bd8fcb96c015e", 90);
        mindamage = getdvarfloat(#"hash_2fa8ec57d76f1cac", 20);
        maxdamage = getdvarfloat(#"hash_544adad8efeb58b2", 110);
        var_160753fb = mapfloat(var_1fdf316c, var_a7796a79, mindamage, maxdamage, vehiclespeed);
        if (var_160753fb > self.health) {
            if (var_160753fb / 2 < self.health) {
                var_160753fb = self.health - 1;
            }
        }
        self dodamage(var_160753fb, self.origin, undefined, undefined, undefined, "MOD_FALLING");
    }
}

// Namespace player_vehicle/veh_submerged
// Params 1, eflags: 0x40
// Checksum 0x732c7df6, Offset: 0x24c0
// Size: 0xfc
function event_handler[veh_submerged] function_f7794c85(*eventstruct) {
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
// Params 0, eflags: 0x5 linked
// Checksum 0x5741929f, Offset: 0x25c8
// Size: 0x1c
function private function_df786031() {
    return isdefined(self.locking_on) && self.locking_on > 0;
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x5 linked
// Checksum 0x4d62fb0, Offset: 0x25f0
// Size: 0x1c
function private function_ea4291d3() {
    return isdefined(self.locked_on) && self.locked_on > 0;
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x5 linked
// Checksum 0xcfecde08, Offset: 0x2618
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
// Params 0, eflags: 0x1 linked
// Checksum 0x8ce64dca, Offset: 0x2770
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
// Params 1, eflags: 0x1 linked
// Checksum 0xf0c48c30, Offset: 0x2850
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
// Params 2, eflags: 0x5 linked
// Checksum 0xc9d3c9b5, Offset: 0x29b0
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
        var_6ce65309 = (dist - 10) / range;
        beep_interval = lerpfloat(0.05, 0.2, var_6ce65309);
        wait beep_interval;
    }
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x1 linked
// Checksum 0x9c499b40, Offset: 0x2b48
// Size: 0x5c
function function_adc0649a() {
    assert(isvehicle(self));
    return is_true(self.emped) || is_true(self.isjammed);
}

// Namespace player_vehicle/enter_vehicle
// Params 1, eflags: 0x40
// Checksum 0x6af0847f, Offset: 0x2bb0
// Size: 0x346
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
}

// Namespace player_vehicle/exit_vehicle
// Params 1, eflags: 0x40
// Checksum 0xe8cbab5f, Offset: 0x2f00
// Size: 0x330
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
    if (!self util::isusingremote()) {
        self function_7ed26e27(vehicle);
    }
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
// Checksum 0x8d832f2c, Offset: 0x3238
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
// Checksum 0x5243f922, Offset: 0x32c8
// Size: 0x3a4
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
    vehicle callback::callback(#"hash_2c1cafe2a67dfef8", {#player:self, #eventstruct:eventstruct});
    isemped = vehicle function_adc0649a();
    vehicle function_388973e4(isemped);
}

// Namespace player_vehicle/event_44d3f985
// Params 1, eflags: 0x40
// Checksum 0xe938c895, Offset: 0x3678
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
// Params 0, eflags: 0x1 linked
// Checksum 0x7dbe01b9, Offset: 0x3740
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
// Checksum 0x77ec64fe, Offset: 0x3820
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
// Params 1, eflags: 0x1 linked
// Checksum 0xcf5aa851, Offset: 0x3918
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
// Params 0, eflags: 0x5 linked
// Checksum 0xa601797d, Offset: 0x3ad8
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
// Params 1, eflags: 0x5 linked
// Checksum 0x1a1f25, Offset: 0x3b88
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
// Params 2, eflags: 0x1 linked
// Checksum 0xaa61b042, Offset: 0x3c40
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
// Params 1, eflags: 0x5 linked
// Checksum 0x667e778b, Offset: 0x3d08
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
// Checksum 0xb0cf4c74, Offset: 0x3dc0
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
// Params 1, eflags: 0x1 linked
// Checksum 0x8aa7c885, Offset: 0x4000
// Size: 0x64
function function_388973e4(disable) {
    self disabledriverfiring(disable);
    for (gunnerindex = 0; gunnerindex < 4; gunnerindex++) {
        self disablegunnerfiring(gunnerindex, disable);
    }
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x5 linked
// Checksum 0xaff1634, Offset: 0x4070
// Size: 0x222
function private function_17949e01() {
    self notify("42f4c1c49f9a26f1");
    self endon("42f4c1c49f9a26f1");
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
// Params 2, eflags: 0x1 linked
// Checksum 0xf3575ef6, Offset: 0x42a0
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
// Params 0, eflags: 0x1 linked
// Checksum 0x34c1f08d, Offset: 0x4300
// Size: 0x39e
function function_e8e41bbb() {
    self notify("2591ae2cffe4c529");
    self endon("2591ae2cffe4c529");
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
// Checksum 0x3628fb28, Offset: 0x46a8
// Size: 0x12
function function_971ca64b() {
    self.var_b71d69e0 = 1;
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x0
// Checksum 0x853937b8, Offset: 0x46c8
// Size: 0x24
function function_a2626745() {
    self.var_b71d69e0 = 0;
    self thread function_e8e41bbb();
}

// Namespace player_vehicle/player_vehicle
// Params 0, eflags: 0x1 linked
// Checksum 0xd8b47dc4, Offset: 0x46f8
// Size: 0x26
function function_7ca7a7e5() {
    if (is_true(self.var_b71d69e0)) {
        return true;
    }
    return false;
}

// Namespace player_vehicle/player_vehicle
// Params 1, eflags: 0x1 linked
// Checksum 0xbb933640, Offset: 0x4728
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
// Params 1, eflags: 0x1 linked
// Checksum 0x9c1a8c35, Offset: 0x4878
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
// Params 0, eflags: 0x1 linked
// Checksum 0x92d25c95, Offset: 0x4b00
// Size: 0x2ac
function function_d3da7e1e() {
    self notify("6b47557e1083bd7d");
    self endon("6b47557e1083bd7d");
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
// Params 1, eflags: 0x5 linked
// Checksum 0x1636204c, Offset: 0x4db8
// Size: 0x34
function private function_11b95c7f(targetent) {
    self waittill(#"death");
    targetent delete();
}

/#

    // Namespace player_vehicle/player_vehicle
    // Params 1, eflags: 0x4
    // Checksum 0xdc1735b6, Offset: 0x4df8
    // Size: 0x56
    function private function_2f3dd76f(targetent) {
        self endon(#"death");
        while (true) {
            sphere(targetent.origin, 30, (0, 1, 0));
            waitframe(1);
        }
    }

#/
