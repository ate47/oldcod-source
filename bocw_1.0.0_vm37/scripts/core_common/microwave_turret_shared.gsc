#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damage;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace microwave_turret;

// Namespace microwave_turret/microwave_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x962875c3, Offset: 0x130
// Size: 0xd4
function init_shared() {
    clientfield::register("vehicle", "turret_microwave_open", 1, 1, "int");
    clientfield::register("scriptmover", "turret_microwave_init", 1, 1, "int");
    clientfield::register("scriptmover", "turret_microwave_close", 1, 1, "int");
    callback::on_spawned(&on_player_spawned);
    callback::on_vehicle_spawned(&on_vehicle_spawned);
}

// Namespace microwave_turret/microwave_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x2f48f98e, Offset: 0x210
// Size: 0x1c
function on_player_spawned() {
    self reset_being_microwaved();
}

// Namespace microwave_turret/microwave_turret_shared
// Params 0, eflags: 0x0
// Checksum 0xd70552a5, Offset: 0x238
// Size: 0x1c
function on_vehicle_spawned() {
    self reset_being_microwaved();
}

// Namespace microwave_turret/microwave_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x98da1c06, Offset: 0x260
// Size: 0x16
function reset_being_microwaved() {
    self.lastmicrowavedby = undefined;
    self.beingmicrowavedby = undefined;
}

// Namespace microwave_turret/microwave_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x48c30d6b, Offset: 0x280
// Size: 0xcc
function startmicrowave() {
    turret = self;
    if (isdefined(turret.trigger)) {
        turret.trigger delete();
    }
    turret.trigger = spawn("trigger_radius", turret.origin + (0, 0, 750 * -1), 4096 | 16384 | level.aitriggerspawnflags | level.vehicletriggerspawnflags, 750, 750 * 2);
    turret thread turretthink();
    /#
        turret thread turretdebugwatch();
    #/
}

