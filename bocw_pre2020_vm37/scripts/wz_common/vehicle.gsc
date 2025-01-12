#using script_40fc784c60f9fa7b;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\system_shared;

#namespace wz_vehicle;

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x6
// Checksum 0xcf687443, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"wz_vehicle", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x5 linked
// Checksum 0xff759a34, Offset: 0xf0
// Size: 0x10c
function private function_70a657d8() {
    level.var_cd8f416a = [];
    level.var_63e0085 = 0;
    level.var_7c6454 = 1;
    callback::add_callback(#"hash_5ca3a1f306039e1e", &function_f565cb50);
    callback::add_callback(#"hash_666d48a558881a36", &function_8307577f);
    callback::add_callback(#"hash_55f29e0747697500", &function_afa0a283);
    callback::add_callback(#"hash_2c1cafe2a67dfef8", &function_6bcb016d);
    callback::on_end_game(&on_end_game);
}

// Namespace wz_vehicle/vehicle
// Params 0, eflags: 0x1 linked
// Checksum 0xf58288ee, Offset: 0x208
// Size: 0x1c
function function_f565cb50() {
    level.var_cd8f416a[level.var_cd8f416a.size] = self;
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x1 linked
// Checksum 0x462eb9e2, Offset: 0x230
// Size: 0x1c4
function function_8307577f(params) {
    vehicle = self;
    player = params.player;
    seatindex = params.eventstruct.seat_index;
    if (isdefined(level.var_8819644a)) {
        for (i = 0; i < level.var_8819644a.size; i++) {
            if (isdefined(level.var_8819644a[i].vehicle) && level.var_8819644a[i].vehicle == vehicle) {
                level.var_8819644a[i].used = 1;
            }
        }
    }
    if (!isdefined(vehicle.session)) {
        player function_3054737a(vehicle);
    } else {
        occupants = vehicle getvehoccupants();
        vehicle.session.var_efe98761 = int(max(vehicle.session.var_efe98761, occupants.size));
    }
    if (seatindex === 0) {
        callback::callback("on_driving_wz_vehicle", {#vehicle:vehicle, #player:player, #seatindex:seatindex});
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x1 linked
// Checksum 0x4402bcf1, Offset: 0x400
// Size: 0x8c
function function_afa0a283(params) {
    vehicle = self;
    player = params.player;
    seatindex = params.eventstruct.seat_index;
    a_occupants = vehicle getvehoccupants();
    if (a_occupants.size == 0) {
        function_2d00376(vehicle);
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x1 linked
// Checksum 0xaa7b57b, Offset: 0x498
// Size: 0xc4
function function_6bcb016d(params) {
    vehicle = self;
    player = params.player;
    seatindex = params.eventstruct.seat_index;
    oldseatindex = params.eventstruct.old_seat_index;
    if (seatindex == 0) {
        callback::callback("on_driving_wz_vehicle", {#vehicle:vehicle, #player:self, #seatindex:seatindex});
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x1 linked
// Checksum 0xcec7f35c, Offset: 0x568
// Size: 0x24e
function function_3054737a(vehicle) {
    if (game.state == "pregame" || !isplayer(self) || self isremotecontrolling() || isdefined(vehicle.session)) {
        return;
    }
    vehicle.session = {#vehicle:vehicle.vehicletype, #var_2dbaf8ca:vehicle.origin[0], #var_1ff15d37:vehicle.origin[1], #var_16f7d5d0:vehicle.origin[0], #var_4ba3155:vehicle.origin[1], #var_c87538d9:vehicle.trackingindex, #start_time:gettime(), #end_time:0, #start_health:vehicle.health, #end_health:vehicle.health, #first_player:int(self getxuid(1)), #var_efe98761:1, #var_309ad81f:0, #var_5ba0df6e:0, #var_770fd50d:0, #var_33f48e5a:0, #var_ecd1fe60:0, #vehicle_kills:0, #var_ffb0c509:0, #var_45bf3627:0, #var_3893d13e:0, #passenger_kills:0};
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x1 linked
// Checksum 0x2d67d6c4, Offset: 0x7c0
// Size: 0x106
function function_2d00376(vehicle) {
    if (game.state == "pregame") {
        return;
    }
    if (isdefined(vehicle.session)) {
        vehicle.session.end_time = function_f8d53445();
        vehicle.session.end_health = int(max(0, vehicle.health));
        vehicle.session.var_16f7d5d0 = vehicle.origin[0];
        vehicle.session.var_4ba3155 = vehicle.origin[1];
        function_92d1707f(#"hash_4fd470ea26ade803", vehicle.session);
        vehicle.session = undefined;
    }
}

// Namespace wz_vehicle/vehicle
// Params 1, eflags: 0x1 linked
// Checksum 0xce89c4d3, Offset: 0x8d0
// Size: 0x5c
function on_end_game(*params) {
    vehicles = getvehiclearray();
    for (i = 0; i < vehicles.size; i++) {
        function_2d00376(vehicles[i]);
    }
}

