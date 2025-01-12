#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;

#namespace auto_turret;

// Namespace auto_turret/auto_turret
// Params 0, eflags: 0x2
// Checksum 0xf8e58056, Offset: 0x1d0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"auto_turret", &__init__, undefined, undefined);
}

// Namespace auto_turret/auto_turret
// Params 0, eflags: 0x0
// Checksum 0x2b6bd0ad, Offset: 0x218
// Size: 0x2c
function __init__() {
    vehicle::add_main_callback("auto_turret", &function_ea5943d6);
}

// Namespace auto_turret/auto_turret
// Params 0, eflags: 0x0
// Checksum 0xc35484be, Offset: 0x250
// Size: 0x51c
function function_5c4c4ff8() {
    self.health = self.healthdefault;
    if (isdefined(self.scriptbundlesettings)) {
        self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    } else {
        self.settings = struct::get_script_bundle("vehiclecustomsettings", "artillerysettings");
    }
    targetoffset = (isdefined(self.settings.lockon_offsetx) ? self.settings.lockon_offsetx : 0, isdefined(self.settings.lockon_offsety) ? self.settings.lockon_offsety : 0, isdefined(self.settings.lockon_offsetz) ? self.settings.lockon_offsetz : 0);
    vehicle::make_targetable(self, targetoffset);
    sightfov = self.settings.sightfov;
    if (!isdefined(sightfov)) {
        sightfov = 0;
    }
    if (sightfov == 0) {
        self.fovcosine = 0;
        self.fovcosinebusy = 0;
    } else {
        self.fovcosine = cos(sightfov - 0.1);
        self.fovcosinebusy = cos(sightfov - 0.1);
    }
    if (self.settings.disconnectpaths === 1) {
        self disconnectpaths(1);
    }
    if (self.settings.ignoreme === 1) {
        self val::set(#"auto_turret", "ignoreme", 1);
    }
    if (self.settings.laseron === 1) {
        self laseron();
    }
    if (self.settings.disablefiring !== 1) {
        self enableaimassist();
    } else {
        self.nocybercom = 1;
    }
    self.overridevehicledamage = &turretcallback_vehicledamage;
    self.allowfriendlyfiredamageoverride = &turretallowfriendlyfiredamage;
    if (isdefined(self.var_b6b5f303) && self.var_b6b5f303) {
        self influencers::create_influencer_generic("enemy", self.origin, self.team, 1);
    }
    if (isdefined(self.settings.keylinerender) && self.settings.keylinerender) {
        self clientfield::set("turret_keyline_render", 1);
    }
    if (isdefined(level.vehicle_initializer_cb)) {
        [[ level.vehicle_initializer_cb ]](self);
    }
    if (isdefined(self.settings.var_19e8b710) && self.settings.var_19e8b710 && !(isdefined(self.has_bad_place) && self.has_bad_place)) {
        if (!isdefined(level.var_42b3ee16)) {
            level.var_42b3ee16 = 0;
        } else {
            level.var_42b3ee16 += 1;
        }
        self.turret_id = string(level.var_42b3ee16);
        badplace_cylinder("turret_bad_place_" + self.turret_id, 0, self.origin, self.settings.var_44045a4e, self.settings.var_f7a7f7f5, #"axis", #"allies", #"neutral");
        self.has_bad_place = 1;
    }
    if (isdefined(self.settings.cleanup_after_time) && self.settings.cleanup_after_time > 0) {
        self.cleanup_after_time = self.settings.cleanup_after_time;
    }
    self callback::function_1dea870d(#"on_vehicle_killed", &function_45ee3830);
}

// Namespace auto_turret/auto_turret
// Params 0, eflags: 0x0
// Checksum 0x70b3a7a6, Offset: 0x778
// Size: 0x24
function function_ea5943d6() {
    function_5c4c4ff8();
    function_219e2f27();
}

// Namespace auto_turret/auto_turret
// Params 0, eflags: 0x0
// Checksum 0x64ace770, Offset: 0x7a8
// Size: 0x30c
function function_219e2f27() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    self vehicle_ai::get_state_callbacks("combat").update_func = &function_b1cedf6e;
    self vehicle_ai::get_state_callbacks("combat").exit_func = &state_combat_exit;
    self vehicle_ai::get_state_callbacks("off").enter_func = &state_off_enter;
    self vehicle_ai::get_state_callbacks("off").exit_func = &state_off_exit;
    self vehicle_ai::get_state_callbacks("emped").enter_func = &state_emped_enter;
    self vehicle_ai::get_state_callbacks("emped").update_func = &state_emped_update;
    self vehicle_ai::get_state_callbacks("emped").exit_func = &state_emped_exit;
    self vehicle_ai::add_state("unaware", undefined, &state_unaware_update, undefined);
    vehicle_ai::add_interrupt_connection("unaware", "scripted", "enter_scripted");
    vehicle_ai::add_interrupt_connection("unaware", "emped", "emped");
    vehicle_ai::add_interrupt_connection("unaware", "off", "shut_off");
    vehicle_ai::add_interrupt_connection("unaware", "driving", "enter_vehicle");
    vehicle_ai::add_interrupt_connection("unaware", "pain", "pain");
    vehicle_ai::add_utility_connection("unaware", "combat", &should_switch_to_combat);
    vehicle_ai::add_utility_connection("combat", "unaware", &should_switch_to_unaware);
    vehicle_ai::startinitialstate("unaware");
}

// Namespace auto_turret/auto_turret
// Params 1, eflags: 0x0
// Checksum 0x4b582169, Offset: 0xac0
// Size: 0x1cc
function state_death_update(params) {
    self endon(#"death");
    owner = self getvehicleowner();
    if (isdefined(owner)) {
        self waittill(#"exit_vehicle");
    }
    self setturretspinning(0);
    self turret::toggle_lensflare(0);
    if (isdefined(self.has_bad_place) && self.has_bad_place) {
        badplace_delete("turret_bad_place_" + self.turret_id);
        self.has_bad_place = 0;
    }
    if (target_istarget(self)) {
        target_remove(self);
    }
    self thread turret_idle_sound_stop();
    self playsound(#"veh_sentry_turret_dmg_hit");
    self.turretrotscale = 2;
    self rest_turret(params.resting_pitch);
    self vehicle_ai::defaultstate_death_update(params);
    if (isdefined(self.settings.keylinerender) && self.settings.keylinerender) {
        self clientfield::set("turret_keyline_render", 0);
    }
}

// Namespace auto_turret/auto_turret
// Params 3, eflags: 0x0
// Checksum 0x22e0f30b, Offset: 0xc98
// Size: 0x5a
function should_switch_to_unaware(current_state, to_state, connection) {
    if (!isdefined(self.enemy) || !self seerecently(self.enemy, 1.5)) {
        return 100;
    }
    return 0;
}

// Namespace auto_turret/auto_turret
// Params 1, eflags: 0x0
// Checksum 0x83070d3d, Offset: 0xd00
// Size: 0x268
function state_unaware_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    turret_left = 1;
    relativeangle = 0;
    self thread turret_idle_sound();
    self playsound(#"mpl_turret_startup");
    self turretcleartarget(0);
    while (true) {
        rotscale = self.settings.scanning_speedscale;
        if (!isdefined(rotscale)) {
            rotscale = 0.01;
        }
        self.turretrotscale = rotscale;
        scanning_arc = self.settings.scanning_arc;
        if (!isdefined(scanning_arc)) {
            scanning_arc = 0;
        }
        limits = self getturretlimitsyaw();
        scanning_arc = min(scanning_arc, limits[0] - 0.1);
        scanning_arc = min(scanning_arc, limits[1] - 0.1);
        if (scanning_arc > 179) {
            if (self.turretontarget) {
                relativeangle += 90;
                if (relativeangle > 180) {
                    relativeangle -= 360;
                }
            }
            scanning_arc = relativeangle;
        } else {
            if (self.turretontarget) {
                turret_left = !turret_left;
            }
            if (!turret_left) {
                scanning_arc *= -1;
            }
        }
        scanning_pitch = self.settings.scanning_pitch;
        if (!isdefined(scanning_pitch)) {
            scanning_pitch = 0;
        }
        self turretsettargetangles(0, (scanning_pitch, scanning_arc, 0));
        self vehicle_ai::evaluate_connections();
        wait 0.5;
    }
}

// Namespace auto_turret/auto_turret
// Params 3, eflags: 0x0
// Checksum 0xbae08445, Offset: 0xf70
// Size: 0x70
function should_switch_to_combat(current_state, to_state, connection) {
    if (isdefined(self.enemy) && isalive(self.enemy) && self cansee(self.enemy)) {
        return 100;
    }
    return 0;
}

// Namespace auto_turret/auto_turret
// Params 1, eflags: 0x0
// Checksum 0x46cc8758, Offset: 0xfe8
// Size: 0x3e8
function function_b1cedf6e(params) {
    self endon(#"death");
    self endon(#"change_state");
    if (isdefined(self.enemy)) {
        sentry_turret_alert_sound();
        wait 0.5;
    }
    while (true) {
        if (isdefined(self.enemy) && self cansee(self.enemy)) {
            self.turretrotscale = 1;
            if (isdefined(self.enemy) && self haspart("tag_minigun_spin")) {
                self turretsettarget(0, self.enemy);
                self setturretspinning(1);
                wait 0.5;
            }
            for (i = 0; i < 3; i++) {
                if (isdefined(self.enemy) && isalive(self.enemy) && self cansee(self.enemy)) {
                    self turretsettarget(0, self.enemy);
                    wait 0.1;
                    waittime = randomfloatrange(self.settings.var_d4247091, self.settings.var_3f21e5ef);
                    if (self.settings.disablefiring !== 1) {
                        self sentry_turret_fire_for_time(waittime, self.enemy);
                    } else {
                        wait waittime;
                    }
                }
                if (isdefined(self.enemy) && isplayer(self.enemy)) {
                    wait randomfloatrange(self.settings.var_e2f6338, self.settings.var_68d541c6);
                    continue;
                }
                wait randomfloatrange(self.settings.var_99f9c49a, self.settings.var_6f67b954);
            }
            self setturretspinning(0);
            if (isdefined(self.enemy) && isalive(self.enemy) && self cansee(self.enemy)) {
                if (isplayer(self.enemy)) {
                    wait randomfloatrange(0.5, 1.3);
                } else {
                    wait randomfloatrange(0.5, 1.3) * 2;
                }
            }
        }
        self vehicle_ai::evaluate_connections();
        if (isdefined(self.var_16ce832f) && isdefined(self.var_7b4a12f9)) {
            n_cooldown_time = randomfloatrange(self.var_16ce832f, self.var_7b4a12f9);
        } else {
            n_cooldown_time = 0.5;
        }
        wait n_cooldown_time;
    }
}

// Namespace auto_turret/auto_turret
// Params 1, eflags: 0x0
// Checksum 0x2d9f587e, Offset: 0x13d8
// Size: 0x24
function state_combat_exit(params) {
    self setturretspinning(0);
}

// Namespace auto_turret/auto_turret
// Params 2, eflags: 0x0
// Checksum 0x94a721d7, Offset: 0x1408
// Size: 0x104
function sentry_turret_fire_for_time(totalfiretime, enemy) {
    self endon(#"death");
    self endon(#"change_state");
    sentry_turret_alert_sound();
    wait 0.1;
    weapon = self seatgetweapon(0);
    firetime = weapon.firetime;
    time = 0;
    is_minigun = 0;
    while (time < totalfiretime) {
        self fireweapon(0, enemy);
        wait firetime;
        time += firetime;
    }
    if (is_minigun) {
        self setturretspinning(0);
    }
}

// Namespace auto_turret/auto_turret
// Params 1, eflags: 0x0
// Checksum 0x2bcb53ee, Offset: 0x1518
// Size: 0x54
function state_off_enter(params) {
    self vehicle_ai::defaultstate_off_enter(params);
    self.turretrotscale = 0.5;
    self rest_turret(params.resting_pitch);
}

// Namespace auto_turret/auto_turret
// Params 1, eflags: 0x0
// Checksum 0xb67533c1, Offset: 0x1578
// Size: 0x54
function state_off_exit(params) {
    self vehicle_ai::defaultstate_off_exit(params);
    self.turretrotscale = 1;
    self playsound(#"mpl_turret_startup");
}

// Namespace auto_turret/auto_turret
// Params 1, eflags: 0x0
// Checksum 0x88284fd4, Offset: 0x15d8
// Size: 0x94
function rest_turret(resting_pitch = self.settings.resting_pitch) {
    if (!isdefined(resting_pitch)) {
        resting_pitch = 0;
    }
    angles = self gettagangles("tag_turret") - self.angles;
    self turretsettargetangles(0, (resting_pitch, angles[1], 0));
}

// Namespace auto_turret/auto_turret
// Params 1, eflags: 0x0
// Checksum 0x9bcabe4e, Offset: 0x1678
// Size: 0x154
function state_emped_enter(params) {
    self vehicle_ai::defaultstate_emped_enter(params);
    playsoundatposition(#"veh_sentry_turret_emp_down", self.origin);
    self.turretrotscale = 0.5;
    self rest_turret(params.resting_pitch);
    params.laseron = islaseron(self);
    self laseroff();
    self vehicle::lights_off();
    if (!isdefined(self.abnormal_status)) {
        self.abnormal_status = spawnstruct();
    }
    self.abnormal_status.emped = 1;
    self.abnormal_status.attacker = params.param1;
    self.abnormal_status.inflictor = params.param2;
    self vehicle::toggle_emp_fx(1);
}

// Namespace auto_turret/auto_turret
// Params 1, eflags: 0x0
// Checksum 0x45c7402, Offset: 0x17d8
// Size: 0x14c
function state_emped_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    time = params.param0;
    assert(isdefined(time));
    util::cooldown("emped_timer", time);
    while (!util::iscooldownready("emped_timer")) {
        timeleft = max(util::getcooldownleft("emped_timer"), 0.5);
        wait timeleft;
    }
    self.abnormal_status.emped = 0;
    self vehicle::toggle_emp_fx(0);
    self vehicle_ai::emp_startup_fx();
    self rest_turret(0);
    wait 1;
    self vehicle_ai::evaluate_connections();
}

// Namespace auto_turret/auto_turret
// Params 1, eflags: 0x0
// Checksum 0x5661da3e, Offset: 0x1930
// Size: 0x54
function state_emped_exit(params) {
    self vehicle_ai::defaultstate_emped_exit(params);
    self.turretrotscale = 1;
    self playsound(#"mpl_turret_startup");
}

// Namespace auto_turret/auto_turret
// Params 1, eflags: 0x0
// Checksum 0xad8b953b, Offset: 0x1990
// Size: 0x1a
function state_scripted_update(params) {
    self.turretrotscale = 1;
}

// Namespace auto_turret/auto_turret
// Params 4, eflags: 0x0
// Checksum 0x570d9a84, Offset: 0x19b8
// Size: 0xd6
function turretallowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon) {
    if (isdefined(self.owner) && eattacker == self.owner && isdefined(self.settings.friendly_fire) && int(self.settings.friendly_fire) && !weapon.isemp) {
        return true;
    }
    if (isdefined(eattacker) && isdefined(eattacker.archetype) && isdefined(smeansofdeath) && smeansofdeath == "MOD_EXPLOSIVE") {
        return true;
    }
    return false;
}

// Namespace auto_turret/auto_turret
// Params 15, eflags: 0x0
// Checksum 0x2879f17e, Offset: 0x1a98
// Size: 0xd2
function turretcallback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    idamage = vehicle_ai::shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    return idamage;
}

// Namespace auto_turret/auto_turret
// Params 0, eflags: 0x0
// Checksum 0xfeba5da2, Offset: 0x1b78
// Size: 0x24
function sentry_turret_alert_sound() {
    self playsound(#"veh_turret_alert");
}

// Namespace auto_turret/auto_turret
// Params 0, eflags: 0x0
// Checksum 0xf86fd5c8, Offset: 0x1ba8
// Size: 0x94
function turret_idle_sound() {
    if (!isdefined(self.sndloop_ent)) {
        self.sndloop_ent = spawn("script_origin", self.origin);
        self.sndloop_ent linkto(self);
        self.sndloop_ent playloopsound(#"veh_turret_idle");
        self.sndloop_ent thread function_1a1e1452(self);
    }
}

// Namespace auto_turret/auto_turret
// Params 0, eflags: 0x0
// Checksum 0x4052a8a4, Offset: 0x1c48
// Size: 0x5c
function function_684d827f() {
    self endon(#"death");
    if (isdefined(self)) {
        self stoploopsound(0.5);
        wait 2;
        if (isdefined(self)) {
            self delete();
        }
    }
}

// Namespace auto_turret/auto_turret
// Params 1, eflags: 0x0
// Checksum 0x5605664e, Offset: 0x1cb0
// Size: 0x4c
function function_1a1e1452(turret) {
    self endon(#"death");
    turret waittill(#"death");
    self function_684d827f();
}

// Namespace auto_turret/auto_turret
// Params 0, eflags: 0x0
// Checksum 0x2c628b7c, Offset: 0x1d08
// Size: 0x3c
function turret_idle_sound_stop() {
    self endon(#"death");
    if (isdefined(self.sndloop_ent)) {
        self.sndloop_ent function_684d827f();
    }
}

// Namespace auto_turret/auto_turret
// Params 1, eflags: 0x0
// Checksum 0xb255cd6c, Offset: 0x1d50
// Size: 0x44
function function_45ee3830(params) {
    if (isdefined(self.vehicletype) && isdefined(self.var_b6b5f303) && self.var_b6b5f303) {
        self influencers::remove_influencers();
    }
}

