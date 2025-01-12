#using script_1cd491b1807da8f7;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;

#namespace namespace_89bdd212;

// Namespace namespace_89bdd212/namespace_33ac7b74
// Params 0, eflags: 0x6
// Checksum 0x991a293d, Offset: 0x1d8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_6d81991664942c94", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_89bdd212/namespace_33ac7b74
// Params 0, eflags: 0x1 linked
// Checksum 0x12057555, Offset: 0x220
// Size: 0x14
function function_70a657d8() {
    function_35af332d();
}

// Namespace namespace_89bdd212/namespace_33ac7b74
// Params 0, eflags: 0x1 linked
// Checksum 0xdff3a270, Offset: 0x240
// Size: 0x4c4
function function_35af332d() {
    if (!getdvarint(#"hash_1fa47abbfa2b0da2", 1)) {
        return;
    }
    elevators = getentarray("elevator", "script_noteworthy");
    foreach (elevator in elevators) {
        if (!elevator ismovingplatform()) {
            elevator setmovingplatformenabled(1);
        }
        elevator.current_floor = 1;
        var_38a98fd1 = getdynentarray(elevator.target);
        triggers = getentarray(elevator.target, "targetname");
        elevator.var_38a98fd1 = var_38a98fd1;
        elevator.floors = var_38a98fd1.size;
        elevator.triggers = triggers;
        foreach (var_a0514541 in var_38a98fd1) {
            var_dfe5c0ef = struct::get(var_a0514541.target);
            var_a0514541.floor = var_dfe5c0ef.var_be98c9c4;
            var_a0514541.var_53bea8b6 = var_dfe5c0ef.origin;
            var_a0514541.elevator = elevator;
            var_a0514541.onuse = &function_31042f91;
            var_a0514541.ondamaged = &function_724a2fa5;
        }
        foreach (trigger in triggers) {
            if (trigger trigger::is_trigger_of_type("trigger_use", "trigger_use_touch")) {
                trigger.elevator = elevator;
                var_570a0ba4 = trigger;
                elevator.var_570a0ba4 = trigger;
                var_570a0ba4 enablelinkto();
                var_570a0ba4 linkto(elevator);
                var_570a0ba4 triggerignoreteam();
                var_570a0ba4 setvisibletoall();
                var_570a0ba4 setteamfortrigger(#"none");
                var_570a0ba4 setcursorhint("HINT_NOICON");
                var_570a0ba4 sethintstring(#"hash_29965b65bca9cd7b");
                var_570a0ba4 callback::on_trigger(&function_af088c90);
                continue;
            }
            kill_trigger = trigger;
            var_9d3ccba5 = struct::get(kill_trigger.target);
            kill_trigger.var_1adabde2 = var_9d3ccba5.origin;
            elevator.kill_trigger = trigger;
            kill_trigger enablelinkto();
            kill_trigger linkto(elevator);
            kill_trigger triggerenable(0);
            kill_trigger callback::on_trigger(&function_de6bfb5d);
        }
    }
}

// Namespace namespace_89bdd212/namespace_33ac7b74
// Params 1, eflags: 0x1 linked
// Checksum 0x64ab82ce, Offset: 0x710
// Size: 0xdc
function function_de6bfb5d(var_edb79dbc) {
    activator = var_edb79dbc.activator;
    if (isplayer(activator)) {
        if (level.inprematchperiod) {
            activator setorigin(self.var_1adabde2);
            return;
        }
        if (isalive(activator)) {
            activator dodamage(activator.health, activator.origin, undefined, undefined, "none", "MOD_CRUSH");
        }
        activator notsolid();
        activator ghost();
    }
}

// Namespace namespace_89bdd212/namespace_33ac7b74
// Params 0, eflags: 0x1 linked
// Checksum 0x846731d8, Offset: 0x7f8
// Size: 0x194
function function_ad26976() {
    self endon(#"movedone");
    while (true) {
        vehicles = getentitiesinradius(self.origin, 1536, 12);
        vehicle_corpses = getentitiesinradius(self.origin, 1536, 14);
        foreach (vehicle in vehicles) {
            vehicle launchvehicle((0, 0, 0), vehicle.origin, 0);
        }
        foreach (vehicle_corpse in vehicle_corpses) {
            vehicle_corpse delete();
        }
        wait 0.25;
    }
}

// Namespace namespace_89bdd212/namespace_33ac7b74
// Params 2, eflags: 0x1 linked
// Checksum 0x47803c47, Offset: 0x998
// Size: 0x1b4
function function_211e7277(point, var_8bd17d7d) {
    nearby_players = getplayers(undefined, point.origin, 256);
    move_pos = point.origin;
    var_93a4284 = 0;
    check_count = 0;
    if (nearby_players.size > 0) {
        var_93a4284 = 1;
    }
    while (var_93a4284 && check_count < 20) {
        foreach (player in nearby_players) {
            if (distance(player.origin, point.origin) < 16 && player.sessionstate == "playing") {
                var_93a4284 = 1;
                n_forward = var_8bd17d7d;
                n_forward *= (32, 32, 0);
                move_pos += n_forward;
                break;
            }
            var_93a4284 = 0;
        }
        check_count++;
    }
    self setorigin(move_pos);
}

// Namespace namespace_89bdd212/namespace_33ac7b74
// Params 1, eflags: 0x1 linked
// Checksum 0x75049092, Offset: 0xb58
// Size: 0x11a
function is_equipment(entity) {
    if (isdefined(entity.weapon)) {
        weapon = entity.weapon;
        if (weapon.name === #"ability_smart_cover" || weapon.name === #"eq_tripwire" || weapon.name === #"trophy_system" || weapon.name === #"eq_concertina_wire" || weapon.name === #"eq_sensor" || weapon.name === #"cymbal_monkey" || weapon.name === #"homunculus") {
            return true;
        }
    }
    return false;
}

// Namespace namespace_89bdd212/namespace_33ac7b74
// Params 1, eflags: 0x1 linked
// Checksum 0x38c9cd7e, Offset: 0xc80
// Size: 0x266
function function_777e012d(t_damage) {
    self endon(#"death");
    level endon(#"start_warzone");
    if (!isdefined(t_damage)) {
        return;
    }
    equipment = getentitiesinradius(t_damage.origin, 1536);
    foreach (device in equipment) {
        if (isdefined(device) && device istouching(t_damage)) {
            if (is_equipment(device)) {
                switch (device.weapon.name) {
                case #"eq_tripwire":
                    device [[ level.var_2e06b76a ]]();
                    break;
                case #"trophy_system":
                    device [[ level.var_4f3822f4 ]]();
                    break;
                case #"cymbal_monkey":
                    device [[ level.var_7c5c96dc ]]();
                    break;
                case #"homunculus":
                    device [[ level.var_cc310d06 ]]();
                    break;
                case #"eq_sensor":
                    device [[ level.var_9911d36f ]]();
                    break;
                case #"eq_concertina_wire":
                    device [[ level.var_94029383 ]]();
                    break;
                case #"gadget_supplypod":
                    device notify(#"death");
                    break;
                default:
                    device kill();
                    break;
                }
            }
        }
    }
}

// Namespace namespace_89bdd212/namespace_33ac7b74
// Params 1, eflags: 0x1 linked
// Checksum 0x9a32808d, Offset: 0xef0
// Size: 0x228
function elevator_kill_player(t_damage) {
    self endon(#"death");
    level endon(#"start_warzone");
    if (!isdefined(t_damage)) {
        return;
    }
    foreach (e_player in getplayers()) {
        if (e_player istouching(t_damage) && isalive(e_player) && isdefined(e_player)) {
            if (level.inprematchperiod) {
                var_96c44bd9 = 1;
                str_targetname = t_damage.targetname;
                if (isstring(str_targetname)) {
                    var_96c44bd9 = str_targetname[8];
                }
                point = struct::get("elevator_teleport_" + var_96c44bd9, "targetname");
                var_8bd17d7d = anglestoforward(point.angles);
                var_8bd17d7d = vectornormalize(var_8bd17d7d);
                if (isdefined(point)) {
                    e_player function_211e7277(point, var_8bd17d7d);
                }
                continue;
            }
            var_1c8ad6c7 = level flag::get(#"insertion_teleport_completed");
            if (var_1c8ad6c7) {
                e_player.var_1a776c13 = 1;
                e_player suicide();
            }
        }
    }
}

// Namespace namespace_89bdd212/namespace_33ac7b74
// Params 0, eflags: 0x1 linked
// Checksum 0xaae13f63, Offset: 0x1120
// Size: 0x3c
function function_8e73d913() {
    util::wait_network_frame(2);
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_89bdd212/namespace_33ac7b74
// Params 1, eflags: 0x1 linked
// Checksum 0x59f34712, Offset: 0x1168
// Size: 0x3e4
function function_26ab1b5e(t_damage) {
    self endon(#"death");
    level endon(#"start_warzone");
    if (!isdefined(t_damage)) {
        return;
    }
    vehicles = getentitiesinradius(t_damage.origin, 1536, 12);
    foreach (e_vehicle in vehicles) {
        if (e_vehicle istouching(t_damage) && isalive(e_vehicle)) {
            var_38ae32ff = e_vehicle.origin - t_damage.origin;
            var_8fa58819 = var_38ae32ff[2];
            var_8fa58819 *= var_8fa58819;
            if (var_8fa58819 < 32 || e_vehicle.scriptvehicletype === #"helicopter_light") {
                a_players = e_vehicle getvehoccupants();
                e_vehicle.takedamage = 1;
                e_vehicle.allowdeath = 1;
                e_vehicle dodamage(e_vehicle.health + 10000, e_vehicle.origin, undefined, undefined, "none", "MOD_EXPLOSIVE", 8192);
                waitframe(1);
                e_vehicle thread function_8e73d913();
                foreach (player in a_players) {
                    if (isalive(player) && isdefined(player) && !player isremotecontrolling()) {
                        if (level.inprematchperiod) {
                            var_96c44bd9 = 1;
                            str_targetname = t_damage.targetname;
                            if (isstring(str_targetname)) {
                                var_96c44bd9 = str_targetname[8];
                            }
                            point = struct::get("elevator_teleport_" + var_96c44bd9, "targetname");
                            var_8bd17d7d = anglestoforward(point.angles);
                            var_8bd17d7d = vectornormalize(var_8bd17d7d);
                            if (isdefined(point)) {
                                player function_211e7277(point, var_8bd17d7d);
                            }
                            continue;
                        }
                        var_1c8ad6c7 = level flag::get(#"insertion_teleport_completed");
                        if (var_1c8ad6c7) {
                            player.var_1a776c13 = 1;
                            player suicide();
                        }
                    }
                }
            }
        }
    }
}

// Namespace namespace_89bdd212/namespace_33ac7b74
// Params 1, eflags: 0x0
// Checksum 0x55ef6a1e, Offset: 0x1558
// Size: 0x18e
function function_76ad6828(position) {
    self endon(#"death");
    if (isdefined(self.script_noteworthy) && isdefined(position)) {
        var_a91da4b7 = self.script_noteworthy + "_player";
        var_bda7a712 = self.script_noteworthy + "_vehicle";
        var_68dc3bdf = getent(var_a91da4b7, "targetname");
        var_42611516 = getent(var_bda7a712, "targetname");
        if (isdefined(var_68dc3bdf) && isdefined(var_42611516)) {
            var_d011282b = distancesquared(self.origin, position.origin);
            while (var_d011282b > 16) {
                var_d011282b = distancesquared(self.origin, position.origin);
                if (var_d011282b <= 5000) {
                    self thread function_777e012d(var_68dc3bdf);
                    self thread function_26ab1b5e(var_42611516);
                    self thread elevator_kill_player(var_68dc3bdf);
                }
                waitframe(1);
            }
        }
    }
}

// Namespace namespace_89bdd212/namespace_33ac7b74
// Params 3, eflags: 0x1 linked
// Checksum 0x90dfa364, Offset: 0x16f0
// Size: 0x32c
function elevator_move(elevator, move_pos, var_74286087) {
    elevator endon(#"death");
    elevator.var_570a0ba4 triggerenable(0);
    foreach (var_a0514541 in elevator.var_38a98fd1) {
        function_e2a06860(var_a0514541, 1);
    }
    elevator.kill_trigger triggerenable(1);
    elevator.var_570a0ba4 playsound("evt_elevator_button_bell");
    wait 0.5;
    elevator thread function_ad26976();
    elevator playsound("evt_elevator_start");
    elevator playloopsound("evt_elevator_move", 0);
    elevator moveto(move_pos, 10, 0.5, 0.5);
    elevator waittill(#"movedone");
    hint = #"hash_310ad55f171e194e";
    if (elevator.current_floor > var_74286087) {
        hint = #"hash_29965b65bca9cd7b";
    }
    elevator.var_570a0ba4 sethintstring(hint);
    elevator.current_floor = var_74286087;
    elevator.var_570a0ba4 triggerenable(1);
    foreach (var_a0514541 in elevator.var_38a98fd1) {
        if (var_a0514541.floor != elevator.current_floor) {
            function_e2a06860(var_a0514541, 0);
        }
    }
    elevator playsound("evt_elevator_stop");
    elevator stoploopsound(1);
    elevator.kill_trigger triggerenable(0);
}

// Namespace namespace_89bdd212/namespace_33ac7b74
// Params 1, eflags: 0x1 linked
// Checksum 0x9d5e9fa5, Offset: 0x1a28
// Size: 0x194
function function_af088c90(trigger_struct) {
    trigger = self;
    trigger endon(#"death");
    activator = trigger_struct.activator;
    elevator = trigger.elevator;
    current_floor = elevator.current_floor;
    floors = elevator.floors;
    var_38a98fd1 = elevator.var_38a98fd1;
    var_ee7a297f = current_floor + 1;
    if (current_floor == floors) {
        var_ee7a297f = current_floor - 1;
    }
    activator gestures::function_56e00fbf("gestable_door_interact", undefined, 0);
    foreach (var_a0514541 in var_38a98fd1) {
        if (var_a0514541.floor == var_ee7a297f) {
            var_f09c4e0b = var_a0514541.var_53bea8b6;
            break;
        }
    }
    elevator_move(elevator, var_f09c4e0b, var_ee7a297f);
}

// Namespace namespace_89bdd212/namespace_33ac7b74
// Params 3, eflags: 0x1 linked
// Checksum 0xfa0f28f2, Offset: 0x1bc8
// Size: 0x7c
function function_31042f91(*activator, *laststate, *state) {
    var_b0244a52 = self;
    elevator = var_b0244a52.elevator;
    var_53bea8b6 = var_b0244a52.var_53bea8b6;
    var_18575f5e = var_b0244a52.floor;
    elevator_move(elevator, var_53bea8b6, var_18575f5e);
}

// Namespace namespace_89bdd212/namespace_33ac7b74
// Params 1, eflags: 0x5 linked
// Checksum 0x5a00a50b, Offset: 0x1c50
// Size: 0xee
function private function_724a2fa5(eventstruct) {
    dynent = eventstruct.ent;
    if (isdefined(eventstruct)) {
        dynent.health += eventstruct.amount;
    }
    if (isdefined(dynent.var_a548ec11) && gettime() <= dynent.var_a548ec11) {
        return;
    }
    if (distancesquared(eventstruct.ent.origin, eventstruct.position) > function_a3f6cdac(15)) {
        return;
    }
    var_a852a7dd = dynent_use::use_dynent(dynent);
    dynent.var_a548ec11 = gettime() + var_a852a7dd * 1000;
}

