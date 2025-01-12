#using script_1cf46b33555422b7;
#using script_5961deb533dad533;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\debug_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\mp_common\item_world;

#namespace wz_vehicle;

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x2
// Checksum 0xb9c74a37, Offset: 0x428
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"wz_vehicle", &__init__, undefined, undefined);
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x0
// Checksum 0x81ef84da, Offset: 0x470
// Size: 0x2c4
function __init__() {
    level.var_9e5060ba = ["player_atv", "cargo_truck_wz", "helicopter_light", "zodiac_boat_wz", "delivery_truck_wz", "hotrod_wz", "veh_fav_player_wz"];
    vehicle::add_main_callback("player_atv", &function_91ac2519);
    vehicle::add_main_callback("cargo_truck_wz", &function_9301fa14);
    vehicle::add_main_callback("helicopter_light", &function_605ac3ef);
    vehicle::add_main_callback("zodiac_boat_wz", &function_5573b382);
    vehicle::add_main_callback("veh_fav_player_wz", &function_718cb3c5);
    vehicle::add_main_callback("delivery_truck_wz", &function_f214623a);
    vehicle::add_main_callback("hotrod_wz", &function_259a035e);
    callback::on_vehicle_damage(&on_vehicle_damage);
    callback::on_player_damage(&on_player_damage);
    callback::on_player_killed_with_params(&on_player_killed);
    callback::on_end_game(&on_end_game);
    callback::on_vehicle_spawned(&vehicle_spawned);
    level.var_b140a8ba = [];
    level.var_88443c54 = 0;
    level.vehicleHealthBar = luielembar::register("vehicleHealthBar");
    level.vehicleHealthBarText = luielemtext::register("vehicleHealthBarText");
    level.var_f684ab66 = &function_f684ab66;
    level.var_e4f168ac = 1;
    level.var_ebb00118 = 0;
    /#
        level thread _setup_devgui();
    #/
}