// Namespace microwave_turret/microwave_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x63f79e27, Offset: 0x358
// Size: 0x80
function stopmicrowave() {
    turret = self;
    if (isdefined(turret)) {
        turret playsound(#"mpl_microwave_beam_off");
        if (isdefined(turret.trigger)) {
            turret.trigger delete();
        }
        /#
            turret notify(#"stop_turret_debug");
        #/
    }
}

/#

    // Namespace microwave_turret/microwave_turret_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5f60ccf6, Offset: 0x3e0
    // Size: 0x7c
    function turretdebugwatch() {
        turret = self;
        turret endon(#"stop_turret_debug");
        for (;;) {
            if (getdvarint(#"scr_microwave_turret_debug", 0) != 0) {
                turret turretdebug();
                waitframe(1);
                continue;
            }
            wait 1;
        }
    }

    // Namespace microwave_turret/microwave_turret_shared
    // Params 0, eflags: 0x0
    // Checksum 0x3fda098d, Offset: 0x468
    // Size: 0x104
    function turretdebug() {
        turret = self;
        angles = turret gettagangles("<dev string:x38>");
        origin = turret gettagorigin("<dev string:x38>");
        cone_apex = origin;
        forward = anglestoforward(angles);
        dome_apex = cone_apex + vectorscale(forward, 750);
        /#
            util::debug_spherical_cone(cone_apex, dome_apex, 15, 16, (0.95, 0.1, 0.1), 0.3, 1, 3);
        #/
    }

#/

// Namespace microwave_turret/microwave_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x4ea60581, Offset: 0x578
// Size: 0x120
function turretthink() {
    turret = self;
    turret endon(#"microwave_turret_shutdown", #"death");
    turret.trigger endon(#"death", #"delete");
    turret.turret_vehicle_entnum = turret getentitynumber();
    while (true) {
        waitresult = turret.trigger waittill(#"trigger");
        ent = waitresult.activator;
        if (ent == turret) {
            continue;
        }
        if (!isdefined(ent.beingmicrowavedby)) {
            ent.beingmicrowavedby = [];
        }
        if (!isdefined(ent.beingmicrowavedby[turret.turret_vehicle_entnum])) {
            turret thread microwaveentity(ent);
        }
    }
}

// Namespace microwave_turret/microwave_turret_shared
// Params 1, eflags: 0x0
// Checksum 0x13b87160, Offset: 0x6a0
// Size: 0xa8
function microwaveentitypostshutdowncleanup(entity) {
    entity endon(#"disconnect", #"end_microwaveentitypostshutdowncleanup");
    turret = self;
    turret_vehicle_entnum = turret.turret_vehicle_entnum;
    turret waittill(#"microwave_turret_shutdown");
    if (isdefined(entity)) {
        if (isdefined(entity.beingmicrowavedby) && isdefined(entity.beingmicrowavedby[turret_vehicle_entnum])) {
            entity.beingmicrowavedby[turret_vehicle_entnum] = undefined;
        }
    }
}

// Namespace microwave_turret/microwave_turret_shared
// Params 1, eflags: 0x0
// Checksum 0x374a00bb, Offset: 0x750
// Size: 0x690
function microwaveentity(entity) {
    turret = self;
    turret endon(#"microwave_turret_shutdown", #"death");
    entity endon(#"disconnect", #"death");
    if (isplayer(entity)) {
        entity endon(#"joined_team", #"joined_spectators");
    }
    turret thread microwaveentitypostshutdowncleanup(entity);
    entity.beingmicrowavedby[turret.turret_vehicle_entnum] = turret.owner;
    entity.microwavedamageinitialdelay = 1;
    entity.microwaveeffect = 0;
    shellshockscalar = 1;
    viewkickscalar = 1;
    damagescalar = 1;
    if (isplayer(entity) && entity hasperk(#"specialty_microwaveprotection")) {
        shellshockscalar = getdvarfloat(#"specialty_microwaveprotection_shellshock_scalar", 0.5);
        viewkickscalar = getdvarfloat(#"specialty_microwaveprotection_viewkick_scalar", 0.5);
        damagescalar = getdvarfloat(#"specialty_microwaveprotection_damage_scalar", 0.5);
    }
    turretweapon = getweapon(#"microwave_turret");
    while (true) {
        if (!isdefined(turret) || !turret microwaveturretaffectsentity(entity) || !isdefined(turret.trigger)) {
            if (!isdefined(entity)) {
                return;
            }
            entity.beingmicrowavedby[turret.turret_vehicle_entnum] = undefined;
            if (isdefined(entity.microwavepoisoning) && entity.microwavepoisoning) {
                entity.microwavepoisoning = 0;
            }
            entity notify(#"end_microwaveentitypostshutdowncleanup");
            return;
        }
        damage = 15 * damagescalar;
        if (level.hardcoremode) {
            damage /= 2;
        }
        if (!isai(entity) && entity util::mayapplyscreeneffect()) {
            if (!isdefined(entity.microwavepoisoning) || !entity.microwavepoisoning) {
                entity.microwavepoisoning = 1;
                entity.microwaveeffect = 0;
            }
        }
        if (isdefined(entity.microwavedamageinitialdelay)) {
            wait randomfloatrange(0.1, 0.3);
            entity.microwavedamageinitialdelay = undefined;
        }
        entity dodamage(damage, turret.origin, turret.owner, turret, 0, "MOD_TRIGGER_HURT", 0, turretweapon);
        entity.microwaveeffect++;
        entity.lastmicrowavedby = turret.owner;
        time = gettime();
        if (isplayer(entity) && !entity isremotecontrolling()) {
            if (time - (isdefined(entity.microwaveshellshockandviewkicktime) ? entity.microwaveshellshockandviewkicktime : 0) > 950) {
                if (entity.microwaveeffect % 2 == 1) {
                    if (distancesquared(entity.origin, turret.origin) > 750 * 2 / 3 * 750 * 2 / 3) {
                        entity shellshock(#"mp_radiation_low", 1.5 * shellshockscalar);
                        entity viewkick(int(25 * viewkickscalar), turret.origin);
                    } else if (distancesquared(entity.origin, turret.origin) > 750 * 1 / 3 * 750 * 1 / 3) {
                        entity shellshock(#"mp_radiation_med", 1.5 * shellshockscalar);
                        entity viewkick(int(50 * viewkickscalar), turret.origin);
                    } else {
                        entity shellshock(#"mp_radiation_high", 1.5 * shellshockscalar);
                        entity viewkick(int(75 * viewkickscalar), turret.origin);
                    }
                    entity.microwaveshellshockandviewkicktime = time;
                }
            }
        }
        if (isplayer(entity) && entity.microwaveeffect % 3 == 2) {
            scoreevents::processscoreevent(#"hpm_suppress", turret.owner, entity, turretweapon);
        }
        wait 0.5;
    }
}

// Namespace microwave_turret/microwave_turret_shared
// Params 1, eflags: 0x0
// Checksum 0x7188585d, Offset: 0xde8
// Size: 0x25a
function microwaveturretaffectsentity(entity) {
    turret = self;
    if (!isalive(entity)) {
        return false;
    }
    if (!isplayer(entity) && !isai(entity)) {
        return false;
    }
    if (entity.ignoreme === 1) {
        return false;
    }
    if (isdefined(turret.carried) && turret.carried) {
        return false;
    }
    if (turret weaponobjects::isstunned()) {
        return false;
    }
    if (isdefined(turret.owner) && entity == turret.owner) {
        return false;
    }
    if (!damage::friendlyfirecheck(turret.owner, entity, 0)) {
        return false;
    }
    if (distancesquared(entity.origin, turret.origin) > 750 * 750) {
        return false;
    }
    angles = turret gettagangles("tag_flash");
    origin = turret gettagorigin("tag_flash");
    shoot_at_pos = entity getshootatpos(turret);
    entdirection = vectornormalize(shoot_at_pos - origin);
    forward = anglestoforward(angles);
    dot = vectordot(entdirection, forward);
    if (dot < cos(15)) {
        return false;
    }
    if (entity damageconetrace(origin, turret, forward) <= 0) {
        return false;
    }
    return true;
}

