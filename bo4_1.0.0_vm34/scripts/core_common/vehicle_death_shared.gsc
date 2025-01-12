#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;

#namespace vehicle_death;

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x2
// Checksum 0xe3d7da37, Offset: 0x218
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"vehicle_death", &__init__, undefined, undefined);
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x14d79f5c, Offset: 0x260
// Size: 0x2c
function __init__() {
    setdvar(#"debug_crash_type", -1);
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x3c6d7038, Offset: 0x298
// Size: 0x7b0
function main() {
    self endon(#"nodeath_thread");
    self endon(#"delete");
    while (isdefined(self)) {
        waitresult = self waittill(#"death");
        attacker = waitresult.attacker;
        weapon = waitresult.weapon;
        point = waitresult.position;
        dir = waitresult.direction;
        if (!isdefined(self.delete_on_death)) {
            self thread play_death_audio();
        }
        if (!isdefined(self)) {
            return;
        }
        if (self.var_68dfef06 === 1) {
            self.delete_on_death = undefined;
            self.var_ec65c629 = 1;
            self.var_96d1e818 = 1;
            self.no_free_on_death = 1;
        }
        self death_cleanup_level_variables();
        if (vehicle::is_corpse(self)) {
            if (!(isdefined(self.dont_kill_riders) && self.dont_kill_riders)) {
                self death_cleanup_riders();
            }
            self notify(#"delete_destructible");
            return;
        }
        self vehicle::lights_off();
        if (isdefined(level.vehicle_death_thread[self.vehicletype])) {
            self thread [[ level.vehicle_death_thread[self.vehicletype] ]](attacker, weapon);
        }
        if (self.var_96d1e818 === 1) {
            self setvehvelocity((0, 0, 0));
            self notsolid();
        }
        if (!isdefined(self.delete_on_death)) {
            thread death_radius_damage("MOD_EXPLOSIVE", attacker, weapon);
        }
        is_aircraft = self.vehicleclass === "plane" || self.vehicleclass === "helicopter";
        if (!isdefined(self.destructibledef)) {
            if (!is_aircraft && !(self.vehicletype == #"horse" || self.vehicletype == #"hash_7c266c6da28f71ea" || self.vehicletype == #"hash_13550c095facf5ef" || self.vehicletype == #"hash_1796360a8e43945b" || self.vehicletype == #"hash_2832290794e0e4e6") && isdefined(self.deathmodel) && self.deathmodel != "") {
                self thread set_death_model(self.deathmodel, self.modelswapdelay);
            }
            if (!(isdefined(self.delete_on_death) && self.delete_on_death) && (!isdefined(self.mantled) || !self.mantled) && !isdefined(self.nodeathfx)) {
                thread death_fx();
                self vehicle::do_death_dynents();
            }
            if (isdefined(self.delete_on_death) && self.delete_on_death) {
                waitframe(1);
                if (self.disconnectpathonstop === 1) {
                    self vehicle::disconnect_paths();
                }
                if (!(isdefined(self.no_free_on_death) && self.no_free_on_death)) {
                    self takeplayercontrol();
                    self freevehicle();
                    self.isacorpse = 1;
                    waitframe(1);
                    if (isdefined(self)) {
                        self notify(#"death_finished");
                        self delete();
                    }
                }
                continue;
            }
        }
        thread death_make_badplace(self.vehicletype);
        if (isdefined(level.vehicle_deathnotify) && isdefined(level.vehicle_deathnotify[self.vehicletype])) {
            level notify(level.vehicle_deathnotify[self.vehicletype], {#attacker:attacker});
        }
        if (target_istarget(self)) {
            target_remove(self);
        }
        if (self.classname == "script_vehicle") {
            self thread death_jolt(self.vehicletype);
        }
        if (do_scripted_crash()) {
            self thread death_update_crash(point, dir);
        }
        if (isdefined(self.turretweapon) && self.turretweapon != level.weaponnone) {
            self turretcleartarget(0);
        }
        self waittill_crash_done_or_stopped();
        if (isdefined(self)) {
            while (isdefined(self) && isdefined(self.dontfreeme)) {
                wait 0.05;
            }
            if (isdefined(self)) {
                self notify(#"stop_looping_death_fx");
                self notify(#"death_finished");
            }
            waitframe(1);
            if (isdefined(self)) {
                if (vehicle::is_corpse(self)) {
                    continue;
                }
                if (!isdefined(self)) {
                    continue;
                }
                occupants = self getvehoccupants();
                if (isdefined(occupants) && occupants.size) {
                    for (i = 0; i < occupants.size; i++) {
                        self usevehicle(occupants[i], 0);
                    }
                }
                if (!(isdefined(self.no_free_on_death) && self.no_free_on_death)) {
                    self freevehicle();
                    self.isacorpse = 1;
                }
                if (self.modeldummyon) {
                    self hide();
                }
                if (self.var_ec65c629 === 1) {
                    wait 5;
                    if (isdefined(self)) {
                        self delete();
                    }
                }
            }
        }
    }
}

/#

    // Namespace vehicle_death/vehicle_death_shared
    // Params 0, eflags: 0x0
    // Checksum 0xe8cfbd8b, Offset: 0xa50
    // Size: 0x56
    function function_ebe33d8c() {
        while (isdefined(self)) {
            util::debug_sphere(self.origin, 5, (0.9, 0, 0), 0.9, 300);
            waitframe(1);
        }
    }

#/

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0xe324257f, Offset: 0xab0
// Size: 0x2a
function do_scripted_crash() {
    return !isdefined(self.do_scripted_crash) || isdefined(self.do_scripted_crash) && self.do_scripted_crash;
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0xac0ba4a4, Offset: 0xae8
// Size: 0x54
function play_death_audio() {
    if (isdefined(self) && self.vehicleclass === "helicopter") {
        if (!isdefined(self.death_counter)) {
            self.death_counter = 0;
        }
        if (self.death_counter == 0) {
            self.death_counter++;
        }
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x38f8ca12, Offset: 0xb48
// Size: 0x94
function play_spinning_plane_sound() {
    self playloopsound(#"exp_veh_plane_spinout_lp", 0.05);
    level waittill(#"crash_move_done", #"death");
    self playsound(#"exp_veh_large");
    self stoploopsound(0.02);
}

// Namespace vehicle_death/vehicle_death_shared
// Params 2, eflags: 0x0
// Checksum 0x51534fc4, Offset: 0xbe8
// Size: 0x124
function set_death_model(smodel, fdelay) {
    if (!isdefined(smodel)) {
        return;
    }
    if (isdefined(fdelay) && fdelay > 0) {
        streamermodelhint(smodel, 5);
        wait fdelay;
    }
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.deathmodel_attached)) {
        return;
    }
    emodel = vehicle::get_dummy();
    if (!isdefined(emodel)) {
        return;
    }
    if (!isdefined(emodel.death_anim) && isdefined(emodel.animtree)) {
        emodel clearanim(#"root", 0);
    }
    if (smodel != self.vehmodel) {
        emodel setmodel(smodel);
        emodel setenemymodel(smodel);
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 2, eflags: 0x0
// Checksum 0x72c3e3d4, Offset: 0xd18
// Size: 0x84
function aircraft_crash(point, dir) {
    self.crashing = 1;
    if (isdefined(self.unloading)) {
        while (isdefined(self.unloading)) {
            waitframe(1);
        }
    }
    if (!isdefined(self)) {
        return;
    }
    self thread aircraft_crash_move(point, dir);
    self thread play_spinning_plane_sound();
}

// Namespace vehicle_death/vehicle_death_shared
// Params 2, eflags: 0x0
// Checksum 0xf20c0e33, Offset: 0xda8
// Size: 0x7c
function helicopter_crash(point, dir) {
    self.crashing = 1;
    self thread play_crashing_loop();
    if (isdefined(self.unloading)) {
        while (isdefined(self.unloading)) {
            waitframe(1);
        }
    }
    if (!isdefined(self)) {
        return;
    }
    self thread helicopter_crash_movement(point, dir);
}

// Namespace vehicle_death/vehicle_death_shared
// Params 2, eflags: 0x0
// Checksum 0x7be32520, Offset: 0xe30
// Size: 0x3e6
function helicopter_crash_movement(point, dir) {
    self endon(#"crash_done");
    self cancelaimove();
    self function_9f59031e();
    crash_zones = struct::get_array("heli_crash_zone", "targetname");
    if (crash_zones.size > 0) {
        best_dist = 99999;
        best_idx = -1;
        if (isdefined(self.a_crash_zones)) {
            crash_zones = self.a_crash_zones;
        }
        for (i = 0; i < crash_zones.size; i++) {
            vec_to_crash_zone = crash_zones[i].origin - self.origin;
            vec_to_crash_zone = (vec_to_crash_zone[0], vec_to_crash_zone[1], 0);
            dist = length(vec_to_crash_zone);
            vec_to_crash_zone /= dist;
            veloctiy_scale = vectordot(self.velocity, vec_to_crash_zone) * -1;
            dist += 500 * veloctiy_scale;
            if (dist < best_dist) {
                best_dist = dist;
                best_idx = i;
            }
        }
        if (best_idx != -1) {
            self.crash_zone = crash_zones[best_idx];
            self thread helicopter_crash_zone_accel(dir);
        }
    } else {
        mag = 100;
        if (isdefined(dir)) {
            dir = vectornormalize(dir);
        } else {
            dir = (1, 0, 0);
        }
        side_dir = vectorcross(dir, (0, 0, 1));
        side_dir_mag = randomfloatrange(mag * -1, mag);
        side_dir_mag += math::sign(side_dir_mag) * 60;
        side_dir *= side_dir_mag;
        side_dir += (0, 0, 0);
        self setphysacceleration((randomintrange(mag * -1, mag), randomintrange(mag * -1, mag), -500));
        vel = self.velocity + side_dir;
        self setvehvelocity((vel[0], vel[1], 0));
        self thread helicopter_crash_accel();
        if (isdefined(point)) {
            self thread helicopter_crash_rotation(point, dir);
        } else {
            self thread helicopter_crash_rotation(self.origin, dir);
        }
        self thread wait_and_explode();
    }
    self thread crash_collision_test();
    wait 15;
    if (isdefined(self)) {
        self notify(#"crash_done");
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x38dd34e8, Offset: 0x1220
// Size: 0xb8
function helicopter_crash_accel() {
    self endon(#"crash_done");
    self endon(#"crash_move_done");
    self endon(#"death");
    if (!isdefined(self.crash_accel)) {
        self.crash_accel = randomfloatrange(50, 80);
    }
    while (isdefined(self)) {
        self setvehvelocity(self.velocity + anglestoup(self.angles) * self.crash_accel);
        wait 0.1;
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 2, eflags: 0x0
// Checksum 0x5a7e150a, Offset: 0x12e0
// Size: 0x35e
function helicopter_crash_rotation(point, dir) {
    self endon(#"crash_done");
    self endon(#"crash_move_done");
    self endon(#"death");
    start_angles = self.angles;
    start_angles = (start_angles[0] + 10, start_angles[1], start_angles[2]);
    start_angles = (start_angles[0], start_angles[1], start_angles[2] + 10);
    ang_vel = self getangularvelocity();
    ang_vel = (0, ang_vel[1] * randomfloatrange(2, 3), 0);
    self setangularvelocity(ang_vel);
    point_2d = (point[0], point[1], self.origin[2]);
    torque = (0, randomintrange(90, 180), 0);
    if (self getangularvelocity()[1] < 0) {
        torque *= -1;
    }
    if (distance(self.origin, point_2d) > 5) {
        local_hit_point = point_2d - self.origin;
        dir_2d = (dir[0], dir[1], 0);
        if (length(dir_2d) > 0.01) {
            dir_2d = vectornormalize(dir_2d);
            torque = vectorcross(vectornormalize(local_hit_point), dir);
            torque = (0, 0, torque[2]);
            torque = vectornormalize(torque);
            torque = (0, torque[2] * 180, 0);
        }
    }
    while (true) {
        ang_vel = self getangularvelocity();
        ang_vel += torque * 0.05;
        if (ang_vel[1] < 360 * -1) {
            ang_vel = (ang_vel[0], 360 * -1, ang_vel[2]);
        } else if (ang_vel[1] > 360) {
            ang_vel = (ang_vel[0], 360, ang_vel[2]);
        }
        self setangularvelocity(ang_vel);
        waitframe(1);
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 1, eflags: 0x0
// Checksum 0x8250ced5, Offset: 0x1648
// Size: 0x5d8
function helicopter_crash_zone_accel(dir) {
    self endon(#"crash_done");
    self endon(#"crash_move_done");
    torque = (0, randomintrange(90, 150), 0);
    ang_vel = self getangularvelocity();
    torque *= math::sign(ang_vel[1]);
    /#
        if (isdefined(self.crash_zone.height)) {
            self.crash_zone.height = 0;
        }
    #/
    if (abs(self.angles[2]) < 3) {
        self.angles = (self.angles[0], self.angles[1], randomintrange(3, 6) * math::sign(self.angles[2]));
    }
    if (self.var_c1161e26) {
        torque *= 0.3;
    }
    while (isdefined(self)) {
        assert(isdefined(self.crash_zone));
        dist = distance2d(self.origin, self.crash_zone.origin);
        if (dist < self.crash_zone.radius) {
            self setphysacceleration((0, 0, -400));
            /#
                circle(self.crash_zone.origin + (0, 0, self.crash_zone.height), self.crash_zone.radius, (0, 1, 0), 0, 2000);
            #/
            self.crash_accel = 0;
        } else {
            self setphysacceleration((0, 0, -50));
            /#
                circle(self.crash_zone.origin + (0, 0, self.crash_zone.height), self.crash_zone.radius, (1, 0, 0), 0, 2);
            #/
        }
        self.crash_vel = self.crash_zone.origin - self.origin;
        self.crash_vel = (self.crash_vel[0], self.crash_vel[1], 0);
        self.crash_vel = vectornormalize(self.crash_vel);
        self.crash_vel *= self getmaxspeed() * 0.5;
        if (self.var_c1161e26) {
            self.crash_vel *= 0.5;
        }
        crash_vel_forward = anglestoup(self.angles) * self getmaxspeed() * 2;
        crash_vel_forward = (crash_vel_forward[0], crash_vel_forward[1], 0);
        self.crash_vel += crash_vel_forward;
        vel_x = difftrack(self.crash_vel[0], self.velocity[0], 1, 0.1);
        vel_y = difftrack(self.crash_vel[1], self.velocity[1], 1, 0.1);
        vel_z = difftrack(self.crash_vel[2], self.velocity[2], 1, 0.1);
        self setvehvelocity((vel_x, vel_y, vel_z));
        ang_vel = self getangularvelocity();
        ang_vel = (0, ang_vel[1], 0);
        ang_vel += torque * 0.1;
        max_angluar_vel = 200;
        if (self.var_c1161e26) {
            max_angluar_vel = 100;
        }
        if (ang_vel[1] < max_angluar_vel * -1) {
            ang_vel = (ang_vel[0], max_angluar_vel * -1, ang_vel[2]);
        } else if (ang_vel[1] > max_angluar_vel) {
            ang_vel = (ang_vel[0], max_angluar_vel, ang_vel[2]);
        }
        self setangularvelocity(ang_vel);
        wait 0.1;
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0xf16d0da0, Offset: 0x1c28
// Size: 0xea
function helicopter_collision() {
    self endon(#"crash_done");
    while (true) {
        waitresult = self waittill(#"veh_collision");
        normal = waitresult.normal;
        ang_vel = self getangularvelocity() * 0.5;
        self setangularvelocity(ang_vel);
        if (normal[2] < 0.7) {
            self setvehvelocity(self.velocity + normal * 70);
            continue;
        }
        self notify(#"crash_done");
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x4603065e, Offset: 0x1d20
// Size: 0xdc
function play_crashing_loop() {
    ent = spawn("script_origin", self.origin);
    ent function_7bc4044a(self);
    ent linkto(self);
    ent playloopsound(#"exp_veh_plane_spinout_lp");
    self waittill(#"death", #"snd_impact");
    ent playsound(#"exp_veh_large");
    ent delete();
}

// Namespace vehicle_death/vehicle_death_shared
// Params 1, eflags: 0x0
// Checksum 0x76a057c3, Offset: 0x1e08
// Size: 0xa4
function helicopter_explode(delete_me) {
    self endon(#"death");
    if (isdefined(self.destroyfunc)) {
        self [[ self.destroyfunc ]](1);
    }
    self vehicle::do_death_fx();
    if (isdefined(delete_me) && delete_me) {
        self delete();
    }
    self thread set_death_model(self.deathmodel, self.modelswapdelay);
}

// Namespace vehicle_death/vehicle_death_shared
// Params 2, eflags: 0x0
// Checksum 0xb1a84e53, Offset: 0x1eb8
// Size: 0x56e
function aircraft_crash_move(point, dir) {
    self endon(#"crash_move_done");
    self endon(#"death");
    self thread crash_collision_test();
    self function_9f59031e();
    self cancelaimove();
    self setrotorspeed(0.2);
    if (isdefined(self) && isdefined(self.vehicletype)) {
        b_custom_deathmodel_setup = 1;
        switch (self.vehicletype) {
        default:
            b_custom_deathmodel_setup = 0;
            break;
        }
        if (b_custom_deathmodel_setup) {
            self.deathmodel_attached = 1;
        }
    }
    ang_vel = self getangularvelocity();
    ang_vel = (0, 0, 0);
    self setangularvelocity(ang_vel);
    nodes = self getvehicleavoidancenodes(10000);
    closest_index = -1;
    best_dist = 999999;
    if (nodes.size > 0) {
        for (i = 0; i < nodes.size; i++) {
            dir = vectornormalize(nodes[i] - self.origin);
            forward = anglestoforward(self.angles);
            dot = vectordot(dir, forward);
            if (dot < 0) {
                continue;
            }
            dist = distance2d(self.origin, nodes[i]);
            if (dist < best_dist) {
                best_dist = dist;
                closest_index = i;
            }
        }
        if (closest_index >= 0) {
            o = nodes[closest_index];
            o = (o[0], o[1], self.origin[2]);
            dir = vectornormalize(o - self.origin);
            self setvehvelocity(self.velocity + dir * 2000);
        } else {
            self setvehvelocity(self.velocity + anglestoright(self.angles) * randomintrange(-1000, 1000) + (0, 0, randomintrange(0, 1500)));
        }
    } else {
        self setvehvelocity(self.velocity + anglestoright(self.angles) * randomintrange(-1000, 1000) + (0, 0, randomintrange(0, 1500)));
    }
    self thread delay_set_gravity(randomfloatrange(1.5, 3));
    torque = (0, randomintrange(-90, 90), randomintrange(90, 720));
    if (randomint(100) < 50) {
        torque = (torque[0], torque[1], torque[2] * -1);
    }
    while (isdefined(self)) {
        ang_vel = self getangularvelocity();
        ang_vel += torque * 0.05;
        if (ang_vel[2] < 500 * -1) {
            ang_vel = (ang_vel[0], ang_vel[1], 500 * -1);
        } else if (ang_vel[2] > 500) {
            ang_vel = (ang_vel[0], ang_vel[1], 500);
        }
        self setangularvelocity(ang_vel);
        waitframe(1);
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 1, eflags: 0x0
// Checksum 0xa6bf6b44, Offset: 0x2430
// Size: 0x7c
function delay_set_gravity(delay) {
    self endon(#"crash_move_done");
    self endon(#"death");
    wait delay;
    self setphysacceleration((randomintrange(-1600, 1600), randomintrange(-1600, 1600), -1600));
}

// Namespace vehicle_death/vehicle_death_shared
// Params 2, eflags: 0x0
// Checksum 0x840ec24e, Offset: 0x24b8
// Size: 0x356
function helicopter_crash_move(point, dir) {
    self endon(#"crash_move_done");
    self endon(#"death");
    self thread crash_collision_test();
    self cancelaimove();
    self function_9f59031e();
    self setturningability(0);
    self setphysacceleration((0, 0, -800));
    vel = self.velocity;
    dir = vectornormalize(dir);
    ang_vel = self getangularvelocity();
    ang_vel = (0, ang_vel[1] * randomfloatrange(1, 3), 0);
    self setangularvelocity(ang_vel);
    point_2d = (point[0], point[1], self.origin[2]);
    torque = (0, 720, 0);
    if (distance(self.origin, point_2d) > 5) {
        local_hit_point = point_2d - self.origin;
        dir_2d = (dir[0], dir[1], 0);
        if (length(dir_2d) > 0.01) {
            dir_2d = vectornormalize(dir_2d);
            torque = vectorcross(vectornormalize(local_hit_point), dir);
            torque = (0, 0, torque[2]);
            torque = vectornormalize(torque);
            torque = (0, torque[2] * 180, 0);
        }
    }
    while (true) {
        ang_vel = self getangularvelocity();
        ang_vel += torque * 0.05;
        if (ang_vel[1] < 360 * -1) {
            ang_vel = (ang_vel[0], 360 * -1, ang_vel[2]);
        } else if (ang_vel[1] > 360) {
            ang_vel = (ang_vel[0], 360, ang_vel[2]);
        }
        self setangularvelocity(ang_vel);
        waitframe(1);
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 2, eflags: 0x0
// Checksum 0x68cdbe64, Offset: 0x2818
// Size: 0x6c
function boat_crash(point, dir) {
    self.crashing = 1;
    if (isdefined(self.unloading)) {
        while (isdefined(self.unloading)) {
            waitframe(1);
        }
    }
    if (!isdefined(self)) {
        return;
    }
    self thread boat_crash_movement(point, dir);
}

// Namespace vehicle_death/vehicle_death_shared
// Params 2, eflags: 0x0
// Checksum 0xcd97072a, Offset: 0x2890
// Size: 0x2b6
function boat_crash_movement(point, dir) {
    self endon(#"crash_move_done");
    self endon(#"death");
    self cancelaimove();
    self function_9f59031e();
    self setphysacceleration((0, 0, -50));
    vel = self.velocity;
    dir = vectornormalize(dir);
    ang_vel = self getangularvelocity();
    ang_vel = (0, 0, 0);
    self setangularvelocity(ang_vel);
    torque = (randomintrange(-5, -3), 0, randomintrange(0, 100) > 50 ? 5 : -5);
    self thread boat_crash_monitor(point, dir, 4);
    while (true) {
        ang_vel = self getangularvelocity();
        ang_vel += torque * 0.05;
        if (ang_vel[1] < 360 * -1) {
            ang_vel = (ang_vel[0], 360 * -1, ang_vel[2]);
        } else if (ang_vel[1] > 360) {
            ang_vel = (ang_vel[0], 360, ang_vel[2]);
        }
        self setangularvelocity(ang_vel);
        velocity = self.velocity;
        velocity = (velocity[0] * 0.975, velocity[1], velocity[2]);
        velocity = (velocity[0], velocity[1] * 0.975, velocity[2]);
        self setvehvelocity(velocity);
        waitframe(1);
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 3, eflags: 0x0
// Checksum 0x8d09426, Offset: 0x2b50
// Size: 0x6e
function boat_crash_monitor(point, dir, crash_time) {
    self endon(#"death");
    wait crash_time;
    self notify(#"crash_move_done");
    self crash_stop();
    self notify(#"crash_done");
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0xe790ba3f, Offset: 0x2bc8
// Size: 0x19c
function crash_stop() {
    self endon(#"death");
    self setphysacceleration((0, 0, 0));
    self setrotorspeed(0);
    speed = self getspeedmph();
    while (speed > 2) {
        velocity = self.velocity;
        velocity *= 0.9;
        self setvehvelocity(velocity);
        angular_velocity = self getangularvelocity();
        angular_velocity *= 0.9;
        self setangularvelocity(angular_velocity);
        speed = self getspeedmph();
        waitframe(1);
    }
    self setvehvelocity((0, 0, 0));
    self setangularvelocity((0, 0, 0));
    self vehicle::toggle_tread_fx(0);
    self vehicle::toggle_exhaust_fx(0);
    self vehicle::toggle_sounds(0);
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0xb91f693f, Offset: 0x2d70
// Size: 0x154
function crash_collision_test() {
    self endon(#"death");
    waitresult = self waittill(#"veh_collision");
    normal = waitresult.normal;
    self helicopter_explode();
    self notify(#"crash_move_done");
    if (normal[2] > 0.7) {
        forward = anglestoforward(self.angles);
        right = vectorcross(normal, forward);
        desired_forward = vectorcross(right, normal);
        self setphysangles(vectortoangles(desired_forward));
        self crash_stop();
        self notify(#"crash_done");
        return;
    }
    waitframe(1);
    self delete();
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x4a962271, Offset: 0x2ed0
// Size: 0x34
function wait_and_explode() {
    self endon(#"death");
    wait 2;
    self helicopter_explode();
}

// Namespace vehicle_death/vehicle_death_shared
// Params 1, eflags: 0x0
// Checksum 0xf21953ae, Offset: 0x2f10
// Size: 0x1ac
function crash_path_check(node) {
    targ = node;
    for (search_depth = 5; isdefined(targ) && search_depth >= 0; search_depth--) {
        if (isdefined(targ.detoured) && targ.detoured == 0) {
            detourpath = vehicle::path_detour_get_detourpath(getvehiclenodearray(targ.target2, "targetname"));
            if (isdefined(detourpath) && isdefined(detourpath.script_crashtype)) {
                self.nd_crash_path = detourpath;
                return true;
            }
        }
        if (isdefined(targ.target)) {
            targ1 = getvehiclenode(targ.target, "targetname");
            if (isdefined(targ1) && isdefined(targ1.target) && isdefined(targ.targetname) && targ1.target == targ.targetname) {
                return false;
            } else if (isdefined(targ1) && targ1 == node) {
                return false;
            } else {
                targ = targ1;
            }
            continue;
        }
        targ = undefined;
    }
    return false;
}

// Namespace vehicle_death/vehicle_death_shared
// Params 1, eflags: 0x0
// Checksum 0xd215c61c, Offset: 0x30c8
// Size: 0x70
function death_firesound(sound) {
    self thread sound::loop_on_tag(sound, undefined, 0);
    self waittill(#"fire_extinguish", #"stop_crash_loop_sound");
    if (!isdefined(self)) {
        return;
    }
    self notify("stop sound" + sound);
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x9a5566fc, Offset: 0x3140
// Size: 0x6c
function death_fx() {
    if (self vehicle::is_destructible()) {
        return;
    }
    self util::explode_notify_wrapper();
    if (isdefined(self.do_death_fx)) {
        self [[ self.do_death_fx ]]();
        return;
    }
    self vehicle::do_death_fx();
}

// Namespace vehicle_death/vehicle_death_shared
// Params 1, eflags: 0x0
// Checksum 0x2ec4e229, Offset: 0x31b8
// Size: 0xa4
function death_make_badplace(type) {
    if (!isdefined(level.vehicle_death_badplace[type])) {
        return;
    }
    struct = level.vehicle_death_badplace[type];
    if (isdefined(struct.delay)) {
        wait struct.delay;
    }
    if (!isdefined(self)) {
        return;
    }
    badplace_box("vehicle_kill_badplace", struct.duration, self.origin, struct.radius, "all");
}

// Namespace vehicle_death/vehicle_death_shared
// Params 1, eflags: 0x0
// Checksum 0x43640208, Offset: 0x3268
// Size: 0x194
function death_jolt(type) {
    self endon(#"death");
    if (isdefined(self.ignore_death_jolt) && self.ignore_death_jolt) {
        return;
    }
    self joltbody(self.origin + (23, 33, 64), 3);
    if (isdefined(self.death_anim)) {
        self animscripted("death_anim", self.origin, self.angles, self.death_anim, "normal", "root", 1, 0);
        self waittillmatch({#notetrack:"end"}, #"death_anim");
        return;
    }
    if (self.isphysicsvehicle) {
        num_launch_multiplier = 1;
        if (isdefined(self.physicslaunchdeathscale)) {
            num_launch_multiplier = self.physicslaunchdeathscale;
        }
        self launchvehicle((0, 0, 180) * num_launch_multiplier, (randomfloatrange(5, 10), randomfloatrange(-5, 5), 0), 1, 0, 1);
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x17c9fb3a, Offset: 0x3408
// Size: 0x1e
function deathrollon() {
    if (self.health > 0) {
        self.rollingdeath = 1;
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x46b2a799, Offset: 0x3430
// Size: 0x1e
function deathrolloff() {
    self.rollingdeath = undefined;
    self notify(#"deathrolloff");
}

// Namespace vehicle_death/vehicle_death_shared
// Params 3, eflags: 0x0
// Checksum 0xa6d8ddfb, Offset: 0x3458
// Size: 0xae
function loop_fx_on_vehicle_tag(effect, looptime, tag) {
    assert(isdefined(effect));
    assert(isdefined(tag));
    assert(isdefined(looptime));
    self endon(#"stop_looping_death_fx");
    while (isdefined(self)) {
        playfxontag(effect, deathfx_ent(), tag);
        wait looptime;
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0xf3879c5b, Offset: 0x3510
// Size: 0x11a
function deathfx_ent() {
    if (!isdefined(self.deathfx_ent)) {
        ent = spawn("script_model", (0, 0, 0));
        emodel = vehicle::get_dummy();
        ent setmodel(self.model);
        ent.origin = emodel.origin;
        ent.angles = emodel.angles;
        ent notsolid();
        ent hide();
        ent linkto(emodel);
        self.deathfx_ent = ent;
    } else {
        self.deathfx_ent setmodel(self.model);
    }
    return self.deathfx_ent;
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x8528ec43, Offset: 0x3638
// Size: 0x124
function death_cleanup_level_variables() {
    script_linkname = self.script_linkname;
    targetname = self.targetname;
    if (isdefined(script_linkname)) {
        arrayremovevalue(level.vehicle_link[script_linkname], self);
    }
    if (isdefined(self.script_vehiclespawngroup)) {
        if (isdefined(level.vehicle_spawngroup[self.script_vehiclespawngroup])) {
            arrayremovevalue(level.vehicle_spawngroup[self.script_vehiclespawngroup], self);
            arrayremovevalue(level.vehicle_spawngroup[self.script_vehiclespawngroup], undefined);
        }
    }
    if (isdefined(self.script_vehiclestartmove)) {
        arrayremovevalue(level.vehicle_startmovegroup[self.script_vehiclestartmove], self);
    }
    if (isdefined(self.script_vehiclegroupdelete)) {
        arrayremovevalue(level.vehicle_deletegroup[self.script_vehiclegroupdelete], self);
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x9fc0364, Offset: 0x3768
// Size: 0x92
function death_cleanup_riders() {
    if (isdefined(self.riders)) {
        for (j = 0; j < self.riders.size; j++) {
            if (isdefined(self.riders[j])) {
                self.riders[j] delete();
            }
        }
    }
    if (vehicle::is_corpse(self)) {
        self.riders = [];
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 3, eflags: 0x0
// Checksum 0x4be3c0b2, Offset: 0x3808
// Size: 0x15c
function death_radius_damage(meansofdamage = "MOD_EXPLOSIVE", attacker, weapon) {
    self endon(#"death");
    if (!isdefined(self) || self.abandoned === 1 || self.damage_on_death === 0 || self.radiusdamageradius <= 0 || self.var_6ea9a111 === 1) {
        return;
    }
    position = self.origin + (0, 0, 15);
    radius = self.radiusdamageradius;
    damagemax = self.radiusdamagemax;
    damagemin = self.radiusdamagemin;
    if (!isdefined(attacker)) {
        attacker = self;
    }
    waitframe(1);
    if (isdefined(self) && !isdefined(self.var_6ea9a111)) {
        self.var_6ea9a111 = 1;
        self radiusdamage(position, radius, damagemax, damagemin, attacker, meansofdamage, weapon);
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 2, eflags: 0x0
// Checksum 0x66e6e8d9, Offset: 0x3970
// Size: 0x324
function death_update_crash(point, dir) {
    if (!isdefined(self.destructibledef)) {
        if (isdefined(self.script_crashtypeoverride)) {
            crashtype = self.script_crashtypeoverride;
            if (isdefined(self.currentnode)) {
                crash_path_check(self.currentnode);
            }
        } else if (self.vehicleclass === "plane") {
            crashtype = "aircraft";
        } else if (self.vehicleclass === "helicopter") {
            crashtype = "helicopter";
        } else if (self.vehicleclass === "boat") {
            crashtype = "boat";
        } else if (isdefined(self.currentnode) && crash_path_check(self.currentnode)) {
            crashtype = "none";
        } else {
            crashtype = "tank";
        }
        if (crashtype == "aircraft") {
            self thread aircraft_crash(point, dir);
            return;
        }
        if (crashtype == "helicopter") {
            if (isdefined(self.script_nocorpse)) {
                self thread helicopter_explode();
            } else {
                self thread helicopter_crash(point, dir);
            }
            return;
        }
        if (crashtype == "boat") {
            self thread boat_crash(point, dir);
            return;
        }
        if (crashtype == "tank") {
            if (!isdefined(self.rollingdeath)) {
                self vehicle::set_speed(0, 25, "Dead");
            } else {
                self waittill(#"deathrolloff");
                self vehicle::set_speed(0, 25, "Dead, finished path intersection");
            }
            wait 0.4;
            if (isdefined(self) && !vehicle::is_corpse(self)) {
                self vehicle::set_speed(0, 10000, "deadstop");
                self notify(#"deadstop");
                if (self.disconnectpathonstop === 1) {
                    self vehicle::disconnect_paths();
                }
                if (isdefined(self.tankgetout) && self.tankgetout > 0) {
                    self waittill(#"animsdone");
                }
            }
            return;
        }
        if (crashtype == "ground_vehicle_on_spline") {
            self thread ground_vehicle_crash();
        }
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x4f14ea67, Offset: 0x3ca0
// Size: 0x3f6
function ground_vehicle_crash() {
    self endon(#"crash_done");
    self endon(#"crash_move_done");
    self endon(#"death");
    self thread monitor_ground_vehicle_crash_collision();
    self.crashing = 1;
    n_current_speed = self getspeedmph();
    if (n_current_speed > 0 || isdefined(self.b_stopped_crash) && self.b_stopped_crash) {
        if (self is_crash_detour_nearby()) {
            self notify(#"crashpath", {#path:self.nd_crash_path});
            self.nd_crash_path.derailed = 1;
            self notify(#"newpath");
            nd_switch = self.currentnode get_switch_node(self.nd_crash_path);
            self setswitchnode(nd_switch, self.nd_crash_path);
            self thread watch_for_crash_detour_scene(self.nd_crash_path);
            if (n_current_speed == 0) {
                n_current_speed = 5;
                self setbrake(0);
                self vehicle::resume_path();
                self resumespeed(5);
            }
            n_set_speed = n_current_speed * 3;
            self setspeed(n_set_speed, n_set_speed / 2);
            self waittilltimeout(15, #"reached_end_node");
        } else {
            self vehicle::detach_path();
            if (math::cointoss()) {
                n_modifier = 1;
            } else {
                n_modifier = -1;
            }
            if (n_current_speed == 0) {
                n_current_speed = 5;
                self setbrake(0);
                self vehicle::resume_path();
                self resumespeed(5);
            }
            v_goal = self.origin + anglestoforward(self.angles + (0, n_modifier * 35, 0)) * 600;
            a_trace = physicstraceex(v_goal + (0, 0, 200), v_goal - (0, 0, 1000));
            n_set_speed = n_current_speed * 3;
            self setspeed(n_set_speed, n_set_speed / 2);
            self function_3c8dce03(a_trace[#"position"], 0);
            self waittilltimeout(15, #"near_goal");
            self vehicle_ai::clearallmovement(1);
            self vehicle_ai::clearalllookingandtargeting();
        }
    }
    self notify(#"crash_done");
}

// Namespace vehicle_death/vehicle_death_shared
// Params 1, eflags: 0x0
// Checksum 0x5ff471c3, Offset: 0x40a0
// Size: 0xf4
function get_switch_node(nd_crash_path) {
    nd_switch = self;
    for (n_search_depth = 5; isdefined(nd_switch) && n_search_depth >= 0; n_search_depth--) {
        if (isdefined(nd_switch.target2)) {
            a_nd_crash = getvehiclenodearray(nd_switch.target2, "targetname");
            if (isdefined(a_nd_crash) && isinarray(a_nd_crash, nd_crash_path)) {
                return nd_switch;
            }
        }
        if (isdefined(nd_switch.target)) {
            nd_switch = getvehiclenode(nd_switch.target, "targetname");
            continue;
        }
        nd_switch = undefined;
    }
    return self;
}

// Namespace vehicle_death/vehicle_death_shared
// Params 1, eflags: 0x0
// Checksum 0x481c2ec4, Offset: 0x41a0
// Size: 0x1be
function watch_for_crash_detour_scene(nd_crash_path) {
    self endon(#"delete");
    nd_current = nd_crash_path;
    while (isdefined(nd_current)) {
        if (isdefined(nd_current.target)) {
            nd_current = getvehiclenode(nd_current.target, "targetname");
            continue;
        }
        if (isdefined(nd_current.script_crashpath_scene)) {
            s_crash_scene = struct::get(nd_current.script_crashpath_scene, "script_crashpath_scene");
            nd_crash = nd_current;
            nd_current = undefined;
            continue;
        }
        return;
    }
    self.dontfreeme = 1;
    self thread vehicle_stopped_on_crashpath();
    str_result = self util::waittill_either("reached_end_node", "stopped_while_crashing");
    if (str_result === "stopped_while_crashing" && isdefined(nd_crash)) {
        /#
            iprintln("<dev string:x30>" + nd_crash.origin + "<dev string:x6a>");
        #/
    }
    if (isdefined(s_crash_scene) && isdefined(s_crash_scene.scriptbundlename)) {
        s_crash_scene scene::play(s_crash_scene.scriptbundlename, self);
    }
    self.dontfreeme = undefined;
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x6190db8d, Offset: 0x4368
// Size: 0x70
function vehicle_stopped_on_crashpath() {
    self endon(#"reached_end_node");
    while (isdefined(self) && isdefined(self.dontfreeme) && self.dontfreeme) {
        if (self getspeedmph() == 0) {
            self notify(#"stopped_while_crashing");
        }
        waitframe(1);
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0xb3de39a5, Offset: 0x43e0
// Size: 0xb0
function is_crash_detour_nearby() {
    if (isdefined(self.nd_crash_path)) {
        n_dist = distance(self.origin, self.nd_crash_path.origin);
        if (n_dist < 1000 && util::within_fov(self.origin, self.angles, self.nd_crash_path.origin, cos(90))) {
            return true;
        }
    }
    return false;
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0xa3e1b14a, Offset: 0x4498
// Size: 0x1c6
function monitor_ground_vehicle_crash_collision() {
    self endon(#"death");
    self endon(#"crash_done");
    waitresult = self thread ground_predicted_collision();
    waitresult = self waittill(#"veh_collision");
    normal = waitresult.normal;
    ent = waitresult.target;
    if (vehicle::is_corpse(ent)) {
        ent ground_vehicle_explode(1);
        return;
    }
    if (isvehicle(ent)) {
        self ground_vehicle_explode(1);
        return;
    }
    self ground_vehicle_explode();
    self notify(#"crash_move_done");
    forward = anglestoforward(self.angles);
    right = vectorcross(normal, forward);
    desired_forward = vectorcross(right, normal);
    self setphysangles(vectortoangles(desired_forward));
    self crash_stop();
    self notify(#"crash_done");
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x74a6b353, Offset: 0x4668
// Size: 0xc8
function ground_predicted_collision() {
    self endon(#"crash_done");
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"veh_predictedcollision");
        ent = waitresult.target;
        if (isdefined(ent) && self istouching(ent)) {
            self notify(#"veh_collision", waitresult);
            callback::callback(#"veh_collision", waitresult);
        }
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 1, eflags: 0x0
// Checksum 0xea83393b, Offset: 0x4738
// Size: 0x8c
function ground_vehicle_explode(b_delete_me = 0) {
    self endon(#"death");
    self vehicle::do_death_fx();
    if (b_delete_me) {
        self delete();
        return;
    }
    self thread set_death_model(self.deathmodel, self.modelswapdelay);
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x6a31211d, Offset: 0x47d0
// Size: 0x1b8
function waittill_crash_done_or_stopped() {
    self endon(#"death");
    if (isdefined(self) && (self.vehicleclass === "plane" || self.vehicleclass === "boat" || self.script_crashtypeoverride === "ground_vehicle_on_spline")) {
        if (isdefined(self.crashing) && self.crashing == 1) {
            self waittill(#"crash_done");
        }
        return;
    }
    wait 0.2;
    if (isdefined(self) && self.isphysicsvehicle) {
        self function_9f59031e();
        self cancelaimove();
        stable_count = 0;
        while (stable_count < 3) {
            if (self.var_dd8f3836 === 1) {
                break;
            }
            if (isdefined(self.velocity) && lengthsquared(self.velocity) > 1) {
                stable_count = 0;
            } else {
                stable_count++;
            }
            wait 0.3;
        }
        self vehicle::disconnect_paths();
        return;
    }
    while (isdefined(self) && self getspeedmph() > 0) {
        wait 0.3;
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 2, eflags: 0x0
// Checksum 0xa4ad43f4, Offset: 0x4990
// Size: 0x16e
function vehicle_damage_filter_damage_watcher(driver, heavy_damage_threshold) {
    self endon(#"death");
    self endon(#"exit_vehicle");
    self endon(#"end_damage_filter");
    if (!isdefined(heavy_damage_threshold)) {
        heavy_damage_threshold = 100;
    }
    while (true) {
        waitresult = self waittill(#"damage");
        earthquake(0.25, 0.15, self.origin, 512, self);
        driver playrumbleonentity("damage_light");
        time = gettime();
        if (time - level.n_last_damage_time > 500) {
            level.n_hud_damage = 1;
            if (waitresult.amount > heavy_damage_threshold) {
                driver playsound(#"veh_damage_filter_heavy");
            } else {
                driver playsound(#"veh_damage_filter_light");
            }
            level.n_last_damage_time = gettime();
        }
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 1, eflags: 0x0
// Checksum 0x47953297, Offset: 0x4b08
// Size: 0x42
function vehicle_damage_filter_exit_watcher(driver) {
    self waittill(#"exit_vehicle", #"death", #"end_damage_filter");
}

// Namespace vehicle_death/vehicle_death_shared
// Params 4, eflags: 0x0
// Checksum 0xcb0cc341, Offset: 0x4b58
// Size: 0x190
function vehicle_damage_filter(vision_set, heavy_damage_threshold, filterid = 0, b_use_player_damage = 0) {
    self endon(#"death");
    self endon(#"exit_vehicle");
    self endon(#"end_damage_filter");
    driver = self getseatoccupant(0);
    if (!isdefined(self.damage_filter_init)) {
        self.damage_filter_init = 1;
    }
    if (isdefined(vision_set)) {
    }
    level.n_hud_damage = 0;
    level.n_last_damage_time = gettime();
    damagee = isdefined(b_use_player_damage) && b_use_player_damage ? driver : self;
    damagee thread vehicle_damage_filter_damage_watcher(driver, heavy_damage_threshold);
    damagee thread vehicle_damage_filter_exit_watcher(driver);
    while (true) {
        if (isdefined(level.n_hud_damage) && level.n_hud_damage) {
            time = gettime();
            if (time - level.n_last_damage_time > 500) {
                level.n_hud_damage = 0;
            }
        }
        waitframe(1);
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 2, eflags: 0x0
// Checksum 0xc281e132, Offset: 0x4cf0
// Size: 0x1a4
function flipping_shooting_death(attacker, hitdir) {
    if (isdefined(self.delete_on_death)) {
        if (isdefined(self)) {
            self delete();
        }
        return;
    }
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self death_cleanup_level_variables();
    self disableaimassist();
    self death_fx();
    self thread death_radius_damage();
    self thread set_death_model(self.deathmodel, self.modelswapdelay);
    self vehicle::toggle_tread_fx(0);
    self vehicle::toggle_exhaust_fx(0);
    self vehicle::toggle_sounds(0);
    self vehicle::lights_off();
    self thread flipping_shooting_crash_movement(attacker, hitdir);
    self waittill(#"crash_done");
    while (isdefined(self.controlled) && self.controlled) {
        waitframe(1);
    }
    self delete();
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0xf07f3053, Offset: 0x4ea0
// Size: 0x26c
function plane_crash() {
    self endon(#"death");
    self setphysacceleration((0, 0, -1000));
    self.vehcheckforpredictedcrash = 1;
    forward = anglestoforward(self.angles);
    forward_mag = randomfloatrange(0, 300);
    forward_mag += math::sign(forward_mag) * 400;
    forward *= forward_mag;
    new_vel = forward + self.velocity * 0.2;
    ang_vel = self getangularvelocity();
    yaw_vel = randomfloatrange(0, 130) * math::sign(ang_vel[1]);
    yaw_vel += math::sign(yaw_vel) * 20;
    ang_vel = (randomfloatrange(-1, 1), yaw_vel, 0);
    roll_amount = abs(ang_vel[1]) / 150 * 30;
    if (ang_vel[1] > 0) {
        roll_amount *= -1;
    }
    self.angles = (self.angles[0], self.angles[1], roll_amount);
    ang_vel = (ang_vel[0], ang_vel[1], roll_amount * 0.9);
    self.velocity_rotation_frac = 1;
    self.crash_accel = randomfloatrange(65, 90);
    set_movement_and_accel(new_vel, ang_vel);
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0xb5a00b40, Offset: 0x5118
// Size: 0x234
function barrel_rolling_crash() {
    self endon(#"death");
    self setphysacceleration((0, 0, -1000));
    self.vehcheckforpredictedcrash = 1;
    forward = anglestoforward(self.angles);
    forward_mag = randomfloatrange(0, 250);
    forward_mag += math::sign(forward_mag) * 300;
    forward *= forward_mag;
    new_vel = forward + (0, 0, 70);
    ang_vel = self getangularvelocity();
    yaw_vel = randomfloatrange(0, 60) * math::sign(ang_vel[1]);
    yaw_vel += math::sign(yaw_vel) * 30;
    roll_vel = randomfloatrange(-200, 200);
    roll_vel += math::sign(roll_vel) * 300;
    ang_vel = (randomfloatrange(-5, 5), yaw_vel, roll_vel);
    self.velocity_rotation_frac = 1;
    self.crash_accel = randomfloatrange(145, 210);
    self setphysacceleration((0, 0, -250));
    set_movement_and_accel(new_vel, ang_vel);
}

// Namespace vehicle_death/vehicle_death_shared
// Params 1, eflags: 0x0
// Checksum 0x3c83d3ea, Offset: 0x5358
// Size: 0x2f4
function random_crash(hitdir) {
    self endon(#"death");
    self setphysacceleration((0, 0, -1000));
    self.vehcheckforpredictedcrash = 1;
    if (!isdefined(hitdir)) {
        hitdir = (1, 0, 0);
    }
    hitdir = vectornormalize(hitdir);
    side_dir = vectorcross(hitdir, (0, 0, 1));
    side_dir_mag = randomfloatrange(-280, 280);
    side_dir_mag += math::sign(side_dir_mag) * 150;
    side_dir *= side_dir_mag;
    forward = anglestoforward(self.angles);
    forward_mag = randomfloatrange(0, 300);
    forward_mag += math::sign(forward_mag) * 30;
    forward *= forward_mag;
    new_vel = self.velocity * 1.2 + forward + side_dir + (0, 0, 50);
    ang_vel = self getangularvelocity();
    ang_vel = (ang_vel[0] * 0.3, ang_vel[1], ang_vel[2] * 1.2);
    yaw_vel = randomfloatrange(0, 130) * math::sign(ang_vel[1]);
    yaw_vel += math::sign(yaw_vel) * 50;
    ang_vel += (randomfloatrange(-5, 5), yaw_vel, randomfloatrange(-18, 18));
    self.velocity_rotation_frac = randomfloatrange(0.3, 0.99);
    self.crash_accel = randomfloatrange(65, 90);
    set_movement_and_accel(new_vel, ang_vel);
}

// Namespace vehicle_death/vehicle_death_shared
// Params 2, eflags: 0x0
// Checksum 0x46d93b5a, Offset: 0x5658
// Size: 0x216
function set_movement_and_accel(new_vel, ang_vel) {
    self death_fx();
    self thread death_radius_damage();
    self setvehvelocity(new_vel);
    self setangularvelocity(ang_vel);
    if (!isdefined(self.off)) {
        self thread flipping_shooting_crash_accel();
    }
    self thread vehicle_ai::nudge_collision();
    self playsound(#"veh_wasp_dmg_hit");
    self vehicle::toggle_sounds(0);
    if (!isdefined(self.off)) {
        self thread flipping_shooting_dmg_snd();
    }
    wait 0.1;
    if (randomint(100) < 40 && !isdefined(self.off) && self.variant !== "rocket") {
        self thread vehicle_ai::fire_for_time(randomfloatrange(0.7, 2));
    }
    result = self waittilltimeout(15, #"crash_done");
    if (result._notify === "crash_done") {
        self vehicle::do_death_dynents();
        self set_death_model(self.deathmodel, self.modelswapdelay);
        return;
    }
    self notify(#"crash_done");
}

// Namespace vehicle_death/vehicle_death_shared
// Params 2, eflags: 0x0
// Checksum 0x2729bf84, Offset: 0x5878
// Size: 0x1c2
function flipping_shooting_crash_movement(attacker, hitdir) {
    self endon(#"crash_done");
    self endon(#"death");
    self cancelaimove();
    self function_9f59031e();
    self vehclearlookat();
    self setphysacceleration((0, 0, -1000));
    self.vehcheckforpredictedcrash = 1;
    if (!isdefined(hitdir)) {
        hitdir = (1, 0, 0);
    }
    hitdir = vectornormalize(hitdir);
    new_vel = self.velocity;
    self.crash_style = getdvarint(#"debug_crash_type", 0);
    if (self.crash_style == -1) {
        self.crash_style = randomint(3);
    }
    switch (self.crash_style) {
    case 0:
        barrel_rolling_crash();
        break;
    case 1:
        plane_crash();
        break;
    default:
        random_crash(hitdir);
        break;
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x99a2ed1b, Offset: 0x5a48
// Size: 0xbc
function flipping_shooting_dmg_snd() {
    dmg_ent = spawn("script_origin", self.origin);
    dmg_ent linkto(self);
    dmg_ent playloopsound(#"veh_wasp_dmg_loop");
    self waittill(#"crash_done", #"death");
    dmg_ent stoploopsound(1);
    wait 2;
    dmg_ent delete();
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0xd10f2661, Offset: 0x5b10
// Size: 0x306
function flipping_shooting_crash_accel() {
    self endon(#"crash_done");
    self endon(#"death");
    count = 0;
    prev_forward = anglestoforward(self.angles);
    prev_forward_vel = vectordot(self.velocity, prev_forward) * self.velocity_rotation_frac;
    if (prev_forward_vel < 0) {
        prev_forward_vel = 0;
    }
    while (true) {
        self setvehvelocity(self.velocity + anglestoup(self.angles) * self.crash_accel);
        self.crash_accel *= 0.98;
        new_velocity = self.velocity;
        new_velocity -= prev_forward * prev_forward_vel;
        forward = anglestoforward(self.angles);
        new_velocity += forward * prev_forward_vel;
        prev_forward = forward;
        prev_forward_vel = vectordot(new_velocity, prev_forward) * self.velocity_rotation_frac;
        if (prev_forward_vel < 10) {
            new_velocity += forward * 40;
            prev_forward_vel = 0;
        }
        self setvehvelocity(new_velocity);
        wait 0.1;
        count++;
        if (count % 8 == 0 && randomint(100) > 40) {
            if (self.velocity[2] > 130) {
                self.crash_accel *= 0.75;
                continue;
            }
            if (self.velocity[2] < 40 && count < 60) {
                if (abs(self.angles[0]) > 35 || abs(self.angles[2]) > 35) {
                    self.crash_accel = randomfloatrange(100, 150);
                    continue;
                }
                self.crash_accel = randomfloatrange(45, 70);
            }
        }
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x826fd40f, Offset: 0x5e20
// Size: 0x8c
function death_fire_loop_audio() {
    sound_ent = spawn("script_origin", self.origin);
    sound_ent playloopsound(#"veh_qrdrone_death_fire_loop", 0.1);
    wait 11;
    sound_ent stoploopsound(1);
    sound_ent delete();
}

// Namespace vehicle_death/vehicle_death_shared
// Params 1, eflags: 0x0
// Checksum 0xd47c2e98, Offset: 0x5eb8
// Size: 0x34
function freewhensafe(time = 4) {
    self thread delayedremove_thread(time, 0);
}

// Namespace vehicle_death/vehicle_death_shared
// Params 1, eflags: 0x0
// Checksum 0x1de5c284, Offset: 0x5ef8
// Size: 0x3c
function deletewhensafe(time = 4) {
    self thread delayedremove_thread(time, 1);
}

// Namespace vehicle_death/vehicle_death_shared
// Params 2, eflags: 0x0
// Checksum 0x88918cef, Offset: 0x5f40
// Size: 0x152
function delayedremove_thread(time, shoulddelete) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self endon(#"free_vehicle");
    if (shoulddelete === 1) {
        if (isvehicle(self)) {
            self setvehvelocity((0, 0, 0));
        }
        if (!(isdefined(self.var_7e426dd) && self.var_7e426dd)) {
            self ghost();
        }
        self notsolid();
    }
    util::waitfortimeandnetworkframe(time);
    if (shoulddelete === 1) {
        self delete();
        return;
    }
    if (!(isdefined(self.no_free_on_death) && self.no_free_on_death)) {
        self thread cleanup();
        self freevehicle();
        self.isacorpse = 1;
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x5aa45773, Offset: 0x60a0
// Size: 0x34
function cleanup() {
    if (isdefined(self.cleanup_after_time)) {
        wait self.cleanup_after_time;
        if (isdefined(self)) {
            self delete();
        }
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x5616d5da, Offset: 0x60e0
// Size: 0xa4
function corpse_explode_fx() {
    if (!isdefined(self.settings)) {
        return;
    }
    if (isdefined(self.settings.var_173f0d21) && isdefined(self.settings.var_5356f2b1)) {
        playfxontag(self.settings.var_173f0d21, self, self.settings.var_5356f2b1);
    }
    if (isdefined(self.settings.var_206a1354)) {
        self playsound(self.settings.var_206a1354);
    }
}

// Namespace vehicle_death/vehicle_death_shared
// Params 0, eflags: 0x0
// Checksum 0x2f9c9b39, Offset: 0x6190
// Size: 0x1a0
function function_68eede77() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill(#"veh_predictedcollision");
        if (isdefined(waitresult.target)) {
            vehiclecorpse = waitresult.target;
            if (!vehicle::is_corpse(vehiclecorpse) || isdefined(vehiclecorpse.var_210bd762) && vehiclecorpse.var_210bd762) {
                continue;
            }
            if (!isdefined(vehiclecorpse.settings) || !(isdefined(vehiclecorpse.settings.var_17cef9f5) && vehiclecorpse.settings.var_17cef9f5)) {
                continue;
            }
            speed = self getspeed();
            maxspeed = self getmaxspeed();
            if (speed / maxspeed < 0.75) {
                continue;
            }
            vehiclecorpse.var_210bd762 = 1;
            vehiclecorpse corpse_explode_fx();
            vehiclecorpse vehicle::do_death_dynents();
            vehiclecorpse deletewhensafe();
        }
    }
}

