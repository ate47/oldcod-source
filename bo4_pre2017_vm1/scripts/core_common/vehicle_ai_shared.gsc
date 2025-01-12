#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/array_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/sound_shared;
#using scripts/core_common/statemachine_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/turret_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;
#using scripts/core_common/vehicle_death_shared;
#using scripts/core_common/vehicle_shared;

#namespace vehicle_ai;

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x2
// Checksum 0x238898aa, Offset: 0x590
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("vehicle_ai", &__init__, undefined, undefined);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x5d0
// Size: 0x4
function __init__() {
    
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0x5342478e, Offset: 0x5e0
// Size: 0xbc
function entityisarchetype(entity, archetype) {
    if (!isdefined(entity)) {
        return false;
    }
    if (isplayer(entity) && entity.usingvehicle && isdefined(entity.viewlockedentity) && entity.viewlockedentity.archetype === archetype) {
        return true;
    }
    if (isvehicle(entity) && entity.archetype === archetype) {
        return true;
    }
    return false;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0xd2bcdf33, Offset: 0x6a8
// Size: 0x62
function getenemytarget() {
    if (isdefined(self.enemy) && self cansee(self.enemy)) {
        return self.enemy;
    } else if (isdefined(self.enemylastseenpos)) {
        return self.enemylastseenpos;
    }
    return undefined;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0x5c752cfd, Offset: 0x718
// Size: 0x114
function gettargetpos(target, geteye) {
    pos = undefined;
    if (isdefined(target)) {
        if (isvec(target)) {
            pos = target;
        } else if (isdefined(geteye) && geteye && issentient(target)) {
            pos = target geteye();
        } else if (isentity(target)) {
            pos = target.origin;
        } else if (isdefined(target.origin) && isvec(target.origin)) {
            pos = target.origin;
        }
    }
    return pos;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0xa745962b, Offset: 0x838
// Size: 0x6a
function gettargeteyeoffset(target) {
    offset = (0, 0, 0);
    if (isdefined(target) && issentient(target)) {
        offset = target geteye() - target.origin;
    }
    return offset;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 4, eflags: 0x0
// Checksum 0x541d4e5, Offset: 0x8b0
// Size: 0x1cc
function fire_for_time(totalfiretime, turretidx, target, intervalscale) {
    if (!isdefined(intervalscale)) {
        intervalscale = 1;
    }
    self endon(#"death");
    self endon(#"change_state");
    if (!isdefined(turretidx)) {
        turretidx = 0;
    }
    self notify("fire_stop" + turretidx);
    self endon("fire_stop" + turretidx);
    weapon = self seatgetweapon(turretidx);
    if (!isdefined(weapon) || weapon.name == "none" || weapon.firetime <= 0) {
        println("<dev string:x28>" + turretidx + "<dev string:x4d>" + self getentnum() + "<dev string:x5a>" + self.model);
        return;
    }
    firetime = weapon.firetime * intervalscale;
    firecount = int(floor(totalfiretime / firetime)) + 1;
    __fire_for_rounds_internal(firecount, firetime, turretidx, target);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 3, eflags: 0x0
// Checksum 0xa5bc8ade, Offset: 0xa88
// Size: 0x13c
function fire_for_rounds(firecount, turretidx, target) {
    self endon(#"death");
    self endon(#"fire_stop");
    self endon(#"change_state");
    if (!isdefined(turretidx)) {
        turretidx = 0;
    }
    weapon = self seatgetweapon(turretidx);
    if (!isdefined(weapon) || weapon.name == "none" || weapon.firetime <= 0) {
        println("<dev string:x28>" + turretidx + "<dev string:x4d>" + self getentnum() + "<dev string:x5a>" + self.model);
        return;
    }
    __fire_for_rounds_internal(firecount, weapon.firetime, turretidx, target);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 4, eflags: 0x0
// Checksum 0x88839039, Offset: 0xbd0
// Size: 0x224
function __fire_for_rounds_internal(firecount, fireinterval, turretidx, target) {
    self endon(#"death");
    self endon(#"fire_stop");
    self endon(#"change_state");
    if (isdefined(target) && issentient(target)) {
        target endon(#"death");
    }
    assert(isdefined(turretidx));
    aifirechance = 1;
    if (isdefined(target) && !isplayer(target) && isai(target) || isdefined(self.fire_half_blanks)) {
        aifirechance = 2;
    }
    counter = 0;
    while (counter < firecount) {
        if (self.avoid_shooting_owner === 1 && self owner_in_line_of_fire()) {
            wait fireinterval;
            continue;
        }
        if (isdefined(target) && !isvec(target) && isdefined(target.attackeraccuracy) && target.attackeraccuracy == 0) {
            self fireturret(turretidx, 1);
        } else if (aifirechance > 1) {
            self fireturret(turretidx, counter % aifirechance);
        } else {
            self fireturret(turretidx);
        }
        counter++;
        wait fireinterval;
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0xb3245962, Offset: 0xe00
// Size: 0x142
function owner_in_line_of_fire() {
    if (!isdefined(self.owner)) {
        return false;
    }
    dist_squared_to_owner = distancesquared(self.owner.origin, self.origin);
    line_of_fire_dot = dist_squared_to_owner < 9216 ? 0.866 : 0.9848;
    gun_angles = self gettagangles(isdefined(self.avoid_shooting_owner_ref_tag) ? self.avoid_shooting_owner_ref_tag : "tag_flash");
    gun_forward = anglestoforward(gun_angles);
    dot = vectordot(gun_forward, vectornormalize(self.owner.origin - self.origin));
    return dot > line_of_fire_dot;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 3, eflags: 0x0
// Checksum 0xb7a16b19, Offset: 0xf50
// Size: 0x64
function setturrettarget(target, turretidx, offset) {
    if (!isdefined(turretidx)) {
        turretidx = 0;
    }
    if (!isdefined(offset)) {
        offset = (0, 0, 0);
    }
    self turretsettarget(turretidx, target, offset);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0x5118522b, Offset: 0xfc0
// Size: 0x34
function fireturret(turretidx, isfake) {
    self fireweapon(turretidx, undefined, undefined, self);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x5ca97e55, Offset: 0x1000
// Size: 0x13a
function airfollow(target) {
    assert(isairborne(self));
    if (!isdefined(target)) {
        return;
    }
    if (isdefined(self.host)) {
        arrayremovevalue(self.host.airfollowers, self);
    }
    self.host = target;
    if (!isdefined(target.airfollowers)) {
        target.airfollowers = [];
    }
    if (!isdefined(target.airfollowers)) {
        target.airfollowers = [];
    } else if (!isarray(target.airfollowers)) {
        target.airfollowers = array(target.airfollowers);
    }
    target.airfollowers[target.airfollowers.size] = self;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0x47c7d57e, Offset: 0x1148
// Size: 0xa0
function getairfollowindex() {
    assert(isairborne(self));
    if (!isdefined(self.host)) {
        return undefined;
    }
    for (i = 0; i < self.host.airfollowers.size; i++) {
        if (self === self.host.airfollowers[i]) {
            return i;
        }
    }
    return undefined;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0xd25ce0fc, Offset: 0x11f0
// Size: 0x202
function getairfollowingposition(userelativeangletohost) {
    assert(isairborne(self));
    index = self getairfollowindex();
    if (!isdefined(index)) {
        return undefined;
    }
    offset = getairfollowingoffset(self.host, index);
    if (!isdefined(offset)) {
        return undefined;
    }
    origin = getairfollowingorigin();
    if (!userelativeangletohost) {
        return (origin + offset);
    }
    angles = undefined;
    if (isdefined(self.host.airfollowconfig) && self.host.airfollowconfig.tag !== "") {
        angles = self.host gettagangles(self.host.airfollowconfig.tag);
    } else if (isplayer(self.host)) {
        angles = self.host getplayerangles();
    } else {
        angles = self.host.angles;
    }
    yawangles = (0, angles[1], 0);
    newoffset = rotatepoint(offset, yawangles);
    return origin + newoffset;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0xd2cad2f7, Offset: 0x1400
// Size: 0xec
function getairfollowingorigin() {
    assert(isairborne(self));
    origin = self.host.origin + self.host.mins + self.host.maxs;
    if (isdefined(self.host.airfollowconfig) && self.host.airfollowconfig.tag !== "") {
        origin = self.host gettagorigin(self.host.airfollowconfig.tag);
    }
    return origin;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x351e72b9, Offset: 0x14f8
// Size: 0xd6
function getairfollowinglength(targetent) {
    distance = undefined;
    if (isdefined(targetent) && isdefined(targetent.airfollowconfig)) {
        distance = targetent.airfollowconfig.distance;
    } else {
        size = self.host.maxs - self.host.mins;
        distance = 0.5 * length(size);
        distance = 0.5 * (distance + size[2]);
    }
    return distance;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0xcecd3687, Offset: 0x15d8
// Size: 0xfa
function getairfollowingoffset(targetent, index) {
    numberofpoints = 8;
    pitchrange = 90;
    if (isdefined(targetent) && isdefined(targetent.airfollowconfig)) {
        numberofpoints = targetent.airfollowconfig.numberofpoints;
        pitchrange = targetent.airfollowconfig.pitchrange;
    }
    distance = getairfollowinglength(targetent);
    if (index >= numberofpoints) {
        return undefined;
    }
    dir = math::point_on_sphere_even_distribution(pitchrange, index, numberofpoints);
    return dir * distance;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0xafda665, Offset: 0x16e0
// Size: 0x15a
function javelin_losetargetatrighttime(target, gunnerindex) {
    self endon(#"death");
    if (isdefined(gunnerindex)) {
        firedgunnerindex = -1;
        while (firedgunnerindex != gunnerindex) {
            waitresult = self waittill("gunner_weapon_fired");
            firedgunnerindex = waitresult.gunner_index;
            projarray = waitresult.projectile;
        }
    } else {
        waitresult = self waittill("weapon_fired");
        projarray = waitresult.projectile;
    }
    if (!isdefined(projarray)) {
        return;
    }
    foreach (proj in projarray) {
        self thread javelin_losetargetatrighttimeprojectile(proj, target);
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0x7df74b8, Offset: 0x1848
// Size: 0x134
function javelin_losetargetatrighttimeprojectile(proj, target) {
    self endon(#"death");
    proj endon(#"death");
    wait 2;
    sound_played = undefined;
    while (isdefined(target)) {
        if (proj getvelocity()[2] < -150) {
            distsq = distancesquared(proj.origin, target.origin);
            if (!isdefined(sound_played) && distsq <= 1400 * 1400) {
                proj playsound("prj_quadtank_javelin_incoming");
                sound_played = 1;
            }
            if (distsq < 1200 * 1200) {
                proj missile_settarget(undefined);
                break;
            }
        }
        wait 0.1;
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x748f313d, Offset: 0x1988
// Size: 0x5e
function waittill_pathing_done(maxtime) {
    if (!isdefined(maxtime)) {
        maxtime = 15;
    }
    self endon(#"change_state");
    self waittilltimeout(maxtime, "near_goal", "force_goal", "reached_end_node", "goal", "pathfind_failed");
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0xd7b22c81, Offset: 0x19f0
// Size: 0x7e
function waittill_pathresult(maxtime) {
    if (!isdefined(maxtime)) {
        maxtime = 0.5;
    }
    self endon(#"change_state");
    result = self waittilltimeout(maxtime, "pathfind_failed", "pathfind_succeeded", "change_state");
    succeeded = result === "pathfind_succeeded";
    return succeeded;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0x8231c0e5, Offset: 0x1a78
// Size: 0x5a
function waittill_asm_terminated() {
    self endon(#"death");
    self notify(#"end_asm_terminated_thread");
    self endon(#"end_asm_terminated_thread");
    self waittill("asm_terminated");
    self notify(#"asm_complete", {#substate:"__terminated__"});
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x930ca436, Offset: 0x1ae0
// Size: 0x5a
function waittill_asm_timeout(timeout) {
    self endon(#"death");
    self notify(#"end_asm_timeout_thread");
    self endon(#"end_asm_timeout_thread");
    wait timeout;
    self notify(#"asm_complete", {#substate:"__timeout__"});
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0xec6ade7d, Offset: 0x1b48
// Size: 0xfa
function waittill_asm_complete(substate_to_wait, timeout) {
    if (!isdefined(timeout)) {
        timeout = 10;
    }
    self endon(#"death");
    self thread waittill_asm_terminated();
    self thread waittill_asm_timeout(timeout);
    for (substate = undefined; substate != substate_to_wait && substate != "__terminated__" && (!isdefined(substate) || substate != "__timeout__"); substate = waitresult.substate) {
        waitresult = self waittill("asm_complete");
    }
    self notify(#"end_asm_terminated_thread");
    self notify(#"end_asm_timeout_thread");
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 4, eflags: 0x0
// Checksum 0x50f40975, Offset: 0x1c50
// Size: 0x1e4
function throw_off_balance(damagetype, hitpoint, hitdirection, hitlocationinfo) {
    if (damagetype == "MOD_EXPLOSIVE" || damagetype == "MOD_GRENADE_SPLASH" || damagetype == "MOD_PROJECTILE_SPLASH") {
        self setvehvelocity(self.velocity + vectornormalize(hitdirection) * 300);
        ang_vel = self getangularvelocity();
        ang_vel += (randomfloatrange(-300, 300), randomfloatrange(-300, 300), randomfloatrange(-300, 300));
        self setangularvelocity(ang_vel);
        return;
    }
    ang_vel = self getangularvelocity();
    yaw_vel = randomfloatrange(-320, 320);
    yaw_vel += math::sign(yaw_vel) * 150;
    ang_vel += (randomfloatrange(-150, 150), yaw_vel, randomfloatrange(-150, 150));
    self setangularvelocity(ang_vel);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0x79f63525, Offset: 0x1e40
// Size: 0x72
function predicted_collision() {
    self endon(#"crash_done");
    self endon(#"death");
    while (true) {
        waitresult = self waittill("veh_predictedcollision");
        if (waitresult.normal[2] >= 0.6) {
            self notify(#"veh_collision", waitresult);
        }
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x488985f8, Offset: 0x1ec0
// Size: 0x7c
function collision_fx(normal) {
    tilted = normal[2] < 0.6;
    fx_origin = self.origin - normal * (tilted ? 28 : 10);
    self playsound("veh_wasp_wall_imp");
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0xfef154da, Offset: 0x1f48
// Size: 0x41e
function nudge_collision() {
    self endon(#"crash_done");
    self endon(#"power_off_done");
    self endon(#"death");
    self notify(#"end_nudge_collision");
    self endon(#"end_nudge_collision");
    if (self.notsolid === 1) {
        return;
    }
    while (true) {
        waitresult = self waittill("veh_collision");
        velocity = waitresult.velocity;
        normal = waitresult.normal;
        ang_vel = self getangularvelocity() * 0.5;
        self setangularvelocity(ang_vel);
        empedoroff = self get_current_state() === "emped" || self get_current_state() === "off";
        if (normal[2] < 0.6 || isalive(self) && !empedoroff) {
            self setvehvelocity(self.velocity + normal * 90);
            self collision_fx(normal);
            continue;
        }
        if (empedoroff) {
            if (isdefined(self.bounced)) {
                self playsound("veh_wasp_wall_imp");
                self setvehvelocity((0, 0, 0));
                self setangularvelocity((0, 0, 0));
                pitch = self.angles[0];
                pitch = math::sign(pitch) * math::clamp(abs(pitch), 10, 15);
                self.angles = (pitch, self.angles[1], self.angles[2]);
                self.bounced = undefined;
                self notify(#"landed");
                return;
            } else {
                self.bounced = 1;
                self setvehvelocity(self.velocity + normal * 30);
                self collision_fx(normal);
            }
            continue;
        }
        impact_vel = abs(vectordot(velocity, normal));
        if (normal[2] < 0.6 && impact_vel < 100) {
            self setvehvelocity(self.velocity + normal * 90);
            self collision_fx(normal);
            continue;
        }
        self playsound("veh_wasp_ground_death");
        self thread vehicle_death::death_fire_loop_audio();
        self notify(#"crash_done");
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0x5ad8f4df, Offset: 0x2370
// Size: 0x106
function level_out_for_landing() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"landed");
    while (true) {
        velocity = self.velocity;
        self.angles = (self.angles[0] * 0.85, self.angles[1], self.angles[2] * 0.85);
        ang_vel = self getangularvelocity() * 0.85;
        self setangularvelocity(ang_vel);
        self setvehvelocity(velocity + (0, 0, -60));
        waitframe(1);
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x718f0320, Offset: 0x2480
// Size: 0x34
function immolate(attacker) {
    self endon(#"death");
    self thread burning_thread(attacker, attacker);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0x4b50e6ae, Offset: 0x24c0
// Size: 0x2cc
function burning_thread(attacker, inflictor) {
    self endon(#"death");
    self notify(#"end_immolating_thread");
    self endon(#"end_immolating_thread");
    damagepersecond = self.settings.burn_damagepersecond;
    if (!isdefined(damagepersecond) || damagepersecond <= 0) {
        return;
    }
    secondsperonedamage = 1 / float(damagepersecond);
    if (!isdefined(self.abnormal_status)) {
        self.abnormal_status = spawnstruct();
    }
    if (self.abnormal_status.burning !== 1) {
        self vehicle::toggle_burn_fx(1);
    }
    self.abnormal_status.burning = 1;
    self.abnormal_status.attacker = attacker;
    self.abnormal_status.inflictor = inflictor;
    lastingtime = self.settings.burn_lastingtime;
    if (!isdefined(lastingtime)) {
        lastingtime = 999999;
    }
    starttime = gettime();
    interval = max(secondsperonedamage, 0.5);
    for (damage = 0; timesince(starttime) < lastingtime; damage -= damageint) {
        previoustime = gettime();
        wait interval;
        damage += timesince(previoustime) * damagepersecond;
        damageint = int(damage);
        self dodamage(damageint, self.origin, attacker, self, "none", "MOD_BURNED");
    }
    self.abnormal_status.burning = 0;
    self vehicle::toggle_burn_fx(0);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0xc98d7da9, Offset: 0x2798
// Size: 0x30
function iff_notifymeinnsec(time, note) {
    self endon(#"death");
    wait time;
    self notify(note);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0x76f95d50, Offset: 0x27d0
// Size: 0x1f0
function iff_override(owner, time) {
    if (!isdefined(time)) {
        time = 60;
    }
    self endon(#"death");
    self._iffoverride_oldteam = self.team;
    self iff_override_team_switch_behavior(owner.team);
    if (isdefined(self.iff_override_cb)) {
        self [[ self.iff_override_cb ]](1);
    }
    if (isdefined(self.settings) && !(isdefined(self.settings.iffshouldrevertteam) && self.settings.iffshouldrevertteam)) {
        return;
    }
    timeout = isdefined(self.settings) ? self.settings.ifftimetillrevert : time;
    assert(timeout > 10);
    self thread iff_notifymeinnsec(timeout - 10, "iff_override_revert_warn");
    msg = self waittilltimeout(timeout, "iff_override_reverted");
    if (msg == "timeout") {
        self notify(#"iff_override_reverted");
    }
    self playsound("gdt_iff_deactivate");
    self iff_override_team_switch_behavior(self._iffoverride_oldteam);
    if (isdefined(self.iff_override_cb)) {
        self [[ self.iff_override_cb ]](0);
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x58f422b2, Offset: 0x29c8
// Size: 0xf4
function iff_override_team_switch_behavior(team) {
    self endon(#"death");
    self val::set("iff_override", "ignoreme", 1);
    self start_scripted();
    self vehicle::lights_off();
    wait 0.1;
    wait 1;
    self setteam(team);
    self blink_lights_for_time(1);
    self stop_scripted();
    wait 1;
    self val::reset("iff_override", "ignoreme");
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0xa93dbafb, Offset: 0x2ac8
// Size: 0xb4
function blink_lights_for_time(time) {
    self endon(#"death");
    starttime = gettime();
    self vehicle::lights_off();
    wait 0.1;
    while (gettime() < starttime + time * 1000) {
        self vehicle::lights_off();
        wait 0.2;
        self vehicle::lights_on();
        wait 0.2;
    }
    self vehicle::lights_on();
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0xcd2ed2b3, Offset: 0x2b88
// Size: 0x12
function turnoff() {
    self notify(#"shut_off");
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0xefe4671, Offset: 0x2ba8
// Size: 0x12
function turnon() {
    self notify(#"start_up");
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0xd6ce9960, Offset: 0x2bc8
// Size: 0xc4
function turnoffalllightsandlaser() {
    self laseroff();
    self vehicle::lights_off();
    self vehicle::toggle_lights_group(1, 0);
    self vehicle::toggle_lights_group(2, 0);
    self vehicle::toggle_lights_group(3, 0);
    self vehicle::toggle_lights_group(4, 0);
    self vehicle::toggle_burn_fx(0);
    self vehicle::toggle_emp_fx(0);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0x8535d99b, Offset: 0x2c98
// Size: 0x4c
function turnoffallambientanims() {
    self vehicle::toggle_ambient_anim_group(1, 0);
    self vehicle::toggle_ambient_anim_group(2, 0);
    self vehicle::toggle_ambient_anim_group(3, 0);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0x87fd9d5f, Offset: 0x2cf0
// Size: 0x94
function clearalllookingandtargeting() {
    self turretcleartarget(0);
    self turretcleartarget(1);
    self turretcleartarget(2);
    self turretcleartarget(3);
    self turretcleartarget(4);
    self vehclearlookat();
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0xf9e4ac8e, Offset: 0x2d90
// Size: 0xf4
function clearallmovement(zerooutspeed) {
    if (!isdefined(zerooutspeed)) {
        zerooutspeed = 0;
    }
    if (!isairborne(self)) {
        self cancelaimove();
    }
    self clearvehgoalpos();
    self pathvariableoffsetclear();
    self pathfixedoffsetclear();
    if (zerooutspeed === 1) {
        self notify(#"landed");
        self setvehvelocity((0, 0, 0));
        self setphysacceleration((0, 0, 0));
        self setangularvelocity((0, 0, 0));
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 15, eflags: 0x0
// Checksum 0xed70d7f, Offset: 0x2e90
// Size: 0x2a8
function shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (should_emp(self, weapon, smeansofdeath, einflictor, eattacker)) {
        minempdowntime = 0.8 * (isdefined(self.settings.empdowntime) ? self.settings.empdowntime : 0);
        maxempdowntime = 1.2 * (isdefined(self.settings.empdowntime) ? self.settings.empdowntime : 1);
        self notify(#"emped", {#param0:randomfloatrange(minempdowntime, maxempdowntime), #param1:eattacker, #param2:einflictor});
    }
    if (should_burn(self, weapon, smeansofdeath, einflictor, eattacker)) {
        self thread burning_thread(eattacker, einflictor);
    }
    if (!isdefined(self.damagelevel)) {
        self.damagelevel = 0;
        self.newdamagelevel = self.damagelevel;
    }
    newdamagelevel = vehicle::should_update_damage_fx_level(self.health, idamage, self.healthdefault);
    if (newdamagelevel > self.damagelevel) {
        self.newdamagelevel = newdamagelevel;
    }
    if (self.newdamagelevel > self.damagelevel) {
        self.damagelevel = self.newdamagelevel;
        self notify(#"pain");
        vehicle::set_damage_fx_level(self.damagelevel);
    }
    return idamage;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 5, eflags: 0x0
// Checksum 0xfb14925b, Offset: 0x3140
// Size: 0x15e
function should_emp(vehicle, weapon, meansofdeath, einflictor, eattacker) {
    if (!isdefined(vehicle) || meansofdeath === "MOD_IMPACT" || vehicle.disableelectrodamage === 1) {
        return 0;
    }
    if (!(isdefined(weapon) && weapon.isemp || meansofdeath === "MOD_ELECTROCUTED")) {
        return 0;
    }
    causer = isdefined(eattacker) ? eattacker : einflictor;
    if (!isdefined(causer)) {
        return 1;
    }
    if (isai(causer) && isvehicle(causer)) {
        return 0;
    }
    if (level.teambased) {
        return (vehicle.team != causer.team);
    }
    if (isdefined(vehicle.owner)) {
        return (vehicle.owner != causer);
    }
    return vehicle != causer;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 5, eflags: 0x0
// Checksum 0x1784ab9, Offset: 0x32a8
// Size: 0x15e
function should_burn(vehicle, weapon, meansofdeath, einflictor, eattacker) {
    if (level.disablevehicleburndamage === 1 || vehicle.disableburndamage === 1) {
        return 0;
    }
    if (!isdefined(vehicle)) {
        return 0;
    }
    if (meansofdeath !== "MOD_BURNED") {
        return 0;
    }
    if (vehicle === einflictor) {
        return 0;
    }
    causer = isdefined(eattacker) ? eattacker : einflictor;
    if (!isdefined(causer)) {
        return 1;
    }
    if (isai(causer) && isvehicle(causer)) {
        return 0;
    }
    if (level.teambased) {
        return (vehicle.team != causer.team);
    }
    if (isdefined(vehicle.owner)) {
        return (vehicle.owner != causer);
    }
    return vehicle != causer;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x4fb75de0, Offset: 0x3410
// Size: 0xa4
function startinitialstate(defaultstate) {
    if (!isdefined(defaultstate)) {
        defaultstate = "combat";
    }
    params = spawnstruct();
    params.isinitialstate = 1;
    if (isdefined(self.script_startstate)) {
        self set_state(self.script_startstate, params);
        return;
    }
    self set_state(defaultstate, params);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0x47db7c13, Offset: 0x34c0
// Size: 0x74
function start_scripted(disable_death_state, no_clear_movement) {
    params = spawnstruct();
    params.no_clear_movement = no_clear_movement;
    self set_state("scripted", params);
    self._no_death_state = disable_death_state;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x5b480d63, Offset: 0x3540
// Size: 0x84
function stop_scripted(statename) {
    if (isalive(self) && is_instate("scripted")) {
        if (isdefined(statename)) {
            self set_state(statename);
            return;
        }
        self set_state("combat");
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x4187d4a5, Offset: 0x35d0
// Size: 0x1c
function set_role(rolename) {
    self.current_role = rolename;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0x529d54e2, Offset: 0x35f8
// Size: 0x44
function set_state(name, params) {
    self.state_machines[self.current_role] thread statemachine::set_state(name, params);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0xe1e14928, Offset: 0x3648
// Size: 0x44
function evaluate_connections(eval_func, params) {
    self.state_machines[self.current_role] statemachine::evaluate_connections(eval_func, params);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x7d1a70da, Offset: 0x3698
// Size: 0x78
function get_state_callbacks(statename) {
    rolename = "default";
    if (isdefined(self.current_role)) {
        rolename = self.current_role;
    }
    if (isdefined(self.state_machines[rolename])) {
        return self.state_machines[rolename].states[statename];
    }
    return undefined;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0x53510d3c, Offset: 0x3718
// Size: 0x64
function get_state_callbacks_for_role(rolename, statename) {
    if (!isdefined(rolename)) {
        rolename = "default";
    }
    if (isdefined(self.state_machines[rolename])) {
        return self.state_machines[rolename].states[statename];
    }
    return undefined;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0x848a2681, Offset: 0x3788
// Size: 0x62
function get_current_state() {
    if (isdefined(self.current_role) && isdefined(self.state_machines[self.current_role].current_state)) {
        return self.state_machines[self.current_role].current_state.name;
    }
    return undefined;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0x4695e390, Offset: 0x37f8
// Size: 0x62
function get_previous_state() {
    if (isdefined(self.current_role) && isdefined(self.state_machines[self.current_role].previous_state)) {
        return self.state_machines[self.current_role].previous_state.name;
    }
    return undefined;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0xaf0d1d4f, Offset: 0x3868
// Size: 0x62
function get_next_state() {
    if (isdefined(self.current_role) && isdefined(self.state_machines[self.current_role].next_state)) {
        return self.state_machines[self.current_role].next_state.name;
    }
    return undefined;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x261de2be, Offset: 0x38d8
// Size: 0x70
function is_instate(statename) {
    if (isdefined(self.current_role) && isdefined(self.state_machines[self.current_role].current_state)) {
        return (self.state_machines[self.current_role].current_state.name === statename);
    }
    return false;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 4, eflags: 0x0
// Checksum 0xa15a054c, Offset: 0x3950
// Size: 0x98
function add_state(name, enter_func, update_func, exit_func) {
    if (isdefined(self.current_role)) {
        statemachine = self.state_machines[self.current_role];
        if (isdefined(statemachine)) {
            state = statemachine statemachine::add_state(name, enter_func, update_func, exit_func);
            return state;
        }
    }
    return undefined;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 4, eflags: 0x0
// Checksum 0xfa24b1db, Offset: 0x39f0
// Size: 0x5c
function add_interrupt_connection(from_state_name, to_state_name, on_notify, checkfunc) {
    self.state_machines[self.current_role] statemachine::add_interrupt_connection(from_state_name, to_state_name, on_notify, checkfunc);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 4, eflags: 0x0
// Checksum 0x43fbba8f, Offset: 0x3a58
// Size: 0x5c
function add_utility_connection(from_state_name, to_state_name, checkfunc, defaultscore) {
    self.state_machines[self.current_role] statemachine::add_utility_connection(from_state_name, to_state_name, checkfunc, defaultscore);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x54fede09, Offset: 0x3ac0
// Size: 0x608
function init_state_machine_for_role(rolename) {
    if (!isdefined(rolename)) {
        rolename = "default";
    }
    statemachine = statemachine::create(rolename, self);
    statemachine.isrole = 1;
    if (!isdefined(self.current_role)) {
        set_role(rolename);
    }
    statemachine statemachine::add_state("suspend", undefined, undefined, undefined);
    statemachine statemachine::add_state("death", &defaultstate_death_enter, &defaultstate_death_update, undefined);
    statemachine statemachine::add_state("scripted", &defaultstate_scripted_enter, undefined, &defaultstate_scripted_exit);
    statemachine statemachine::add_state("combat", &defaultstate_combat_enter, undefined, &defaultstate_combat_exit);
    statemachine statemachine::add_state("emped", &defaultstate_emped_enter, &defaultstate_emped_update, &defaultstate_emped_exit, &defaultstate_emped_reenter);
    statemachine statemachine::add_state("off", &defaultstate_off_enter, undefined, &defaultstate_off_exit);
    statemachine statemachine::add_state("driving", &defaultstate_driving_enter, undefined, &defaultstate_driving_exit);
    statemachine statemachine::add_state("pain", &defaultstate_pain_enter, undefined, &defaultstate_pain_exit);
    statemachine statemachine::add_interrupt_connection("off", "combat", "start_up");
    statemachine statemachine::add_interrupt_connection("driving", "combat", "exit_vehicle");
    statemachine statemachine::add_utility_connection("emped", "combat");
    statemachine statemachine::add_utility_connection("pain", "combat");
    statemachine statemachine::add_interrupt_connection("combat", "emped", "emped");
    statemachine statemachine::add_interrupt_connection("pain", "emped", "emped");
    statemachine statemachine::add_interrupt_connection("emped", "emped", "emped");
    statemachine statemachine::add_interrupt_connection("combat", "off", "shut_off");
    statemachine statemachine::add_interrupt_connection("emped", "off", "shut_off");
    statemachine statemachine::add_interrupt_connection("pain", "off", "shut_off");
    statemachine statemachine::add_interrupt_connection("combat", "driving", "enter_vehicle");
    statemachine statemachine::add_interrupt_connection("emped", "driving", "enter_vehicle");
    statemachine statemachine::add_interrupt_connection("off", "driving", "enter_vehicle");
    statemachine statemachine::add_interrupt_connection("pain", "driving", "enter_vehicle");
    statemachine statemachine::add_interrupt_connection("combat", "pain", "pain");
    statemachine statemachine::add_interrupt_connection("emped", "pain", "pain");
    statemachine statemachine::add_interrupt_connection("off", "pain", "pain");
    statemachine statemachine::add_interrupt_connection("driving", "pain", "pain");
    self.overridevehiclekilled = &callback_vehiclekilled;
    self.overridevehicledeathpostgame = &callback_vehiclekilled;
    statemachine thread statemachine::set_state("suspend");
    self thread on_death_cleanup();
    return statemachine;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0xd899f32c, Offset: 0x40d0
// Size: 0x4a
function register_custom_add_state_callback(func) {
    if (!isdefined(level.level_specific_add_state_callbacks)) {
        level.level_specific_add_state_callbacks = [];
    }
    level.level_specific_add_state_callbacks[level.level_specific_add_state_callbacks.size] = func;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0x30b56d5f, Offset: 0x4128
// Size: 0x60
function call_custom_add_state_callbacks() {
    if (isdefined(level.level_specific_add_state_callbacks)) {
        for (i = 0; i < level.level_specific_add_state_callbacks.size; i++) {
            self [[ level.level_specific_add_state_callbacks[i] ]]();
        }
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 8, eflags: 0x0
// Checksum 0x8fe405f2, Offset: 0x4190
// Size: 0x144
function callback_vehiclekilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    if (isdefined(self._no_death_state) && self._no_death_state) {
        return;
    }
    death_info = spawnstruct();
    death_info.inflictor = einflictor;
    death_info.attacker = eattacker;
    death_info.damage = idamage;
    death_info.meansofdeath = smeansofdeath;
    death_info.weapon = weapon;
    death_info.dir = vdir;
    death_info.hitloc = shitloc;
    death_info.timeoffset = psoffsettime;
    self set_state("death", death_info);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0xc5f0246b, Offset: 0x42e0
// Size: 0xb2
function on_death_cleanup() {
    state_machines = self.state_machines;
    self waittill("free_vehicle");
    foreach (statemachine in state_machines) {
        statemachine statemachine::clear();
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0xd5e914d0, Offset: 0x43a0
// Size: 0xe4
function defaultstate_death_enter(params) {
    self vehicle::toggle_tread_fx(0);
    self vehicle::toggle_exhaust_fx(0);
    self vehicle::toggle_sounds(0);
    self disableaimassist();
    turnoffalllightsandlaser();
    turnoffallambientanims();
    clearalllookingandtargeting();
    clearallmovement();
    self cancelaimove();
    self.takedamage = 0;
    self vehicle_death::death_cleanup_level_variables();
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0xa95f678a, Offset: 0x4490
// Size: 0xac
function burning_death_fx() {
    if (isdefined(self.settings.burn_death_fx_1) && isdefined(self.settings.burn_death_tag_1)) {
        playfxontag(self.settings.burn_death_fx_1, self, self.settings.burn_death_tag_1);
    }
    if (isdefined(self.settings.burn_death_sound_1)) {
        self playsound(self.settings.burn_death_sound_1);
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0xfc30ae18, Offset: 0x4548
// Size: 0xac
function emp_death_fx() {
    if (isdefined(self.settings.emp_death_fx_1) && isdefined(self.settings.emp_death_tag_1)) {
        playfxontag(self.settings.emp_death_fx_1, self, self.settings.emp_death_tag_1);
    }
    if (isdefined(self.settings.emp_death_sound_1)) {
        self playsound(self.settings.emp_death_sound_1);
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0xa2e1c8d4, Offset: 0x4600
// Size: 0x10c
function death_radius_damage_special(radiusscale, meansofdamage) {
    self endon(#"death");
    if (!isdefined(self) || self.abandoned === 1 || self.damage_on_death === 0 || self.radiusdamageradius <= 0) {
        return;
    }
    position = self.origin + (0, 0, 15);
    radius = self.radiusdamageradius * radiusscale;
    damagemax = self.radiusdamagemax;
    damagemin = self.radiusdamagemin;
    waitframe(1);
    if (isdefined(self)) {
        self radiusdamage(position, radius, damagemax, damagemin, undefined, meansofdamage);
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x89508711, Offset: 0x4718
// Size: 0xb4
function burning_death(params) {
    self endon(#"death");
    self burning_death_fx();
    self.skipfriendlyfirecheck = 1;
    self thread death_radius_damage_special(2, "MOD_BURNED");
    self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
    self vehicle::do_death_dynents(3);
    self vehicle_death::deletewhensafe(10);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x88a34348, Offset: 0x47d8
// Size: 0xb4
function emped_death(params) {
    self endon(#"death");
    self emp_death_fx();
    self.skipfriendlyfirecheck = 1;
    self thread death_radius_damage_special(2, "MOD_ELECTROCUTED");
    self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
    self vehicle::do_death_dynents(2);
    self vehicle_death::deletewhensafe();
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x7c62dd7a, Offset: 0x4898
// Size: 0x9c
function gibbed_death(params) {
    self endon(#"death");
    self vehicle_death::death_fx();
    self thread vehicle_death::death_radius_damage();
    self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
    self vehicle::do_death_dynents();
    self vehicle_death::deletewhensafe();
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x2112af4, Offset: 0x4940
// Size: 0x144
function default_death(params) {
    self endon(#"death");
    self vehicle_death::death_fx();
    self thread vehicle_death::death_radius_damage();
    self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
    if (isdefined(level.disable_thermal)) {
        [[ level.disable_thermal ]]();
    }
    waittime = isdefined(self.waittime_before_delete) ? self.waittime_before_delete : 0;
    owner = self getvehicleowner();
    if (isdefined(owner) && self isremotecontrol()) {
        waittime = max(waittime, 4);
    }
    util::waitfortime(waittime);
    vehicle_death::freewhensafe();
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0xc4c22520, Offset: 0x4a90
// Size: 0x120
function get_death_type(params) {
    if (self.delete_on_death === 1) {
        death_type = "default";
    } else {
        death_type = self.death_type;
    }
    if (!isdefined(death_type)) {
        death_type = params.death_type;
    }
    if (!isdefined(death_type) && isdefined(self.abnormal_status) && self.abnormal_status.burning === 1) {
        death_type = "burning";
    }
    if (isdefined(params.weapon) && (isdefined(self.abnormal_status) && !isdefined(death_type) && self.abnormal_status.emped === 1 || params.weapon.isemp)) {
        death_type = "emped";
    }
    return death_type;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x2b95c5e0, Offset: 0x4bb8
// Size: 0x156
function defaultstate_death_update(params) {
    self endon(#"death");
    if (isdefined(level.vehicle_destructer_cb)) {
        [[ level.vehicle_destructer_cb ]](self);
    }
    if (self.delete_on_death === 1) {
        default_death(params);
        vehicle_death::deletewhensafe(0.25);
        return;
    }
    death_type = isdefined(get_death_type(params)) ? get_death_type(params) : "default";
    switch (death_type) {
    case #"burning":
        burning_death(params);
        break;
    case #"emped":
        emped_death(params);
        break;
    case #"gibbed":
        gibbed_death(params);
        break;
    default:
        default_death(params);
        break;
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0xdef3b7ac, Offset: 0x4d18
// Size: 0x94
function defaultstate_scripted_enter(params) {
    if (params.no_clear_movement !== 1) {
        clearalllookingandtargeting();
        clearallmovement();
        if (hasasm(self)) {
            self asmrequestsubstate("locomotion@movement");
        }
        self resumespeed();
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x106442c5, Offset: 0x4db8
// Size: 0x44
function defaultstate_scripted_exit(params) {
    if (params.no_clear_movement !== 1) {
        clearalllookingandtargeting();
        clearallmovement();
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x51d7959b, Offset: 0x4e08
// Size: 0xc
function defaultstate_combat_enter(params) {
    
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x1f254ee0, Offset: 0x4e20
// Size: 0xc
function defaultstate_combat_exit(params) {
    
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x1819bda1, Offset: 0x4e38
// Size: 0x19c
function defaultstate_emped_enter(params) {
    self vehicle::toggle_tread_fx(0);
    self vehicle::toggle_exhaust_fx(0);
    self vehicle::toggle_sounds(0);
    params.laseron = islaseron(self);
    self laseroff();
    self vehicle::lights_off();
    clearalllookingandtargeting();
    clearallmovement();
    if (isairborne(self)) {
        self setrotorspeed(0);
    }
    if (!isdefined(self.abnormal_status)) {
        self.abnormal_status = spawnstruct();
    }
    self.abnormal_status.emped = 1;
    self.abnormal_status.attacker = params.notify_param[1];
    self.abnormal_status.inflictor = params.notify_param[2];
    self vehicle::toggle_emp_fx(1);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0xe68663cb, Offset: 0x4fe0
// Size: 0x6c
function emp_startup_fx() {
    if (isdefined(self.settings.emp_startup_fx_1) && isdefined(self.settings.emp_startup_tag_1)) {
        playfxontag(self.settings.emp_startup_fx_1, self, self.settings.emp_startup_tag_1);
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x4dbb15bd, Offset: 0x5058
// Size: 0x134
function defaultstate_emped_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    time = params.notify_param[0];
    assert(isdefined(time));
    cooldown("emped_timer", time);
    while (!iscooldownready("emped_timer")) {
        timeleft = max(getcooldownleft("emped_timer"), 0.5);
        wait timeleft;
    }
    self.abnormal_status.emped = 0;
    self vehicle::toggle_emp_fx(0);
    self emp_startup_fx();
    wait 1;
    self evaluate_connections();
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0xecc5ffab, Offset: 0x5198
// Size: 0xfc
function defaultstate_emped_exit(params) {
    self vehicle::toggle_tread_fx(1);
    self vehicle::toggle_exhaust_fx(1);
    self vehicle::toggle_sounds(1);
    if (params.laseron === 1) {
        self laseron();
    }
    self vehicle::lights_on();
    if (isairborne(self)) {
        self setphysacceleration((0, 0, 0));
        self thread nudge_collision();
        self setrotorspeed(1);
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0xa755f3c7, Offset: 0x52a0
// Size: 0x10
function defaultstate_emped_reenter(params) {
    return true;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0xefc74fcc, Offset: 0x52b8
// Size: 0x18c
function defaultstate_off_enter(params) {
    self vehicle::toggle_tread_fx(0);
    self vehicle::toggle_exhaust_fx(0);
    self vehicle::toggle_sounds(0);
    self disableaimassist();
    params.laseron = islaseron(self);
    turnoffalllightsandlaser();
    turnoffallambientanims();
    clearalllookingandtargeting();
    clearallmovement();
    if (isdefined(level.disable_thermal)) {
        [[ level.disable_thermal ]]();
    }
    if (isairborne(self)) {
        if (params.isinitialstate !== 1 && params.no_falling !== 1) {
            self setphysacceleration((0, 0, -300));
            self thread level_out_for_landing();
        }
        self setrotorspeed(0);
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x18ea6f73, Offset: 0x5450
// Size: 0x15c
function defaultstate_off_exit(params) {
    self vehicle::toggle_tread_fx(1);
    self vehicle::toggle_exhaust_fx(1);
    self vehicle::toggle_sounds(1);
    self enableaimassist();
    if (isairborne(self)) {
        self setphysacceleration((0, 0, 0));
        self thread nudge_collision();
        self setrotorspeed(1);
    }
    if (params.laseron === 1) {
        self laseron();
    }
    if (isdefined(level.enable_thermal)) {
        if (self get_next_state() !== "death") {
            [[ level.enable_thermal ]]();
        }
    }
    self vehicle::lights_on();
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0xf1a0fc6c, Offset: 0x55b8
// Size: 0x16c
function defaultstate_driving_enter(params) {
    params.driver = self getseatoccupant(0);
    assert(isdefined(params.driver));
    self disableaimassist();
    self.turretrotscale = 1;
    self.team = params.driver.team;
    if (hasasm(self)) {
        self asmrequestsubstate("locomotion@movement");
    }
    self setheliheightcap(1);
    clearalllookingandtargeting();
    clearallmovement();
    self cancelaimove();
    if (isdefined(params.driver) && !isdefined(self.customdamagemonitor)) {
        self thread vehicle::monitor_damage_as_occupant(params.driver);
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x41130e8b, Offset: 0x5730
// Size: 0x9c
function defaultstate_driving_exit(params) {
    self enableaimassist();
    self.turretrotscale = 1;
    self setheliheightcap(0);
    clearalllookingandtargeting();
    clearallmovement();
    if (isdefined(params.driver)) {
        params.driver vehicle::stop_monitor_damage_as_occupant();
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x9db9b3e2, Offset: 0x57d8
// Size: 0x2c
function defaultstate_pain_enter(params) {
    clearalllookingandtargeting();
    clearallmovement();
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x346e74ed, Offset: 0x5810
// Size: 0x2c
function defaultstate_pain_exit(params) {
    clearalllookingandtargeting();
    clearallmovement();
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 3, eflags: 0x0
// Checksum 0xddee8b7, Offset: 0x5848
// Size: 0x72
function canseeenemyfromposition(position, enemy, sight_check_height) {
    sightcheckorigin = position + (0, 0, sight_check_height);
    return sighttracepassed(sightcheckorigin, enemy.origin + (0, 0, 30), 0, self);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x358f5a3, Offset: 0x58c8
// Size: 0x81e
function findnewposition(sight_check_height) {
    if (self.goalforced) {
        goalpos = getclosestpointonnavmesh(self.goalpos, self.radius * 2, self.radius);
        return goalpos;
    }
    point_spacing = 90;
    pixbeginevent("vehicle_ai_shared::FindNewPosition");
    queryresult = positionquery_source_navigation(self.origin, 0, 2000, 300, point_spacing, self, point_spacing * 2);
    pixendevent();
    positionquery_filter_random(queryresult, 0, 50);
    positionquery_filter_distancetogoal(queryresult, self);
    positionquery_filter_outofgoalanchor(queryresult, 50);
    origin = self.goalpos;
    best_point = undefined;
    best_score = -999999;
    if (isdefined(self.enemy)) {
        positionquery_filter_sight(queryresult, self.enemy.origin, self geteye() - self.origin, self, 0, self.enemy);
        self positionquery_filter_engagementdist(queryresult, self.enemy, self.settings.engagementdistmin, self.settings.engagementdistmax);
        if (turret::has_turret(1)) {
            side_turret_enemy = turret::get_target(1);
            if (isdefined(side_turret_enemy) && side_turret_enemy != self.enemy) {
                positionquery_filter_sight(queryresult, side_turret_enemy.origin, (0, 0, sight_check_height), self, 20, self, "sight2");
            }
        }
        if (turret::has_turret(2)) {
            side_turret_enemy = turret::get_target(2);
            if (isdefined(side_turret_enemy) && side_turret_enemy != self.enemy) {
                positionquery_filter_sight(queryresult, side_turret_enemy.origin, (0, 0, sight_check_height), self, 20, self, "sight3");
            }
        }
        foreach (point in queryresult.data) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x67>"] = point.distawayfromengagementarea * -1;
            #/
            point.score += point.distawayfromengagementarea * -1;
            if (distance2dsquared(self.origin, point.origin) < 28900) {
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    point._scoredebug["<dev string:x76>"] = -170;
                #/
                point.score += -170;
            }
            if (isdefined(point.sight) && point.sight) {
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    point._scoredebug["<dev string:x85>"] = 250;
                #/
                point.score += 250;
            }
            if (isdefined(point.sight2) && point.sight2) {
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    point._scoredebug["<dev string:x8b>"] = 150;
                #/
                point.score += 150;
            }
            if (isdefined(point.sight3) && point.sight3) {
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    point._scoredebug["<dev string:x92>"] = 150;
                #/
                point.score += 150;
            }
            if (point.score > best_score) {
                best_score = point.score;
                best_point = point;
            }
        }
    } else {
        foreach (point in queryresult.data) {
            if (distance2dsquared(self.origin, point.origin) < 28900) {
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    point._scoredebug["<dev string:x76>"] = -100;
                #/
                point.score += -100;
            }
            if (point.score > best_score) {
                best_score = point.score;
                best_point = point;
            }
        }
    }
    self positionquery_debugscores(queryresult);
    if (isdefined(best_point)) {
        /#
        #/
        origin = best_point.origin;
    }
    return origin + (0, 0, 10);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x52a519a, Offset: 0x60f0
// Size: 0x1c
function timesince(starttimeinmilliseconds) {
    return (gettime() - starttimeinmilliseconds) * 0.001;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0x3299873d, Offset: 0x6118
// Size: 0x20
function cooldowninit() {
    if (!isdefined(self._cooldown)) {
        self._cooldown = [];
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0xfde104dd, Offset: 0x6140
// Size: 0x42
function cooldown(name, time_seconds) {
    cooldowninit();
    self._cooldown[name] = gettime() + time_seconds * 1000;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x11e5874e, Offset: 0x6190
// Size: 0x58
function getcooldowntimeraw(name) {
    cooldowninit();
    if (!isdefined(self._cooldown[name])) {
        self._cooldown[name] = gettime() - 1;
    }
    return self._cooldown[name];
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x452fa781, Offset: 0x61f0
// Size: 0x40
function getcooldownleft(name) {
    cooldowninit();
    return (getcooldowntimeraw(name) - gettime()) * 0.001;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0xb1d33b8f, Offset: 0x6238
// Size: 0x72
function iscooldownready(name, timeforward_seconds) {
    cooldowninit();
    if (!isdefined(timeforward_seconds)) {
        timeforward_seconds = 0;
    }
    cooldownreadytime = self._cooldown[name];
    return !isdefined(cooldownreadytime) || gettime() + timeforward_seconds * 1000 > cooldownreadytime;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0xf9a10057, Offset: 0x62b8
// Size: 0x36
function clearcooldown(name) {
    cooldowninit();
    self._cooldown[name] = gettime() - 1;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0x72734831, Offset: 0x62f8
// Size: 0x56
function addcooldowntime(name, time_seconds) {
    cooldowninit();
    self._cooldown[name] = getcooldowntimeraw(name) + time_seconds * 1000;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0x3740fdb0, Offset: 0x6358
// Size: 0xa0
function clearallcooldowns() {
    if (isdefined(self._cooldown)) {
        foreach (str_name, cooldown in self._cooldown) {
            self._cooldown[str_name] = gettime() - 1;
        }
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0x8055c919, Offset: 0x6400
// Size: 0xda
function positionquery_debugscores(queryresult) {
    if (!(isdefined(getdvarint("hkai_debugPositionQuery")) && getdvarint("hkai_debugPositionQuery"))) {
        return;
    }
    foreach (point in queryresult.data) {
        point debugscore(self);
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 1, eflags: 0x0
// Checksum 0xef0b9746, Offset: 0x64e8
// Size: 0x1d2
function debugscore(entity) {
    /#
        if (!isdefined(self._scoredebug)) {
            return;
        }
        if (!(isdefined(getdvarint("<dev string:x99>")) && getdvarint("<dev string:x99>"))) {
            return;
        }
        step = 10;
        count = 1;
        color = (1, 0, 0);
        if (self.score >= 0) {
            color = (0, 1, 0);
        }
        recordstar(self.origin, color);
        record3dtext("<dev string:xb1>" + self.score + "<dev string:xb2>", self.origin - (0, 0, step * count), color);
        foreach (name, score in self._scoredebug) {
            count++;
            record3dtext(name + "<dev string:xb4>" + score, self.origin - (0, 0, step * count), color);
        }
    #/
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0xb0a2b780, Offset: 0x66c8
// Size: 0x40
function _less_than_val(left, right) {
    if (!isdefined(left)) {
        return false;
    } else if (!isdefined(right)) {
        return true;
    }
    return left < right;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 3, eflags: 0x0
// Checksum 0xac5c1580, Offset: 0x6710
// Size: 0x5c
function _cmp_val(left, right, descending) {
    if (descending) {
        return _less_than_val(right, left);
    }
    return _less_than_val(left, right);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 3, eflags: 0x0
// Checksum 0x12d85454, Offset: 0x6778
// Size: 0x4a
function _sort_by_score(left, right, descending) {
    return _cmp_val(left.score, right.score, descending);
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 3, eflags: 0x0
// Checksum 0x3f93dc4, Offset: 0x67d0
// Size: 0x122
function positionquery_filter_random(queryresult, min, max) {
    foreach (point in queryresult.data) {
        score = randomfloatrange(min, max);
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:xb6>"] = score;
        #/
        point.score += score;
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0x42df4650, Offset: 0x6900
// Size: 0x74
function positionquery_postprocess_sortscore(queryresult, descending) {
    if (!isdefined(descending)) {
        descending = 1;
    }
    sorted = array::merge_sort(queryresult.data, &_sort_by_score, descending);
    queryresult.data = sorted;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0xa9a8e122, Offset: 0x6980
// Size: 0x142
function positionquery_filter_outofgoalanchor(queryresult, tolerance) {
    if (!isdefined(tolerance)) {
        tolerance = 1;
    }
    foreach (point in queryresult.data) {
        if (point.disttogoal > tolerance) {
            score = -10000 - point.disttogoal * 10;
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:xbd>"] = score;
            #/
            point.score += score;
        }
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 4, eflags: 0x0
// Checksum 0xa0d2d0a3, Offset: 0x6ad0
// Size: 0x33e
function positionquery_filter_engagementdist(queryresult, enemy, engagementdistancemin, engagementdistancemax) {
    if (!isdefined(enemy)) {
        return;
    }
    engagementdistance = (engagementdistancemin + engagementdistancemax) * 0.5;
    half_engagement_width = abs(engagementdistancemax - engagementdistance);
    enemy_origin = (enemy.origin[0], enemy.origin[1], 0);
    vec_enemy_to_self = vectornormalize((self.origin[0], self.origin[1], 0) - enemy_origin);
    foreach (point in queryresult.data) {
        point.distawayfromengagementarea = 0;
        vec_enemy_to_point = (point.origin[0], point.origin[1], 0) - enemy_origin;
        dist_in_front_of_enemy = vectordot(vec_enemy_to_point, vec_enemy_to_self);
        if (abs(dist_in_front_of_enemy) < engagementdistancemin) {
            dist_in_front_of_enemy = engagementdistancemin * -1;
        }
        dist_away_from_sweet_line = abs(dist_in_front_of_enemy - engagementdistance);
        if (dist_away_from_sweet_line > half_engagement_width) {
            point.distawayfromengagementarea = dist_away_from_sweet_line - half_engagement_width;
        }
        too_far_dist = engagementdistancemax * 1.1;
        too_far_dist_sq = too_far_dist * too_far_dist;
        dist_from_enemy_sq = distance2dsquared(point.origin, enemy_origin);
        if (dist_from_enemy_sq > too_far_dist_sq) {
            ratiosq = dist_from_enemy_sq / too_far_dist_sq;
            dist = ratiosq * too_far_dist;
            dist_outside = dist - too_far_dist;
            if (dist_outside > point.distawayfromengagementarea) {
                point.distawayfromengagementarea = dist_outside;
            }
        }
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 4, eflags: 0x0
// Checksum 0x7214222e, Offset: 0x6e18
// Size: 0x29e
function positionquery_filter_distawayfromtarget(queryresult, targetarray, distance, tooclosepenalty) {
    if (!isdefined(targetarray) || !isarray(targetarray)) {
        return;
    }
    foreach (point in queryresult.data) {
        tooclose = 0;
        foreach (target in targetarray) {
            origin = undefined;
            if (isvec(target)) {
                origin = target;
            } else if (issentient(target) && isalive(target)) {
                origin = target.origin;
            } else if (isentity(target)) {
                origin = target.origin;
            }
            if (isdefined(origin) && distance2dsquared(point.origin, origin) < distance * distance) {
                tooclose = 1;
                break;
            }
        }
        if (tooclose) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:xcd>"] = tooclosepenalty;
            #/
            point.score += tooclosepenalty;
        }
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 4, eflags: 0x0
// Checksum 0x538ade93, Offset: 0x70c0
// Size: 0x122
function distancepointtoengagementheight(origin, enemy, engagementheightmin, engagementheightmax) {
    if (!isdefined(enemy)) {
        return undefined;
    }
    result = 0;
    engagementheight = 0.5 * (self.settings.engagementheightmin + self.settings.engagementheightmax);
    half_height = abs(engagementheightmax - engagementheight);
    targetheight = enemy.origin[2] + engagementheight;
    distfromengagementheight = abs(origin[2] - targetheight);
    if (distfromengagementheight > half_height) {
        result = distfromengagementheight - half_height;
    }
    return result;
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 4, eflags: 0x0
// Checksum 0x8c8dea37, Offset: 0x71f0
// Size: 0x186
function positionquery_filter_engagementheight(queryresult, enemy, engagementheightmin, engagementheightmax) {
    if (!isdefined(enemy)) {
        return;
    }
    engagementheight = 0.5 * (engagementheightmin + engagementheightmax);
    half_height = abs(engagementheightmax - engagementheight);
    foreach (point in queryresult.data) {
        point.distengagementheight = 0;
        targetheight = enemy.origin[2] + engagementheight;
        distfromengagementheight = abs(point.origin[2] - targetheight);
        if (distfromengagementheight > half_height) {
            point.distengagementheight = distfromengagementheight - half_height;
        }
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 2, eflags: 0x0
// Checksum 0xf679881e, Offset: 0x7380
// Size: 0xbc
function positionquery_postprocess_removeoutofgoalradius(queryresult, tolerance) {
    if (!isdefined(tolerance)) {
        tolerance = 1;
    }
    for (i = 0; i < queryresult.data.size; i++) {
        point = queryresult.data[i];
        if (point.disttogoal > tolerance) {
            arrayremoveindex(queryresult.data, i);
            i--;
        }
    }
}

// Namespace vehicle_ai/vehicle_ai_shared
// Params 0, eflags: 0x0
// Checksum 0xf10d2654, Offset: 0x7448
// Size: 0xb0
function target_hijackers() {
    self endon(#"death");
    while (true) {
        waitresult = self waittill("ccom_lock_being_targeted");
        hijackingplayer = waitresult.hijacking_player;
        self getperfectinfo(hijackingplayer, 1);
        if (isplayer(hijackingplayer)) {
            self setpersonalthreatbias(hijackingplayer, 1500, 4);
        }
    }
}

