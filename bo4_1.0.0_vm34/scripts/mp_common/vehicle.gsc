#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_death_shared;

#namespace vehicle;

// Namespace vehicle/vehicle
// Params 0, eflags: 0x2
// Checksum 0x20ea52c4, Offset: 0xc0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"vehicle", &__init__, undefined, undefined);
}

// Namespace vehicle/vehicle
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x108
// Size: 0x4
function __init__() {
    
}

// Namespace vehicle/vehicle
// Params 2, eflags: 0x0
// Checksum 0xe89a05f8, Offset: 0x118
// Size: 0xec
function player_is_occupant_invulnerable(attacker, smeansofdeath) {
    if (self isremotecontrolling()) {
        return 0;
    }
    if (self.var_97f809e6 === 1 && self player_is_driver()) {
        if (self.var_eacfaf46 === 1 && isplayer(attacker) && attacker == self) {
            return 1;
        }
        return 0;
    }
    if (!isdefined(level.vehicle_drivers_are_invulnerable)) {
        level.vehicle_drivers_are_invulnerable = 0;
    }
    invulnerable = level.vehicle_drivers_are_invulnerable && self player_is_driver();
    return invulnerable;
}

// Namespace vehicle/vehicle
// Params 0, eflags: 0x0
// Checksum 0xbbd3956a, Offset: 0x210
// Size: 0x84
function player_is_driver() {
    if (!isalive(self)) {
        return false;
    }
    vehicle = self getvehicleoccupied();
    if (isdefined(vehicle)) {
        seat = vehicle getoccupantseat(self);
        if (isdefined(seat) && seat == 0) {
            return true;
        }
    }
    return false;
}

// Namespace vehicle/vehicle
// Params 0, eflags: 0x0
// Checksum 0x95e977cf, Offset: 0x2a0
// Size: 0x8c
function initvehiclemap() {
    /#
        root = "<dev string:x30>";
        adddebugcommand(root + "<dev string:x49>");
        adddebugcommand(root + "<dev string:x73>");
        adddebugcommand(root + "<dev string:xa2>");
    #/
    thread vehiclemainthread();
}

// Namespace vehicle/vehicle
// Params 0, eflags: 0x0
// Checksum 0x71cb6bb7, Offset: 0x338
// Size: 0xec
function vehiclemainthread() {
    spawn_nodes = struct::get_array("veh_spawn_point", "targetname");
    for (i = 0; i < spawn_nodes.size; i++) {
        spawn_node = spawn_nodes[i];
        veh_name = spawn_node.script_noteworthy;
        time_interval = int(spawn_node.script_parameters);
        if (!isdefined(veh_name)) {
            continue;
        }
        thread vehiclespawnthread(veh_name, spawn_node.origin, spawn_node.angles, time_interval);
        waitframe(1);
    }
}

// Namespace vehicle/vehicle
// Params 4, eflags: 0x0
// Checksum 0xa047e425, Offset: 0x430
// Size: 0x1fe
function vehiclespawnthread(veh_name, origin, angles, time_interval) {
    level endon(#"game_ended");
    veh_spawner = getent(veh_name + "_spawner", "targetname");
    while (true) {
        vehicle = veh_spawner spawnfromspawner(veh_name, 1, 1, 1);
        if (!isdefined(vehicle)) {
            wait randomfloatrange(1, 2);
            continue;
        }
        vehicle asmrequestsubstate(#"locomotion@movement");
        waitframe(1);
        vehicle makevehicleusable();
        if (target_istarget(vehicle)) {
            target_remove(vehicle);
        }
        vehicle.origin = origin;
        vehicle.angles = angles;
        vehicle.nojumping = 1;
        vehicle.forcedamagefeedback = 1;
        vehicle.vehkilloccupantsondeath = 1;
        vehicle disableaimassist();
        vehicle thread vehicleteamthread();
        vehicle waittill(#"death");
        vehicle vehicle_death::deletewhensafe(0.25);
        if (isdefined(time_interval)) {
            wait time_interval;
        }
    }
}

// Namespace vehicle/vehicle
// Params 0, eflags: 0x0
// Checksum 0xa24bb048, Offset: 0x638
// Size: 0x1b8
function vehicleteamthread() {
    vehicle = self;
    vehicle endon(#"death");
    while (true) {
        waitresult = vehicle waittill(#"enter_vehicle");
        player = waitresult.player;
        vehicle setteam(player.team);
        vehicle clientfield::set("toggle_lights", 1);
        if (!target_istarget(vehicle)) {
            if (isdefined(vehicle.targetoffset)) {
                target_set(vehicle, vehicle.targetoffset);
            } else {
                target_set(vehicle, (0, 0, 0));
            }
        }
        vehicle thread watchplayerexitrequestthread(player);
        vehicle waittill(#"exit_vehicle");
        vehicle setteam(#"neutral");
        vehicle clientfield::set("toggle_lights", 0);
        if (target_istarget(vehicle)) {
            target_remove(vehicle);
        }
    }
}

// Namespace vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0x71bd5659, Offset: 0x7f8
// Size: 0xf2
function watchplayerexitrequestthread(player) {
    level endon(#"game_ended");
    player endon(#"death");
    player endon(#"disconnect");
    vehicle = self;
    vehicle endon(#"death");
    wait 1.5;
    while (true) {
        timeused = 0;
        while (player usebuttonpressed()) {
            timeused += 0.05;
            if (timeused > 0.25) {
                player unlink();
                return;
            }
            waitframe(1);
        }
        waitframe(1);
    }
}