/#

    // Namespace wz_vehicle/vehicle
    // Params 0, eflags: 0x4
    // Checksum 0xf9ada5e4, Offset: 0x740
    // Size: 0x8e
    function private function_d29bfc4b() {
        self notify("<invalid>");
        self endon("<invalid>");
        while (true) {
            if (getdvarint(#"wz_delete_vehicles", 0) > 0) {
                function_82cd2014();
                setdvar(#"wz_delete_vehicles", 0);
            }
            waitframe(1);
        }
    }

    // Namespace wz_vehicle/vehicle
    // Params 0, eflags: 0x4
    // Checksum 0x3d855db1, Offset: 0x7d8
    // Size: 0x20
    function private function_82cd2014() {
        level notify(#"hash_724a3976e45a71e2");
    }

    // Namespace wz_vehicle/vehicle
    // Params 0, eflags: 0x4
    // Checksum 0x296eaf96, Offset: 0x800
    // Size: 0x84
    function private _setup_devgui() {
        while (!canadddebugcommand()) {
            waitframe(1);
        }
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x41>" + mapname + "<dev string:x4f>");
        level thread function_d29bfc4b();
    }

#/

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x4
// Checksum 0xdfbaa682, Offset: 0x890
// Size: 0x104
function private function_b5a59f97(var_2e34d718 = 0) {
    level.var_b140a8ba[level.var_b140a8ba.size] = self;
    if (isdefined(self.scriptbundlesettings)) {
        self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    }
    self.var_f3f33bae = 1;
    self.script_disconnectpaths = 0;
    self.do_scripted_crash = 0;
    self.var_9c931473 = 1;
    self callback::function_1dea870d(#"hash_1a32e0fdeb70a76b", &function_527107f);
    if (var_2e34d718) {
        self function_7e8c8450();
    }
    self thread function_d04127b7();
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x69ce6978, Offset: 0x9a0
// Size: 0x4c
function private vehicle_spawned() {
    self.trackingindex = level.var_ebb00118;
    level.var_ebb00118++;
    /#
        self thread deletemeonnotify(level, "<dev string:x83>");
    #/
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x36f2bd9e, Offset: 0x9f8
// Size: 0x8a
function private function_7e8c8450() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::add_interrupt_connection("driving", "off", "exit_vehicle", &vehicle_ai::function_87c3d288);
    self vehicle_ai::get_state_callbacks("driving").enter_func = &function_d32ef556;
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x9e427208, Offset: 0xa90
// Size: 0x54
function private function_4c693143() {
    if (self vehicle_ai::has_state("off")) {
        vehicle_ai::startinitialstate("off");
        return;
    }
    self turn_off();
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0xbef228b, Offset: 0xaf0
// Size: 0x20
function private function_2f03513b() {
    if (self.scriptvehicletype == "helicopter_light") {
        return false;
    }
    return true;
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x4
// Checksum 0xccdb38fd, Offset: 0xb18
// Size: 0x34
function private function_d32ef556(params) {
    params.var_1a98d504 = 1;
    self vehicle_ai::defaultstate_driving_enter(params);
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x12ec5ae7, Offset: 0xb58
// Size: 0x94
function private turn_on() {
    if (isdefined(self.state_machines)) {
        return;
    }
    var_a1f2d51e = spawnstruct();
    var_a1f2d51e.var_d31e65c9 = 1;
    self vehicle_ai::defaultstate_off_exit(var_a1f2d51e);
    var_e378a5fc = spawnstruct();
    var_e378a5fc.var_1a98d504 = 1;
    self vehicle_ai::defaultstate_driving_enter(var_e378a5fc);
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0xb647040a, Offset: 0xbf8
// Size: 0x84
function private turn_off() {
    if (isdefined(self.state_machines)) {
        return;
    }
    var_e378a5fc = spawnstruct();
    self vehicle_ai::defaultstate_driving_exit(var_e378a5fc);
    var_a1f2d51e = spawnstruct();
    var_a1f2d51e.var_76615a30 = 1;
    self vehicle_ai::defaultstate_off_enter(var_a1f2d51e);
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0xe49d15bd, Offset: 0xc88
// Size: 0x42a
function private function_16262a55() {
    level waittill(#"all_players_spawned");
    while (true) {
        if (isalive(self) && self isvehicleseatoccupied(0)) {
            var_e98c9e5a = self getseatoccupant(0);
            if (isdefined(var_e98c9e5a)) {
                healthpercent = self.health / self.healthdefault;
                if (!level.vehicleHealthBar luielembar::is_open(var_e98c9e5a)) {
                    level.vehicleHealthBar luielembar::open(var_e98c9e5a);
                    level.vehicleHealthBar luielembar::set_alpha(var_e98c9e5a, 1);
                    level.vehicleHealthBar luielembar::function_a6bbb523(var_e98c9e5a, 150, 25);
                    level.vehicleHealthBar luielembar::function_ec358cb5(var_e98c9e5a, 835, 900);
                    level.vehicleHealthBar luielembar::set_bar_percent(var_e98c9e5a, healthpercent);
                } else {
                    level.vehicleHealthBar luielembar::set_bar_percent(var_e98c9e5a, healthpercent);
                }
                if (healthpercent > 0.85) {
                    level.vehicleHealthBar luielembar::set_color(var_e98c9e5a, 0, 1, 0);
                } else if (healthpercent > 0.5) {
                    level.vehicleHealthBar luielembar::set_color(var_e98c9e5a, 1, 1, 0);
                } else if (healthpercent > 0.25) {
                    level.vehicleHealthBar luielembar::set_color(var_e98c9e5a, 1, 0.5, 0);
                } else {
                    level.vehicleHealthBar luielembar::set_color(var_e98c9e5a, 1, 0, 0);
                }
                if (!level.vehicleHealthBarText luielemtext::is_open(var_e98c9e5a)) {
                    level.vehicleHealthBarText luielemtext::open(var_e98c9e5a, 1);
                    level.vehicleHealthBarText luielemtext::set_text(var_e98c9e5a, #"wz/vehicle_health");
                    level.vehicleHealthBarText luielemtext::function_ec358cb5(var_e98c9e5a, 0, 850);
                    level.vehicleHealthBarText luielemtext::set_color(var_e98c9e5a, 1, 1, 1);
                    level.vehicleHealthBarText luielemtext::set_alpha(var_e98c9e5a, 1);
                }
            }
        } else {
            if (isdefined(var_e98c9e5a)) {
                if (level.vehicleHealthBar luielembar::is_open(var_e98c9e5a)) {
                    level.vehicleHealthBar luielembar::close(var_e98c9e5a);
                }
                if (level.vehicleHealthBarText luielemtext::is_open(var_e98c9e5a)) {
                    level.vehicleHealthBarText luielemtext::close(var_e98c9e5a);
                }
                var_e98c9e5a = undefined;
            }
            if (!isalive(self)) {
                return;
            }
        }
        waitframe(1);
    }
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x12c5df7, Offset: 0x10c0
// Size: 0x42
function private function_8ac1021d() {
    if (!isdefined(self.var_36367c38)) {
        self.var_36367c38 = 0;
    }
    if (gettime() - self.var_36367c38 >= 1000) {
        self.var_36367c38 = gettime();
        return true;
    }
    return false;
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x4
// Checksum 0xc90fafc8, Offset: 0x1110
// Size: 0x35c
function private on_vehicle_collision(params) {
    if (!function_8ac1021d()) {
        return;
    }
    switch (self.scriptvehicletype) {
    case #"player_atv":
        var_eddbddfd = getdvarfloat(#"hash_3c9cb797fd1a7f8b", 30);
        var_460bc0bb = getdvarfloat(#"hash_67059652c5fc1945", 60);
        mindamage = getdvarfloat(#"hash_1f5d38cc94106adf", 50);
        maxdamage = getdvarfloat(#"hash_66a67ad27c3cd339", 250);
        var_c66d1ba6 = 1;
        break;
    case #"cargo_truck_wz":
        var_eddbddfd = getdvarfloat(#"hash_4bbc02727c5ebc00", 30);
        var_460bc0bb = getdvarfloat(#"hash_7d04949e6e62380e", 60);
        mindamage = getdvarfloat(#"hash_52512d74a3eaae58", 50);
        maxdamage = getdvarfloat(#"hash_5702452fcb66d0de", 250);
        var_c66d1ba6 = 2;
        break;
    default:
        var_eddbddfd = 30;
        var_460bc0bb = 60;
        mindamage = 50;
        maxdamage = 250;
        var_c66d1ba6 = 1;
        break;
    }
    var_bdbcf2e2 = params.intensity;
    if (isdefined(var_bdbcf2e2) && var_bdbcf2e2 > var_eddbddfd) {
        applydamage = mapfloat(var_eddbddfd, var_460bc0bb, mindamage, maxdamage, var_bdbcf2e2);
        self dodamage(applydamage, self.origin, self);
    }
    if (isdefined(params.entity) && issentient(params.entity)) {
        if (isdefined(var_bdbcf2e2) && var_bdbcf2e2 > 12) {
            applydamage = mapfloat(12, 50, 50, 1000, var_bdbcf2e2);
            params.entity dodamage(applydamage * var_c66d1ba6, self.origin, self);
        }
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x4
// Checksum 0xf47cec93, Offset: 0x1478
// Size: 0x20c
function private function_f0cc2d0(vehicle) {
    vehiclespeed = vehicle getspeedmph();
    if (vehiclespeed >= getdvarfloat(#"hash_3be3de0273ba927c", 25)) {
        trace = groundtrace(self.origin + (0, 0, 10), self.origin - (0, 0, 235), 0, self, 0, 0);
        if (trace[#"fraction"] == 1 || trace[#"surfacetype"] === "water") {
            return;
        }
        var_eddbddfd = getdvarfloat(#"hash_3be3de0273ba927c", 25);
        var_460bc0bb = getdvarfloat(#"hash_142bd8fcb96c015e", 90);
        mindamage = getdvarfloat(#"hash_2fa8ec57d76f1cac", 25);
        maxdamage = getdvarfloat(#"hash_544adad8efeb58b2", 130);
        var_9ee2466f = mapfloat(var_eddbddfd, var_460bc0bb, mindamage, maxdamage, vehiclespeed);
        self dodamage(var_9ee2466f, self.origin);
    }
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0xe4ca5883, Offset: 0x1690
// Size: 0x114
function private function_d04127b7() {
    self endon(#"death");
    self waittill(#"hash_57887008fa0fd8ad");
    occupants = self getvehoccupants();
    if (isdefined(occupants) && occupants.size) {
        for (i = 0; i < occupants.size; i++) {
            self usevehicle(occupants[i], self getoccupantseat(occupants[i]));
        }
    }
    self makevehicleunusable();
    self.takedamage = 0;
    self clientfield::set("stopallfx", 1);
    self clientfield::set("flickerlights", 1);
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0x6d9eda46, Offset: 0x17b0
// Size: 0x25e
function function_ee3ec9d3(vehicle) {
    if (game.state == "pregame" || !isplayer(self) || self isremotecontrolling() || isdefined(vehicle.session)) {
        return;
    }
    vehicle.session = {#vehicle:vehicle.vehicletype, #var_16494d71:vehicle.origin[0], #var_f046d308:vehicle.origin[1], #var_1494fd5e:vehicle.origin[0], #var_3a9777c7:vehicle.origin[1], #var_ba63c199:vehicle.trackingindex, #start_time:gettime(), #end_time:0, #start_health:vehicle.health, #end_health:vehicle.health, #first_player:int(self getxuid(1)), #var_f0f47b7c:1, #var_fa5dcba9:0, #var_37f3ea9c:0, #var_25c82ef1:0, #var_aad67e91:0, #var_e8ec974a:0, #vehicle_kills:0, #var_f9e35a19:0, #var_28b6919b:0, #var_96f49e7:0, #passenger_kills:0};
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0xac14596e, Offset: 0x1a18
// Size: 0x116
function function_e6fccb8(vehicle) {
    if (game.state == "pregame") {
        return;
    }
    if (isdefined(vehicle.session)) {
        vehicle.session.end_time = function_25e96038();
        vehicle.session.end_health = int(max(0, vehicle.health));
        vehicle.session.var_1494fd5e = vehicle.origin[0];
        vehicle.session.var_3a9777c7 = vehicle.origin[1];
        function_b1f6086c(#"hash_4fd470ea26ade803", vehicle.session);
        vehicle.session = undefined;
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0xc3c643db, Offset: 0x1b38
// Size: 0x176
function on_vehicle_damage(params) {
    vehicle = self;
    if (isdefined(vehicle.session)) {
        if (isdefined(params.eattacker) && isdefined(params.eattacker.isplayervehicle) && params.eattacker.isplayervehicle) {
            var_7e83cce9 = params.eattacker;
            if (var_7e83cce9 == vehicle) {
                vehicle.session.var_fa5dcba9 += params.idamage;
                return;
            } else if (isdefined(var_7e83cce9.session)) {
                var_7e83cce9.session.var_e8ec974a += params.idamage;
                vehicle.session.var_25c82ef1 += params.idamage;
                return;
            }
        }
        vehicle.session.var_37f3ea9c += params.idamage;
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0x29a96ae1, Offset: 0x1cb8
// Size: 0x1ae
function on_player_damage(params) {
    victim = self;
    attacker = params.attacker;
    if (isdefined(victim) && isdefined(victim.usingvehicle) && victim.usingvehicle) {
        vehicle = victim getvehicleoccupied();
        if (isdefined(vehicle) && isdefined(vehicle.session)) {
            vehicle.session.var_f9e35a19 += params.idamage;
        }
    }
    if (isdefined(attacker) && isdefined(attacker.usingvehicle) && attacker.usingvehicle) {
        vehicle = attacker getvehicleoccupied();
        if (isdefined(vehicle) && isdefined(vehicle.session)) {
            if (params.smeansofdeath == "MOD_CRUSH") {
                vehicle.session.var_aad67e91 += params.idamage;
                return;
            }
            vehicle.session.var_28b6919b += params.idamage;
        }
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0x1646ec07, Offset: 0x1e70
// Size: 0x140
function on_player_killed(params) {
    victim = self;
    attacker = params.eattacker;
    if (isdefined(victim.usingvehicle) && victim.usingvehicle) {
        vehicle = victim getvehicleoccupied();
        if (isdefined(vehicle) && isdefined(vehicle.session)) {
            vehicle.session.var_96f49e7++;
        }
    }
    if (isdefined(attacker.usingvehicle) && attacker.usingvehicle) {
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

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0xda45e433, Offset: 0x1fb8
// Size: 0x66
function on_end_game(params) {
    vehicles = getvehiclearray();
    for (i = 0; i < vehicles.size; i++) {
        function_e6fccb8(vehicles[i]);
    }
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x417242ce, Offset: 0x2028
// Size: 0x1c
function private function_c3973c1d() {
    return isdefined(self.locking_on) && self.locking_on > 0;
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x1587f6f2, Offset: 0x2050
// Size: 0x1c
function private function_eb052b3e() {
    return isdefined(self.locked_on) && self.locked_on > 0;
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x4
// Checksum 0x448d62ed, Offset: 0x2078
// Size: 0x11e
function private function_cd87af95(player) {
    self notify("462325eeb86d6f19");
    self endon("462325eeb86d6f19");
    self endon(#"death");
    player endon(#"exit_vehicle");
    player endon(#"death");
    while (true) {
        if (self function_eb052b3e()) {
            self playsoundtoplayer(#"hash_445c9fb1793c4259", player);
            wait 0.25;
            continue;
        }
        if (self function_c3973c1d()) {
            self playsoundtoplayer(#"hash_107b6827696673cb", player);
            wait 0.25;
            continue;
        }
        self waittill(#"locking on");
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0x7041dc91, Offset: 0x21a0
// Size: 0x1d0
function function_527107f(params) {
    self endon(#"death");
    occupants = self getvehoccupants();
    foreach (occupant in occupants) {
        if (!isplayer(occupant)) {
            continue;
        }
        occupant clientfield::set_player_uimodel("vehicle.incomingMissile", 1);
        occupant thread function_fa661b81(params.projectile, self);
    }
    params.projectile waittill(#"projectile_impact_explode", #"death");
    occupants = self getvehoccupants();
    foreach (occupant in occupants) {
        if (!isplayer(occupant)) {
            continue;
        }
        occupant clientfield::set_player_uimodel("vehicle.incomingMissile", 0);
    }
}

// Namespace wz_vehicle/vehicle
// Params 2, eflags: 0x4
// Checksum 0xabb8540f, Offset: 0x2378
// Size: 0x190
function private function_fa661b81(missile, vehicle) {
    self endon(#"death");
    self endon(#"exit_vehicle");
    missile endon(#"death");
    vehicle endon(#"death");
    range = 8000 - 10;
    dist = undefined;
    while (true) {
        old_dist = dist;
        dist = distance(missile.origin, self.origin);
        var_f2a20c2f = isdefined(old_dist) && dist < old_dist;
        if (var_f2a20c2f) {
            vehicle playsoundtoplayer(#"hash_445c9fb1793c4259", self);
        }
        normalizeddist = (dist - 10) / range;
        beep_interval = lerpfloat(0.05, 0.2, normalizeddist);
        wait beep_interval;
    }
}

// Namespace wz_vehicle/enter_vehicle
// Params 1, eflags: 0x40
// Checksum 0x7aef60b2, Offset: 0x2510
// Size: 0x21c
function event_handler[enter_vehicle] codecallback_vehicleenter(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    vehicle = eventstruct.vehicle;
    seatindex = eventstruct.seat_index;
    if (!isdefined(vehicle.scriptvehicletype)) {
        return;
    }
    if (!isinarray(level.var_9e5060ba, vehicle.scriptvehicletype)) {
        return;
    }
    if (isdefined(vehicle.on_player_enter)) {
        vehicle thread [[ vehicle.on_player_enter ]](self, eventstruct);
    }
    if (isdefined(level.var_251a5eb0)) {
        for (i = 0; i < level.var_251a5eb0.size; i++) {
            if (isdefined(level.var_251a5eb0[i].vehicle) && level.var_251a5eb0[i].vehicle == vehicle) {
                level.var_251a5eb0[i].used = 1;
            }
        }
    }
    if (!isdefined(vehicle.session)) {
        function_ee3ec9d3(vehicle);
    } else {
        occupants = vehicle getvehoccupants();
        vehicle.session.var_f0f47b7c = int(max(vehicle.session.var_f0f47b7c, occupants.size));
    }
    if (seatindex === 0) {
        vehicle turn_on();
    }
    vehicle thread function_cd87af95(self);
}

// Namespace wz_vehicle/exit_vehicle
// Params 1, eflags: 0x40
// Checksum 0x729730e, Offset: 0x2738
// Size: 0x18c
function event_handler[exit_vehicle] codecallback_vehicleexit(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    vehicle = eventstruct.vehicle;
    seatindex = eventstruct.seat_index;
    if (!isdefined(vehicle)) {
        return;
    }
    if (!isinarray(level.var_9e5060ba, vehicle.scriptvehicletype)) {
        return;
    }
    a_occupants = vehicle getvehoccupants();
    if (a_occupants.size == 0) {
        function_e6fccb8(vehicle);
    }
    self function_f0cc2d0(vehicle);
    self clientfield::set_player_uimodel("vehicle.incomingMissile", 0);
    if (isdefined(vehicle.on_player_exit)) {
        vehicle thread [[ vehicle.on_player_exit ]](self, eventstruct);
    }
    if (seatindex !== 0) {
        return;
    }
    vehicle turn_off();
    if (isdefined(vehicle.var_f3f33bae) && vehicle.var_f3f33bae) {
        vehicle thread function_f3f33bae();
    }
}

// Namespace wz_vehicle/change_seat
// Params 1, eflags: 0x40
// Checksum 0xda500361, Offset: 0x28d0
// Size: 0x2d0
function event_handler[change_seat] function_aa3bfdf9(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    vehicle = eventstruct.vehicle;
    seatindex = eventstruct.seat_index;
    oldseatindex = eventstruct.old_seat_index;
    if (!isinarray(level.var_9e5060ba, vehicle.scriptvehicletype)) {
        return;
    }
    if (oldseatindex === 0) {
        if (vehicle vehicle_ai::function_87c3d288() && vehicle function_2f03513b()) {
            if (vehicle vehicle_ai::has_state("off")) {
                vehicle vehicle_ai::set_state("off");
            } else {
                vehicle turn_off();
            }
            if (isdefined(vehicle.var_f3f33bae) && vehicle.var_f3f33bae) {
                vehicle thread function_f3f33bae();
            }
        }
    } else if (seatindex === 0) {
        if (vehicle vehicle_ai::function_903bcf50()) {
            if (vehicle vehicle_ai::has_state("landed") && vehicle vehicle_ai::get_current_state() === "off") {
                vehicle vehicle_ai::set_state("landed");
            } else if (vehicle vehicle_ai::has_state("recovery") && vehicle vehicle_ai::get_current_state() === "spiral") {
                vehicle vehicle_ai::set_state("recovery");
            } else if (vehicle vehicle_ai::has_state("driving")) {
                vehicle vehicle_ai::set_state("driving");
            } else {
                vehicle turn_on();
            }
        }
    }
    if (isdefined(vehicle.var_95d887ca)) {
        vehicle thread [[ vehicle.var_95d887ca ]](self, eventstruct);
    }
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x6063217b, Offset: 0x2ba8
// Size: 0x6e
function private function_f3f33bae() {
    self endon(#"death");
    util::wait_network_frame();
    for (group = 1; group < 4; group++) {
        self vehicle::toggle_lights_group(group, 1);
    }
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x72ca92e7, Offset: 0x2c20
// Size: 0xbc
function private function_91ac2519() {
    self disabledriverfiring(1);
    self disablegunnerfiring(0, 1);
    self function_b5a59f97();
    self function_4c693143();
    self callback::on_vehicle_collision(&on_vehicle_collision);
    if (getdvarint(#"hash_7e9ce8619b72edb2", 0)) {
        self thread function_16262a55();
    }
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x45a28ddd, Offset: 0x2ce8
// Size: 0xa4
function private function_718cb3c5() {
    self disabledriverfiring(1);
    self function_b5a59f97();
    self function_4c693143();
    self callback::on_vehicle_collision(&on_vehicle_collision);
    if (getdvarint(#"hash_7e9ce8619b72edb2", 0)) {
        self thread function_16262a55();
    }
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0xfdc3abf3, Offset: 0x2d98
// Size: 0xd4
function private function_9301fa14() {
    self disabledriverfiring(1);
    self setmovingplatformenabled(1);
    self function_b5a59f97();
    self function_4c693143();
    self callback::on_vehicle_collision(&on_vehicle_collision);
    if (getdvarint(#"hash_7e9ce8619b72edb2", 0)) {
        self thread function_16262a55();
    }
    self thread function_7604d530();
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x7b34273f, Offset: 0x2e78
// Size: 0x98
function private function_7604d530() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"enter_vehicle");
        playfxontag("vehicle/fx8_exhaust_truck_cargo_startup_os", self, "tag_fx_exhaust");
        if (isdefined(waitresult.player)) {
            waitresult.player playrumbleonentity("jet_rumble");
        }
    }
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x54349a22, Offset: 0x2f18
// Size: 0xbc
function private function_f214623a() {
    self disabledriverfiring(1);
    self setmovingplatformenabled(1);
    self function_b5a59f97();
    self function_4c693143();
    self callback::on_vehicle_collision(&on_vehicle_collision);
    if (getdvarint(#"hash_7e9ce8619b72edb2", 0)) {
        self thread function_16262a55();
    }
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x987006ac, Offset: 0x2fe0
// Size: 0xa4
function private function_259a035e() {
    self disabledriverfiring(1);
    self function_b5a59f97();
    self function_4c693143();
    self callback::on_vehicle_collision(&on_vehicle_collision);
    if (getdvarint(#"hash_7e9ce8619b72edb2", 0)) {
        self thread function_16262a55();
    }
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x4ef992ba, Offset: 0x3090
// Size: 0xbe
function private function_5573b382() {
    setdvar(#"phys_buoyancy", 1);
    self function_b5a59f97();
    self disabledriverfiring(1);
    self setmovingplatformenabled(1);
    self.on_player_enter = &function_5ce02d04;
    self.on_player_exit = &function_8abcb748;
    self function_4c693143();
    self.var_f3f33bae = undefined;
}

// Namespace wz_vehicle/vehicle
// Params 2, eflags: 0x4
// Checksum 0x746a303e, Offset: 0x3158
// Size: 0x7c
function private function_8abcb748(player, eventstruct) {
    if (isalive(self)) {
        self showpart("tag_motor_steer_animate", "", 1);
    }
    player detach("veh_t8_mil_boat_tactical_raft_outboard_motor_attach", "TAG_WEAPON_LEFT");
}

// Namespace wz_vehicle/vehicle
// Params 2, eflags: 0x4
// Checksum 0x20bb468c, Offset: 0x31e0
// Size: 0x94
function private function_5ce02d04(player, eventstruct) {
    player attach("veh_t8_mil_boat_tactical_raft_outboard_motor_attach", "TAG_WEAPON_LEFT");
    if (isalive(self)) {
        self hidepart("tag_motor_steer_animate", "", 1);
    }
    self thread function_37e033b6();
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0xbef93b30, Offset: 0x3280
// Size: 0x20a
function private function_bf61797a() {
    self notify("14f4a7ad4ba5c4ed");
    self endon("14f4a7ad4ba5c4ed");
    self endon(#"death");
    mag = getdvarfloat(#"hash_2612e4b1db15d42e", 150);
    height = getdvarfloat(#"hash_57e0d780126c4f57", 100);
    var_7cea2d8a = 0;
    while (true) {
        self waittill(#"beached");
        while (true) {
            waitresult = self waittill(#"touch", #"unbeached");
            if (waitresult._notify == #"touch" && isdefined(waitresult.pm_flags)) {
                time = gettime();
                if (time > var_7cea2d8a && waitresult.pm_flags & 128) {
                    force = anglestoforward(waitresult.entity getplayerangles());
                    force *= mag;
                    force += (0, 0, height);
                    self launchvehicle(force, self.origin);
                    var_7cea2d8a = time + 1500;
                }
                continue;
            }
            if (!self function_5a779fdf()) {
                break;
            }
        }
    }
}

// Namespace wz_vehicle/vehicle
// Params 2, eflags: 0x4
// Checksum 0xcb7fd44a, Offset: 0x3498
// Size: 0x54
function private deletemeonnotify(enttowatch, note) {
    self endon(#"death");
    if (!isdefined(enttowatch)) {
        return;
    }
    enttowatch waittill(note);
    self delete();
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0xa9ca1d8, Offset: 0x34f8
// Size: 0x396
function private function_37e033b6() {
    self notify("43b84bdd1395309b");
    self endon("43b84bdd1395309b");
    self endon(#"death");
    self.var_d881bd26 = 0;
    self thread function_bf61797a();
    fxorg = undefined;
    while (true) {
        speed = length(self getvelocity());
        if (self function_5a779fdf() && speed < 5) {
            if (!self.var_d881bd26) {
                occupants = self getvehoccupants();
                if (isdefined(occupants) && occupants.size) {
                    for (i = 0; i < occupants.size; i++) {
                        self usevehicle(occupants[i], self getoccupantseat(occupants[i]));
                    }
                }
                if (isdefined(fxorg)) {
                    fxorg delete();
                }
                fxorg = spawn("script_model", self gettagorigin("tag_motor_steer_animate"));
                if (isdefined(fxorg)) {
                    fxorg setmodel(#"tag_origin");
                    fxorg enablelinkto();
                    fxorg linkto(self, "tag_motor_steer_animate", (0, 0, 0), self gettagangles("tag_motor_steer_animate"));
                    playfxontag(#"hash_77f7368318366ae5", fxorg, "tag_origin");
                    fxorg thread deletemeonnotify(self, "death");
                }
                self playsound(#"evt_helicopter_midair_exp");
                self setmovingplatformenabled(0);
                self makevehicleunusable();
                self.var_d881bd26 = 1;
                self notify(#"beached");
            }
        } else if (self.var_d881bd26 && !self function_5a779fdf()) {
            self.var_d881bd26 = 0;
            self setmovingplatformenabled(1);
            self makevehicleusable();
            if (isdefined(fxorg)) {
                fxorg delete();
            }
            self notify(#"unbeached");
            wait 5;
        }
        waitframe(1);
    }
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x1ee65011, Offset: 0x3898
// Size: 0x41c
function private function_605ac3ef() {
    self disabledriverfiring(1);
    self disablegunnerfiring(0, 1);
    self disablegunnerfiring(1, 1);
    self disablegunnerfiring(2, 1);
    self disablegunnerfiring(3, 1);
    self.death_type = "gibbed";
    self function_b5a59f97(1);
    if (!isdefined(self) || function_f68f5e32(self)) {
        return;
    }
    self.var_95d887ca = &function_29dcafe9;
    self.on_player_enter = &function_886081cc;
    self.on_player_exit = &function_56b137de;
    self vehicle_ai::get_state_callbacks("off").enter_func = &function_5d4cf5f0;
    self vehicle_ai::get_state_callbacks("off").exit_func = &function_deb3cd8a;
    self vehicle_ai::add_state("spiral", &function_9d64fcaf, &function_d5837bb4, &function_fd263bb7);
    self vehicle_ai::add_state("recovery", &function_7c49075, &function_6f2b30e6, &function_7c9bf2a9);
    self vehicle_ai::add_state("water_landing", &function_33f712b, &function_8dce8db8, &function_745b956b);
    self vehicle_ai::add_state("landing", &function_f84f18a3, &function_3e4cae30, &function_13466bc3);
    self vehicle_ai::add_state("landed", &function_c1a4a638, &function_16b2a805, &function_e7a6f6f2);
    self vehicle_ai::function_e08f50("driving", "exit_vehicle");
    self vehicle_ai::function_e08f50("off", "enter_vehicle");
    self vehicle_ai::add_interrupt_connection("off", "landed", "enter_vehicle", &vehicle_ai::function_903bcf50);
    self vehicle_ai::add_interrupt_connection("landed", "off", "exit_vehicle", &function_be4b6c17);
    self function_4c693143();
    self thread function_e4940272();
    self thread function_9ca65de2();
    self callback::on_vehicle_collision(&function_631aefcf);
}

// Namespace wz_vehicle/vehicle
// Params 4, eflags: 0x4
// Checksum 0x22af0c69, Offset: 0x3cc0
// Size: 0x44
function private function_be4b6c17(current_state, to_state, connection, params) {
    return !vehicle_ai::function_903bcf50(current_state, to_state, connection, params);
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x44d0289b, Offset: 0x3d10
// Size: 0x12c
function private function_e4940272() {
    self endon(#"death");
    offset = getdvarint(#"hash_626d3139a5fd29ca", -70);
    while (true) {
        var_936618a2 = self.origin[2] + offset - getwaterheight(self.origin);
        if (var_936618a2 <= 0) {
            if (self getspeedmph() > 40) {
                self dodamage(self.health, self.origin, undefined, undefined, "", "MOD_IMPACT");
            } else {
                self vehicle_ai::set_state("water_landing");
            }
        }
        if (var_936618a2 > 5000) {
            wait 1;
            continue;
        }
        waitframe(1);
    }
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0xa925dd2, Offset: 0x3e48
// Size: 0x13c
function private function_9ca65de2() {
    self endon(#"death");
    self endon(#"hash_41dbbf5434aab9e0");
    while (true) {
        if (isdefined(level.deathcircle) && isdefined(level.deathcircleindex)) {
            radius = level.deathcircle.radius - 0;
            var_5d2703ad = distance2dsquared(self.origin, level.deathcircle.origin) - radius * radius;
            if (var_5d2703ad > 0 || level.deathcircleindex > 4) {
                if (!isdefined(self.var_a3e0ca0)) {
                    self function_bc1d192a();
                }
            } else if (isdefined(self.var_a3e0ca0)) {
                self function_49756188();
            }
            wait 0.1;
            continue;
        }
        wait 1;
    }
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x6036d3a8, Offset: 0x3f90
// Size: 0x174
function private function_bc1d192a() {
    self function_4bd79d86(1);
    self clientfield::set("update_malfunction", 1);
    if (self vehicle_ai::get_current_state() === "off") {
        self function_1f8b4849();
        function_b4479973();
        self clientfield::set("flickerlights", 2);
        self notify(#"hash_41dbbf5434aab9e0");
        return;
    } else if (self vehicle_ai::get_current_state() === "landed") {
        self function_1f8b4849();
        function_b4479973();
        self notify(#"hash_41dbbf5434aab9e0");
        self vehicle_ai::set_state("off");
        return;
    }
    self clientfield::set("flickerlights", 2);
    self.var_a3e0ca0 = gettime();
    self thread function_c0602f85();
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x8a974c09, Offset: 0x4110
// Size: 0x4c
function private function_49756188() {
    self endon(#"death");
    self.var_a3e0ca0 = undefined;
    self notify(#"cancel_malfunction");
    self function_4696b90(1);
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0xaf7b3510, Offset: 0x4168
// Size: 0xcc
function private function_9e74a31c() {
    self takeplayercontrol();
    self clientfield::set("update_malfunction", 2);
    self thread function_b70fd009(1600);
    self setrotorspeed(0.7);
    self clientfield::set("flickerlights", 3);
    self function_1f8b4849();
    self function_4bd79d86(2);
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x4
// Checksum 0xd9bbf0e4, Offset: 0x4240
// Size: 0x14c
function private function_4696b90(exit = 0) {
    self notify(#"cancel_acceleration");
    self returnplayercontrol();
    if (self vehicle_ai::function_903bcf50()) {
        self setrotorspeed(1);
    }
    if (exit) {
        self function_4bd79d86(0);
        self clientfield::set("update_malfunction", 0);
        self clientfield::set("flickerlights", 3);
        self function_b7efc73d();
        return;
    }
    self function_4bd79d86(1);
    self clientfield::set("update_malfunction", 1);
    self clientfield::set("flickerlights", 2);
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0xe94efd2e, Offset: 0x4398
// Size: 0x110
function private function_67f99efb() {
    self endon(#"death");
    self endon(#"cancel_malfunction");
    self endon(#"hash_3c7ae83e462fe4e2");
    self endon(#"hash_41dbbf5434aab9e0");
    wait 5;
    self clientfield::set("flickerlights", 2);
    while (true) {
        self function_9e74a31c();
        wait randomfloatrange(1, 3);
        self function_4696b90();
        self clientfield::set("flickerlights", 2);
        wait randomfloatrange(3, 10);
    }
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0xb58de31, Offset: 0x44b0
// Size: 0x1f4
function private function_c0602f85() {
    self notify("7c87fe30c673d2cb");
    self endon("7c87fe30c673d2cb");
    self endon(#"death");
    self endon(#"cancel_malfunction");
    self endon(#"hash_41dbbf5434aab9e0");
    if (vehicle_ai::function_903bcf50()) {
        self thread function_67f99efb();
    }
    shutdowntime = gettime() + 30000;
    while (true) {
        if (gettime() < shutdowntime) {
        } else {
            self function_1f8b4849();
            state = self vehicle_ai::get_current_state();
            if (state === "off") {
                self function_b4479973();
            } else if (state === "landed") {
                params = spawnstruct();
                params.makeunusable = 1;
                self vehicle_ai::set_state("off", params);
            } else {
                self.var_a0915475 = 1;
                self function_4bd79d86(2);
                params = spawnstruct();
                params.var_b6751c10 = 60;
                self vehicle_ai::set_state("spiral", params);
            }
            self notify(#"hash_41dbbf5434aab9e0");
            return;
        }
        wait 0.5;
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0xd36d5398, Offset: 0x46b0
// Size: 0xb8
function function_4bd79d86(state) {
    foreach (occupant in self getvehoccupants()) {
        if (!isplayer(occupant)) {
            continue;
        }
        occupant clientfield::set_player_uimodel("vehicle.malfunction", state);
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0x828f7406, Offset: 0x4770
// Size: 0xd6
function function_b70fd009(scale) {
    self notify("25b224506b345020");
    self endon("25b224506b345020");
    self endon(#"death");
    self endon(#"cancel_malfunction");
    self endon(#"cancel_acceleration");
    self endon(#"hash_41dbbf5434aab9e0");
    while (true) {
        accel = anglestoup(self.angles) * scale;
        self setphysacceleration((accel[0], accel[1], -200));
        waitframe(1);
    }
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0xea39f492, Offset: 0x4850
// Size: 0x7e
function private function_b7efc73d() {
    groups = 3;
    if (self vehicle_ai::function_903bcf50()) {
        groups = 4;
    }
    for (group = 1; group <= groups; group++) {
        self vehicle::toggle_lights_group(group, 1);
    }
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x768e71e4, Offset: 0x48d8
// Size: 0x66
function private function_1f8b4849() {
    self clientfield::set("flickerlights", 3);
    for (group = 1; group <= 4; group++) {
        self vehicle::toggle_lights_group(group, 0);
    }
}

// Namespace wz_vehicle/vehicle
// Params 2, eflags: 0x4
// Checksum 0xd99abaa, Offset: 0x4948
// Size: 0x4c
function private function_886081cc(player, eventstruct) {
    seatindex = eventstruct.seat_index;
    if (seatindex === 0) {
        self function_e1aa5f2a(player);
    }
}

// Namespace wz_vehicle/vehicle
// Params 2, eflags: 0x4
// Checksum 0xf7c09b11, Offset: 0x49a0
// Size: 0x8c
function private function_29dcafe9(player, eventstruct) {
    seatindex = eventstruct.seat_index;
    oldseatindex = eventstruct.old_seat_index;
    if (oldseatindex === 0) {
        self function_3496c388(player);
        return;
    }
    if (seatindex === 0) {
        self function_e1aa5f2a(player);
    }
}

// Namespace wz_vehicle/vehicle
// Params 2, eflags: 0x4
// Checksum 0xe37bf3c6, Offset: 0x4a38
// Size: 0x6c
function private function_56b137de(player, eventstruct) {
    seatindex = eventstruct.seat_index;
    if (seatindex === 0) {
        self function_3496c388(player);
    }
    player clientfield::set_player_uimodel("vehicle.malfunction", 0);
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x4
// Checksum 0xef1ccf87, Offset: 0x4ab0
// Size: 0x2c
function private function_e1aa5f2a(player) {
    if (isdefined(self.var_a3e0ca0)) {
        self thread function_67f99efb();
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x4
// Checksum 0x2eceba26, Offset: 0x4ae8
// Size: 0x9c
function private function_3496c388(player) {
    state = self vehicle_ai::get_current_state();
    self notify(#"hash_3c7ae83e462fe4e2");
    if (state === "landed" || state === "off") {
        return;
    }
    if (state === "spiral") {
        self.var_a0915475 = 1;
        return;
    }
    self function_80b1a11b();
}

// Namespace wz_vehicle/vehicle
// Params 3, eflags: 0x0
// Checksum 0x5e59db4f, Offset: 0x4b90
// Size: 0x29c
function function_564e9a46(normal, origin = self.origin, offset = 0) {
    self notify("37c4675f49a51555");
    self endon("37c4675f49a51555");
    self endon(#"death");
    self endon(#"hash_7f30c56005fe2b32");
    if (!isdefined(normal)) {
        return 0;
    }
    if (isdefined(self.rotatemover)) {
        self.rotatemover delete();
        self.rotatemover = undefined;
    }
    self.rotatemover = spawn("script_model", origin);
    if (isdefined(self.rotatemover)) {
        self.rotatemover thread deletemeonnotify(self, "death");
        self.rotatemover.angles = self.angles;
        targetangles = function_f828c08c(self.rotatemover.angles, normal);
        self linkto(self.rotatemover);
        self.rotatemover rotateto(targetangles, 0.5, 0, 0.5);
        self.rotatemover moveto(origin + (0, 0, offset), 0.5, 0, 0.5);
        self.rotatemover waittill(#"rotatedone");
        self.rotatemover delete();
        self.rotatemover = undefined;
    }
    self setvehvelocity((0, 0, 0));
    self setangularvelocity((0, 0, 0));
    self setphysacceleration((0, 0, 0));
    self sethoverparams(0);
    self setgoal(self.origin, 1, 0);
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0xbe8a7865, Offset: 0x4e38
// Size: 0x2a
function private function_ce16a97b() {
    self.var_ccef6ccf = 0;
    self.var_576eaffc = 0;
    self.var_1053719f = undefined;
    self.var_9bc80663 = undefined;
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0xc2355c9b, Offset: 0x4e70
// Size: 0x194
function private function_80b1a11b() {
    self.var_576eaffc = 0;
    speed = self getspeedmph();
    heighttrace = physicstrace(self.origin, self.origin - (0, 0, 1536), (0, 0, 0), (0, 0, 0), self, 2);
    if (speed < 15 && heighttrace[#"fraction"] < 0.260417) {
        self.var_576eaffc = 1;
        self.var_ccef6ccf = 1;
        self vehicle_ai::set_state("landing");
        return;
    }
    if (speed < 80 && heighttrace[#"fraction"] < 1) {
        self.var_ccef6ccf = 1;
        params = spawnstruct();
        params.var_d96391d2 = 1;
        self vehicle_ai::set_state("spiral", params);
        return;
    }
    self.var_a0915475 = 1;
    self vehicle_ai::set_state("spiral");
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x4
// Checksum 0x85e1d359, Offset: 0x5010
// Size: 0x10c
function private function_5d4cf5f0(params) {
    self setvehvelocity((0, 0, 0));
    self setangularvelocity((0, 0, 0));
    self setphysacceleration((0, 0, 0));
    self sethoverparams(0);
    self setgoal(self.origin, 1, 0);
    if (isdefined(params.makeunusable) && params.makeunusable || isdefined(self.var_a3e0ca0)) {
        self function_b4479973();
    }
    params.var_76615a30 = 1;
    params.no_falling = 1;
    self vehicle_ai::defaultstate_off_enter(params);
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x4
// Checksum 0x7d63e4eb, Offset: 0x5128
// Size: 0x64
function private function_deb3cd8a(params) {
    params.var_251fcf3a = 2;
    params.var_9f06d5b4 = 1;
    params.var_d31e65c9 = 1;
    params.var_338ab99d = 1;
    self vehicle_ai::defaultstate_off_exit(params);
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x4
// Checksum 0x18f7b9ff, Offset: 0x5198
// Size: 0x3c
function private function_7de078ce(params) {
    self returnplayercontrol();
    self vehicle_ai::defaultstate_driving_enter(params);
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0x3cf22620, Offset: 0x51e0
// Size: 0x10c
function function_33f712b(params) {
    self takeplayercontrol();
    self setphysacceleration((0, 0, -100));
    self setvehvelocity((0, 0, 0));
    self setangularvelocity((0, 0, 0));
    self.var_a0915475 = 0;
    self function_b4479973();
    self.takedamage = 0;
    self setrotorspeed(0);
    self clientfield::set("stopallfx", 1);
    self clientfield::set("flickerlights", 1);
    self vehicle::toggle_sounds(0);
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0x9b876f2d, Offset: 0x52f8
// Size: 0xc
function function_8dce8db8(params) {
    
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0xdbcc6539, Offset: 0x5310
// Size: 0xc
function function_745b956b(params) {
    
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0x6efb325e, Offset: 0x5328
// Size: 0xa4
function function_9d64fcaf(params) {
    if (!isdefined(params.rotorspeed)) {
        params.rotorspeed = 0.7;
    }
    occupants = self getvehoccupants();
    if (occupants.size == 0) {
        params.var_b6751c10 = 60;
    }
    self setrotorspeed(params.rotorspeed);
    self takeplayercontrol();
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0xf5408d43, Offset: 0x53d8
// Size: 0x376
function function_d5837bb4(params) {
    self endon(#"change_state");
    self endon(#"death");
    if (!isdefined(params.var_b6751c10)) {
        params.var_b6751c10 = 25;
    }
    if (isdefined(params.var_d96391d2) && params.var_d96391d2) {
        params.nopitch = 1;
        params.var_adae62c5 = 1;
    }
    targetyaw = randomintrange(50, 150);
    if (targetyaw % 2 == 0) {
        targetyaw *= -1;
    }
    pitch = 0;
    roll = 0;
    yaw = 0;
    if (!(isdefined(params.var_adae62c5) && params.var_adae62c5)) {
        roll = targetyaw * -1 * randomfloatrange(0.125, 0.25);
    }
    if (!(isdefined(params.nopitch) && params.nopitch)) {
        pitch = abs(targetyaw) * randomfloatrange(0.075, 0.15);
    }
    starttime = gettime();
    while (true) {
        if (abs(yaw) < abs(targetyaw)) {
            yaw = lerpfloat(0, targetyaw, (gettime() - starttime) / 3000);
        }
        if ((pitch || roll) && asin(anglestoup(self.angles)[2]) < 90 - params.var_b6751c10) {
            pitch = 0;
            roll = 0;
        }
        self setangularvelocity((pitch, yaw, roll));
        up = anglestoup(self.angles);
        accel = 1200;
        if (params.var_b6751c10 < 45) {
            accel = 1600;
        }
        self setphysacceleration((up[0] * accel, up[1] * accel, -386 * max(0.4, 1.2 - up[2])));
        waitframe(1);
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0xe4ed51c, Offset: 0x5758
// Size: 0x2c
function function_fd263bb7(params) {
    self setrotorspeed(1);
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0xe0b5e723, Offset: 0x5790
// Size: 0x24
function function_7c49075(params) {
    self takeplayercontrol();
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0xd93dd44e, Offset: 0x57c0
// Size: 0x162
function function_6f2b30e6(params) {
    self endon(#"death");
    self endon(#"change_state");
    while (true) {
        pilot = self getseatoccupant(0);
        if (!isdefined(pilot)) {
            self vehicle_ai::set_state("spiral");
            break;
        }
        move = pilot getnormalizedmovement();
        if (pilot vehiclemoveupbuttonpressed() || isdefined(move) && (abs(move[0]) > 0.2 || abs(move[1]) > 0.2)) {
            self.var_a0915475 = undefined;
            self returnplayercontrol();
            self vehicle_ai::set_state("driving");
            break;
        }
        waitframe(1);
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0x574a5888, Offset: 0x5930
// Size: 0xc
function function_7c9bf2a9(params) {
    
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0xafc2491e, Offset: 0x5948
// Size: 0x5c
function function_f84f18a3(params) {
    self setvehvelocity((0, 0, 0));
    self setangularvelocity((0, 0, 0));
    self setphysacceleration((0, 0, -386));
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0x33265a5d, Offset: 0x59b0
// Size: 0x7c
function function_3e4cae30(params) {
    self endon(#"change_state");
    self endon(#"death");
    while (true) {
        wait 0.5;
        if (self function_df008aca()) {
            self vehicle_ai::set_state("landed");
            break;
        }
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0x1f55e396, Offset: 0x5a38
// Size: 0xc
function function_13466bc3(params) {
    
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0xbc53de35, Offset: 0x5a50
// Size: 0xdc
function function_c1a4a638(params) {
    self takeplayercontrol();
    self setvehvelocity((0, 0, 0));
    self setangularvelocity((0, 0, 0));
    self setphysacceleration((0, 0, 0));
    self sethoverparams(0);
    self setgoal(self.origin, 1, 0);
    self thread function_564e9a46(self.var_1053719f, self.helilandingorigin, self.var_9bc80663);
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0x86887fec, Offset: 0x5b38
// Size: 0x192
function function_16b2a805(params) {
    self endon(#"death");
    self endon(#"state_changed");
    if (self vehicle_ai::get_previous_state() === "off") {
        wait 2;
    }
    while (true) {
        player = self getseatoccupant(0);
        if (!isdefined(player)) {
            params = spawnstruct();
            params.no_falling = 1;
            self vehicle_ai::set_state("off", params);
            break;
        }
        move = player getnormalizedmovement();
        if (player vehiclemoveupbuttonpressed() || isdefined(move) && (abs(move[0]) > 0.2 || abs(move[1]) > 0.2)) {
            self vehicle_ai::set_state("driving");
            break;
        }
        waitframe(1);
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0x299043ce, Offset: 0x5cd8
// Size: 0x8c
function function_e7a6f6f2(params) {
    if (vehicle_ai::function_903bcf50()) {
        self notify(#"hash_7f30c56005fe2b32");
        self returnplayercontrol();
        if (isdefined(self.rotatemover)) {
            self.rotatemover delete();
            self.rotatemover = undefined;
        }
    }
    self function_ce16a97b();
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0x4cb77f4e, Offset: 0x5d70
// Size: 0x652
function private function_df008aca() {
    height = self.height;
    assert(isdefined(self.radius));
    assert(isdefined(self.height));
    var_9e9f25cd = [];
    var_9e9f25cd[#"leftrear"] = self gettagorigin("tag_ground_contact_left_rear");
    var_9e9f25cd[#"leftmiddle"] = self gettagorigin("tag_ground_contact_left_middle");
    var_9e9f25cd[#"leftfront"] = self gettagorigin("tag_ground_contact_left_front");
    var_c011e98a = [];
    var_c011e98a[#"rightrear"] = self gettagorigin("tag_ground_contact_right_rear");
    var_c011e98a[#"rightmiddle"] = self gettagorigin("tag_ground_contact_right_middle");
    var_c011e98a[#"rightfront"] = self gettagorigin("tag_ground_contact_right_front");
    var_bde42b68 = [];
    foreach (tag, origin in var_9e9f25cd) {
        if (!isdefined(origin)) {
            return false;
        }
        var_bde42b68[tag] = physicstrace(origin + (0, 0, 25), origin - (0, 0, 75), (0, 0, 0), (0, 0, 0), self, 2);
    }
    var_630a17fb = [];
    foreach (tag, origin in var_c011e98a) {
        if (!isdefined(origin)) {
            return false;
        }
        var_630a17fb[tag] = physicstrace(origin + (0, 0, 25), origin - (0, 0, 75), (0, 0, 0), (0, 0, 0), self, 2);
    }
    var_5e578304 = [];
    var_5129a8e1 = (0, 0, 0);
    avgnormal = (0, 0, 0);
    var_2e730e62 = 0;
    foreach (tag, trace in var_bde42b68) {
        if (isdefined(trace[#"entity"])) {
            continue;
        }
        if (trace[#"fraction"] < 1) {
            var_5129a8e1 += var_9e9f25cd[tag];
            var_2e730e62 += trace[#"position"][2] - var_9e9f25cd[tag][2];
            avgnormal += trace[#"normal"];
            var_5e578304[tag] = trace;
        }
    }
    var_6a1cea27 = [];
    foreach (tag, trace in var_630a17fb) {
        if (isdefined(trace[#"entity"])) {
            continue;
        }
        if (trace[#"fraction"] < 1) {
            var_5129a8e1 += var_c011e98a[tag];
            var_2e730e62 += trace[#"position"][2] - var_c011e98a[tag][2];
            avgnormal += trace[#"normal"];
            var_6a1cea27[tag] = trace;
        }
    }
    if (var_5e578304.size > 0 || var_6a1cea27.size > 0) {
        avgnormal /= var_6a1cea27.size + var_5e578304.size;
        self.var_d0a155b1 = avgnormal;
    }
    if (avgnormal[2] < 0.94) {
        return false;
    }
    if (var_5e578304.size == 0 || var_6a1cea27.size == 0 || var_6a1cea27.size + var_5e578304.size < 3) {
        return false;
    }
    var_2e730e62 /= var_6a1cea27.size + var_5e578304.size + 1;
    var_5129a8e1 /= var_6a1cea27.size + var_5e578304.size;
    self.helilandingorigin = var_5129a8e1;
    self.var_9bc80663 = var_2e730e62;
    self.var_1053719f = avgnormal;
    return true;
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x4
// Checksum 0x243b9b6d, Offset: 0x63d0
// Size: 0x3cc
function private function_631aefcf(params) {
    if (params.stype === "player") {
        return;
    }
    if (isdefined(self.var_a0915475) && self.var_a0915475) {
        self dodamage(self.health, self.origin, undefined, undefined, "", "MOD_IMPACT");
        return;
    }
    if (!(isdefined(self.var_576eaffc) && self.var_576eaffc)) {
        var_eddbddfd = getdvarfloat(#"hash_54a2c2e9555f2e5e", 35);
        var_460bc0bb = getdvarfloat(#"hash_70c1f7e69c442750", 140);
        mindamage = getdvarfloat(#"hash_42dae76d8ea47a8e", 75);
        maxdamage = getdvarfloat(#"hash_55d628640db7ed48", 3000);
        currentspeed = self getspeedmph();
        if (currentspeed > var_eddbddfd) {
            applydamage = mapfloat(var_eddbddfd, var_460bc0bb, mindamage, maxdamage, currentspeed);
            normal = params.normal;
            sourceposition = self.origin - 100 * normal;
            self dodamage(applydamage, sourceposition);
        }
    }
    state = self vehicle_ai::get_current_state();
    if (state === "driving") {
        player = self getseatoccupant(0);
        if (!isdefined(player) || !player vehiclemovedownbuttonpressed()) {
            return;
        }
        move = player getnormalizedmovement();
        if (isdefined(move) && (abs(move[0]) > 0.2 || abs(move[1]) > 0.2)) {
            return;
        }
        if (self function_df008aca()) {
            self vehicle_ai::set_state("landed", params);
        }
        return;
    }
    if (state === "landing" || state === "spiral") {
        self function_df008aca();
        if (isdefined(self.var_1053719f)) {
            self vehicle_ai::set_state("landed");
            return;
        }
        if (isdefined(self.var_d0a155b1)) {
            self function_1ae5703b();
        }
    }
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x0
// Checksum 0xd423ecbb, Offset: 0x67a8
// Size: 0x74
function function_1ae5703b() {
    if (!isdefined(self.var_d0a155b1)) {
        return;
    }
    slidemove = (1, 0, 0);
    if (self.var_d0a155b1[2] < 0.99) {
        slidemove = (self.var_d0a155b1[0], self.var_d0a155b1[1], 0);
    }
    self setvehvelocity(slidemove * 300);
}

// Namespace wz_vehicle/vehicle
// Params 2, eflags: 0x0
// Checksum 0x46b4109c, Offset: 0x6828
// Size: 0x2c
function function_f684ab66(vehicle, player) {
    return !player item_world::function_9ecda51c();
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x0
// Checksum 0x877b6cf4, Offset: 0x6860
// Size: 0xac
function function_b4479973() {
    occupants = self getvehoccupants();
    if (isdefined(occupants) && occupants.size) {
        for (i = 0; i < occupants.size; i++) {
            self usevehicle(occupants[i], self getoccupantseat(occupants[i]));
        }
    }
    self makevehicleunusable();
}

/#

    // Namespace wz_vehicle/vehicle
    // Params 0, eflags: 0x0
    // Checksum 0x3da64469, Offset: 0x6918
    // Size: 0x328
    function function_508d1fef() {
        self endon(#"death");
        height = self.height;
        assert(isdefined(self.radius));
        assert(isdefined(self.height));
        while (true) {
            waitframe(1);
            leftrear = self gettagorigin("<dev string:x97>");
            leftmiddle = self gettagorigin("<dev string:xb4>");
            leftfront = self gettagorigin("<dev string:xd3>");
            rightrear = self gettagorigin("<dev string:xf1>");
            rightmiddle = self gettagorigin("<dev string:x10f>");
            rightfront = self gettagorigin("<dev string:x12f>");
            if (!isdefined(leftrear)) {
                break;
            }
            line(leftrear + (0, 0, 25), leftrear - (0, 0, 75), (1, 1, 0), 1);
            line(leftmiddle + (0, 0, 25), leftmiddle - (0, 0, 75), (1, 1, 0), 1);
            line(leftfront + (0, 0, 25), leftfront - (0, 0, 75), (1, 1, 0), 1);
            line(rightrear + (0, 0, 25), rightrear - (0, 0, 75), (1, 1, 0), 1);
            line(rightmiddle + (0, 0, 25), rightmiddle - (0, 0, 75), (1, 1, 0), 1);
            line(rightfront + (0, 0, 25), rightfront - (0, 0, 75), (1, 1, 0), 1);
        }
    }

#/
