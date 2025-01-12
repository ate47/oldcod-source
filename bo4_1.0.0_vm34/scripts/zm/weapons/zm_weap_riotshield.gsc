#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace riotshield;

// Namespace riotshield/zm_weap_riotshield
// Params 0, eflags: 0x2
// Checksum 0x71660a82, Offset: 0x208
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_equip_riotshield", &__init__, &__main__, undefined);
}

// Namespace riotshield/zm_weap_riotshield
// Params 0, eflags: 0x0
// Checksum 0xfa8d2296, Offset: 0x258
// Size: 0x424
function __init__() {
    if (!isdefined(level.weaponriotshield)) {
        level.weaponriotshield = getweapon(#"riotshield");
    }
    clientfield::register("toplayer", "zm_shield_damage_rumble", 1, 1, "counter");
    clientfield::register("toplayer", "zm_shield_break_rumble", 1, 1, "counter");
    clientfield::register("clientuimodel", "ZMInventoryPersonal.shield_health", 1, 4, "float");
    zombie_utility::set_zombie_var(#"riotshield_cylinder_radius", 360);
    zombie_utility::set_zombie_var(#"riotshield_fling_range", 90);
    zombie_utility::set_zombie_var(#"riotshield_gib_range", 90);
    zombie_utility::set_zombie_var(#"riotshield_gib_damage", 75);
    zombie_utility::set_zombie_var(#"riotshield_knockdown_range", 90);
    zombie_utility::set_zombie_var(#"hash_682e9c2200af273b", 15);
    zombie_utility::set_zombie_var(#"riotshield_fling_force_melee", 100);
    zombie_utility::set_zombie_var(#"riotshield_fling_damage_shield", 50);
    zombie_utility::set_zombie_var(#"riotshield_knockdown_damage_shield", 300);
    zombie_utility::set_zombie_var(#"hash_5fc8c2e0d66673a2", 50);
    zombie_utility::set_zombie_var(#"riotshield_stowed_block_fraction", 1);
    level.var_75bba292 = 0;
    level.riotshield_gib_refs = [];
    level.riotshield_gib_refs[level.riotshield_gib_refs.size] = "guts";
    level.riotshield_gib_refs[level.riotshield_gib_refs.size] = "right_arm";
    level.riotshield_gib_refs[level.riotshield_gib_refs.size] = "left_arm";
    zm_player::function_ae6c9a30(&player_damage_override_callback);
    if (!isdefined(level.riotshield_melee)) {
        level.riotshield_melee = &riotshield_melee;
    }
    if (!isdefined(level.riotshield_melee_power)) {
        level.riotshield_melee_power = &riotshield_melee;
    }
    if (!isdefined(level.riotshield_damage_callback)) {
        level.riotshield_damage_callback = &player_damage_shield;
    }
    if (!isdefined(level.should_shield_absorb_damage)) {
        level.should_shield_absorb_damage = &should_shield_absorb_damage;
    }
    if (!isdefined(level.callbackplayershielddamageblocked)) {
        level.callbackplayershielddamageblocked = &callback_playershielddamageblocked;
    }
    callback::on_connect(&on_player_connect);
    zm::register_actor_damage_callback(&function_1bb22fec);
}

// Namespace riotshield/zm_weap_riotshield
// Params 0, eflags: 0x0
// Checksum 0x5cecfeaf, Offset: 0x688
// Size: 0x1c
function __main__() {
    level thread function_aa012a4a();
}

// Namespace riotshield/zm_weap_riotshield
// Params 0, eflags: 0x0
// Checksum 0x1e2c580f, Offset: 0x6b0
// Size: 0x7c
function on_player_connect() {
    self.player_shield_reset_health = &player_init_shield_health;
    if (!isdefined(self.player_shield_apply_damage)) {
        self.player_shield_apply_damage = &player_damage_shield;
    }
    self thread player_watch_weapon_change();
    self thread player_watch_shield_melee();
    self thread player_watch_shield_melee_power();
}

// Namespace riotshield/zm_weap_riotshield
// Params 2, eflags: 0x0
// Checksum 0x4b31459c, Offset: 0x738
// Size: 0x238
function player_init_shield_health(weapon, var_ec4870b4 = 0) {
    if (!isdefined(weapon)) {
        weapon = level.weaponriotshield;
        if (isdefined(self.weaponriotshield)) {
            weapon = self.weaponriotshield;
        }
    }
    if (!isdefined(level.var_f1474f7e)) {
        level.var_f1474f7e = 1;
    }
    switch (zm_custom::function_5638f689(#"zmshielddurability")) {
    case 0:
        level.var_f1474f7e *= 2;
        break;
    case 1:
    default:
        level.var_f1474f7e *= 1;
        break;
    case 2:
        level.var_f1474f7e *= 0.5;
        break;
    }
    level.var_f1474f7e *= zombie_utility::get_zombie_var(#"hash_cc85b961f25c2ff");
    damagemax = int(weapon.weaponstarthitpoints);
    shieldhealth = self damageriotshield(0);
    shieldhealth = self damageriotshield(shieldhealth - damagemax);
    self updateriotshieldmodel();
    self clientfield::set_player_uimodel("ZMInventoryPersonal.shield_health", 1);
    self.var_dc5406eb = undefined;
    if (var_ec4870b4) {
        self givemaxammo(weapon);
    }
    return true;
}

// Namespace riotshield/zm_weap_riotshield
// Params 2, eflags: 0x0
// Checksum 0x8a716bf2, Offset: 0x978
// Size: 0x54
function player_set_shield_health(damage, max_damage) {
    self updateriotshieldmodel();
    self clientfield::set_player_uimodel("ZMInventoryPersonal.shield_health", damage / max_damage);
}

// Namespace riotshield/zm_weap_riotshield
// Params 0, eflags: 0x0
// Checksum 0xa3451612, Offset: 0x9d8
// Size: 0x1ac
function function_aa012a4a() {
    level endon(#"game_ended");
    while (true) {
        s_waitresult = level waittill(#"carpenter_started");
        if (zm_powerups::function_ffd24ecc(#"carpenter") && isplayer(s_waitresult.var_b5a9d4)) {
            if (isdefined(s_waitresult.var_b5a9d4.hasriotshield) && s_waitresult.var_b5a9d4.hasriotshield && isdefined(s_waitresult.var_b5a9d4.player_shield_reset_health)) {
                s_waitresult.var_b5a9d4 [[ s_waitresult.var_b5a9d4.player_shield_reset_health ]]();
            }
            continue;
        }
        foreach (e_player in level.players) {
            if (isdefined(e_player.hasriotshield) && e_player.hasriotshield && isdefined(e_player.player_shield_reset_health)) {
                e_player [[ e_player.player_shield_reset_health ]]();
            }
        }
    }
}

// Namespace riotshield/zm_weap_riotshield
// Params 4, eflags: 0x0
// Checksum 0xd2686c0c, Offset: 0xb90
// Size: 0x24
function player_shield_absorb_damage(eattacker, idamage, shitloc, smeansofdeath) {
    
}

// Namespace riotshield/zm_weap_riotshield
// Params 1, eflags: 0x0
// Checksum 0x9e62b5bb, Offset: 0xbc0
// Size: 0xc
function callback_playershielddamageblocked(damage) {
    
}

// Namespace riotshield/zm_weap_riotshield
// Params 3, eflags: 0x0
// Checksum 0x982baa2c, Offset: 0xbd8
// Size: 0x128
function player_shield_facing_attacker(vdir, limit, attacker) {
    orientation = self getplayerangles();
    forwardvec = anglestoforward(orientation);
    forwardvec2d = (forwardvec[0], forwardvec[1], 0);
    unitforwardvec2d = vectornormalize(forwardvec2d);
    tofaceevec = attacker.origin - self.origin;
    tofaceevec2d = (tofaceevec[0], tofaceevec[1], 0);
    unittofaceevec2d = vectornormalize(tofaceevec2d);
    dotproduct = vectordot(unitforwardvec2d, unittofaceevec2d);
    return dotproduct > limit;
}

// Namespace riotshield/zm_weap_riotshield
// Params 10, eflags: 0x0
// Checksum 0xed98ba92, Offset: 0xd08
// Size: 0x192
function should_shield_absorb_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    if (isdefined(self.hasriotshield) && self.hasriotshield && isdefined(vdir)) {
        if (isdefined(eattacker) && issentient(eattacker)) {
            if (isdefined(self.hasriotshieldequipped) && self.hasriotshieldequipped) {
                if (self hasperk(#"specialty_shield") || self player_shield_facing_attacker(vdir, 0.2, eattacker)) {
                    return 1;
                }
            } else if (!isdefined(self.riotshieldentity)) {
                if (!self player_shield_facing_attacker(vdir, -0.2, eattacker)) {
                    return zombie_utility::get_zombie_var(#"riotshield_stowed_block_fraction");
                }
            } else {
                assert(!isdefined(self.riotshieldentity), "<dev string:x30>");
            }
        }
    }
    return 0;
}

// Namespace riotshield/zm_weap_riotshield
// Params 10, eflags: 0x0
// Checksum 0xb243c1e, Offset: 0xea8
// Size: 0x1aa
function player_damage_override_callback(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    friendly_fire = isdefined(eattacker) && eattacker.team === self.team;
    if (isdefined(self.hasriotshield) && self.hasriotshield && !friendly_fire) {
        fblockfraction = self [[ level.should_shield_absorb_damage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
        if (fblockfraction > 0 && isdefined(self.player_shield_apply_damage)) {
            iblocked = int(fblockfraction * idamage);
            iunblocked = idamage - iblocked;
            if (isdefined(self.player_shield_apply_damage)) {
                self [[ self.player_shield_apply_damage ]](iblocked, 0, shitloc == "riotshield", smeansofdeath);
                if (isdefined(self.riotshield_damage_absorb_callback)) {
                    self [[ self.riotshield_damage_absorb_callback ]](eattacker, iblocked, shitloc, smeansofdeath);
                }
            }
            return iunblocked;
        }
    }
    return -1;
}

// Namespace riotshield/zm_weap_riotshield
// Params 4, eflags: 0x0
// Checksum 0x23186943, Offset: 0x1060
// Size: 0x24c
function player_damage_shield(idamage, bheld, fromcode = 0, smod = "MOD_UNKNOWN") {
    if (!isdefined(self.var_68b7cddc)) {
        self.var_68b7cddc = 0;
    }
    damagemax = level.weaponriotshield.weaponstarthitpoints;
    if (isdefined(self.weaponriotshield)) {
        damagemax = self.weaponriotshield.weaponstarthitpoints;
    }
    shieldhealth = damagemax;
    shielddamage = int((idamage - self.var_68b7cddc) * level.var_f1474f7e);
    shielddamage = int(max(shielddamage, 0));
    if (fromcode) {
        shielddamage = 0;
    }
    shieldhealth = self damageriotshield(shielddamage);
    self.var_dc5406eb = 1;
    if (shieldhealth <= 0) {
        if (isdefined(self.var_8c31eb8b)) {
            self thread [[ self.var_8c31eb8b ]]();
        }
        self clientfield::increment_to_player("zm_shield_break_rumble");
        self zm_audio::create_and_play_dialog("shield", "destroy");
        self thread player_take_riotshield();
    } else {
        self clientfield::increment_to_player("zm_shield_damage_rumble");
        self playsound(#"fly_riotshield_zm_impact_zombies");
    }
    self updateriotshieldmodel();
    self clientfield::set_player_uimodel("ZMInventoryPersonal.shield_health", shieldhealth / damagemax);
}

// Namespace riotshield/zm_weap_riotshield
// Params 12, eflags: 0x0
// Checksum 0x520b3722, Offset: 0x12b8
// Size: 0x11c
function function_1bb22fec(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (weapon.isriotshield && meansofdeath != "MOD_MELEE" && meansofdeath != "MOD_IMPACT" && meansofdeath != "MOD_ELECTROCUTED") {
        var_61133152 = damage + damage * 0.2 * math::clamp(level.round_number - 10, 0, 20);
        return var_61133152;
    }
    return -1;
}

// Namespace riotshield/zm_weap_riotshield
// Params 0, eflags: 0x0
// Checksum 0x6c131583, Offset: 0x13e0
// Size: 0xd0
function player_watch_weapon_change() {
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"weapon_change");
        self updateriotshieldmodel();
        damagemax = level.weaponriotshield.weaponstarthitpoints;
        if (isdefined(self.weaponriotshield) && self.weaponriotshield != level.weaponnone) {
            damagemax = self.weaponriotshield.weaponstarthitpoints;
        }
        shieldhealth = self.weaponhealth;
        self clientfield::set_player_uimodel("ZMInventoryPersonal.shield_health", shieldhealth / damagemax);
    }
}

// Namespace riotshield/zm_weap_riotshield
// Params 0, eflags: 0x0
// Checksum 0x6950a3a4, Offset: 0x14b8
// Size: 0x6c
function player_watch_shield_melee() {
    self endon(#"disconnect");
    for (;;) {
        waitresult = self waittill(#"weapon_melee");
        if (waitresult.weapon.isriotshield) {
            self [[ level.riotshield_melee ]](waitresult.weapon);
        }
    }
}

// Namespace riotshield/zm_weap_riotshield
// Params 0, eflags: 0x0
// Checksum 0x170ab0cd, Offset: 0x1530
// Size: 0x6c
function player_watch_shield_melee_power() {
    self endon(#"disconnect");
    for (;;) {
        waitresult = self waittill(#"weapon_melee_power");
        if (waitresult.weapon.isriotshield) {
            self [[ level.riotshield_melee_power ]](waitresult.weapon);
        }
    }
}

// Namespace riotshield/zm_weap_riotshield
// Params 3, eflags: 0x0
// Checksum 0xf427b1e6, Offset: 0x15a8
// Size: 0x14c
function riotshield_fling_zombie(player, fling_vec, index) {
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    if (isdefined(self.ignore_riotshield) && self.ignore_riotshield) {
        return;
    }
    if (isdefined(self.var_7430d3e0)) {
        self [[ self.var_7430d3e0 ]](player);
        return;
    }
    self zm_score::function_96865aad();
    self.var_b7fcaf8e = 0;
    self dodamage(3000, player.origin, player, player, "", "MOD_IMPACT");
    if (self.health < 1 || player zm_powerups::is_insta_kill_active()) {
        self.var_9ff8b6fb = 1;
        self startragdoll(1);
        self launchragdoll(fling_vec);
    }
}

// Namespace riotshield/zm_weap_riotshield
// Params 2, eflags: 0x0
// Checksum 0x39a4f099, Offset: 0x1700
// Size: 0x15c
function riotshield_knockdown_zombie(player, gib) {
    self endon(#"death");
    playsoundatposition(#"vox_riotshield_forcehit", self.origin);
    playsoundatposition(#"wpn_riotshield_proj_impact", self.origin);
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    self zombie_utility::setup_zombie_knockdown(player);
    if (gib) {
        self.a.gib_ref = array::random(level.riotshield_gib_refs);
        self thread zombie_death::do_gib();
    }
    self dodamage(zombie_utility::get_zombie_var(#"hash_682e9c2200af273b"), player.origin, player);
    self playsound(#"fly_riotshield_forcehit");
}

// Namespace riotshield/zm_weap_riotshield
// Params 0, eflags: 0x0
// Checksum 0xaf182f57, Offset: 0x1868
// Size: 0x73e
function riotshield_get_enemies_in_range() {
    view_pos = self geteye();
    zombies = array::get_all_closest(view_pos, getaiteamarray(level.zombie_team), undefined, undefined, 2 * zombie_utility::get_zombie_var(#"riotshield_knockdown_range"));
    if (!isdefined(zombies)) {
        return;
    }
    knockdown_range_squared = zombie_utility::get_zombie_var(#"riotshield_knockdown_range") * zombie_utility::get_zombie_var(#"riotshield_knockdown_range");
    gib_range_squared = zombie_utility::get_zombie_var(#"riotshield_gib_range") * zombie_utility::get_zombie_var(#"riotshield_gib_range");
    fling_range_squared = zombie_utility::get_zombie_var(#"riotshield_fling_range") * zombie_utility::get_zombie_var(#"riotshield_fling_range");
    cylinder_radius_squared = zombie_utility::get_zombie_var(#"riotshield_cylinder_radius") * zombie_utility::get_zombie_var(#"riotshield_cylinder_radius");
    fling_force = zombie_utility::get_zombie_var(#"riotshield_fling_force_melee");
    fling_force_v = 0.5;
    forward_view_angles = self getweaponforwarddir();
    end_pos = view_pos + vectorscale(forward_view_angles, zombie_utility::get_zombie_var(#"riotshield_knockdown_range"));
    /#
        if (2 == getdvarint(#"scr_riotshield_debug", 0)) {
            near_circle_pos = view_pos + vectorscale(forward_view_angles, 2);
            circle(near_circle_pos, zombie_utility::get_zombie_var(#"riotshield_cylinder_radius"), (1, 0, 0), 0, 0, 100);
            line(near_circle_pos, end_pos, (0, 0, 1), 1, 0, 100);
            circle(end_pos, zombie_utility::get_zombie_var(#"riotshield_cylinder_radius"), (1, 0, 0), 0, 0, 100);
        }
    #/
    for (i = 0; i < zombies.size; i++) {
        if (!isdefined(zombies[i]) || !isalive(zombies[i])) {
            continue;
        }
        test_origin = zombies[i] getcentroid();
        test_range_squared = distancesquared(view_pos, test_origin);
        if (test_range_squared > knockdown_range_squared) {
            return;
        }
        normal = vectornormalize(test_origin - view_pos);
        dot = vectordot(forward_view_angles, normal);
        if (0 > dot) {
            continue;
        }
        radial_origin = pointonsegmentnearesttopoint(view_pos, end_pos, test_origin);
        if (distancesquared(test_origin, radial_origin) > cylinder_radius_squared) {
            continue;
        }
        if (0 == zombies[i] damageconetrace(view_pos, self)) {
            continue;
        }
        if (zombies[i].var_29ed62b2 == #"basic") {
            if (test_range_squared < fling_range_squared) {
                level.riotshield_fling_enemies[level.riotshield_fling_enemies.size] = zombies[i];
                dist_mult = (fling_range_squared - test_range_squared) / fling_range_squared;
                fling_vec = vectornormalize(test_origin - view_pos);
                if (5000 < test_range_squared) {
                    fling_vec += vectornormalize(test_origin - radial_origin);
                }
                fling_vec = (fling_vec[0], fling_vec[1], fling_force_v * abs(fling_vec[2]));
                fling_vec = vectorscale(fling_vec, fling_force + fling_force * dist_mult);
                level.riotshield_fling_vecs[level.riotshield_fling_vecs.size] = fling_vec;
            }
        } else if ((zombies[i].var_29ed62b2 == #"heavy" || zombies[i].var_29ed62b2 == #"miniboss") && self hasperk(#"specialty_mod_shield")) {
            level.riotshield_knockdown_enemies[level.riotshield_knockdown_enemies.size] = zombies[i];
            level.riotshield_knockdown_gib[level.riotshield_knockdown_gib.size] = 0;
        }
        if (zombies[i].var_29ed62b2 == #"popcorn") {
            if (test_range_squared < fling_range_squared) {
                zombies[i] dodamage(zombies[i].health + 100, self.origin, self, self, "", "MOD_IMPACT");
            }
        }
    }
}

// Namespace riotshield/zm_weap_riotshield
// Params 0, eflags: 0x0
// Checksum 0x39b08b07, Offset: 0x1fb0
// Size: 0x54
function function_cea518ee() {
    level.var_75bba292++;
    if (!(level.var_75bba292 % 10)) {
        util::wait_network_frame();
        util::wait_network_frame();
        util::wait_network_frame();
    }
}

// Namespace riotshield/zm_weap_riotshield
// Params 1, eflags: 0x0
// Checksum 0xd63848f5, Offset: 0x2010
// Size: 0x214
function riotshield_melee(weapon) {
    if (!isdefined(level.riotshield_knockdown_enemies)) {
        level.riotshield_knockdown_enemies = [];
        level.riotshield_knockdown_gib = [];
        level.riotshield_fling_enemies = [];
        level.riotshield_fling_vecs = [];
    }
    self riotshield_get_enemies_in_range();
    shield_damage = 0;
    level.var_75bba292 = 0;
    for (i = 0; i < level.riotshield_fling_enemies.size; i++) {
        function_cea518ee();
        if (isdefined(level.riotshield_fling_enemies[i])) {
            level.riotshield_fling_enemies[i] thread riotshield_fling_zombie(self, level.riotshield_fling_vecs[i], i);
            shield_damage += zombie_utility::get_zombie_var(#"riotshield_fling_damage_shield");
        }
    }
    for (i = 0; i < level.riotshield_knockdown_enemies.size; i++) {
        function_cea518ee();
        level.riotshield_knockdown_enemies[i] thread riotshield_knockdown_zombie(self, level.riotshield_knockdown_gib[i]);
        shield_damage += zombie_utility::get_zombie_var(#"riotshield_knockdown_damage_shield");
    }
    level.riotshield_knockdown_enemies = [];
    level.riotshield_knockdown_gib = [];
    level.riotshield_fling_enemies = [];
    level.riotshield_fling_vecs = [];
    if (shield_damage) {
        self player_damage_shield(shield_damage, 0);
    }
}

// Namespace riotshield/zm_weap_riotshield
// Params 0, eflags: 0x0
// Checksum 0x23305ee6, Offset: 0x2230
// Size: 0x1cc
function updateriotshieldmodel() {
    waitframe(1);
    self.hasriotshield = 0;
    self.weaponriotshield = level.weaponnone;
    foreach (weapon in self getweaponslist(1)) {
        if (weapon.isriotshield) {
            level.var_336e4c03 = 1;
            self.hasriotshield = 1;
            self.weaponriotshield = weapon;
            break;
        }
    }
    current = self getcurrentweapon();
    self.hasriotshieldequipped = current.isriotshield;
    if (self.hasriotshield) {
        if (self.hasriotshieldequipped) {
            self zm_weapons::clear_stowed_weapon();
            if (isdefined(level.var_ef455672)) {
                self [[ level.var_ef455672 ]]();
            }
        } else {
            self zm_weapons::set_stowed_weapon(self.weaponriotshield);
            if (isdefined(level.var_e551c78f)) {
                self [[ level.var_e551c78f ]]();
            }
        }
    } else {
        self zm_weapons::clear_stowed_weapon();
    }
    self refreshshieldattachment();
}

// Namespace riotshield/zm_weap_riotshield
// Params 0, eflags: 0x0
// Checksum 0x487ba20e, Offset: 0x2408
// Size: 0xda
function player_take_riotshield() {
    self notify(#"destroy_riotshield");
    self function_8aeed162();
    self playsoundtoplayer(#"hash_560e1cb348d4600f", self);
    weapon = level.weaponriotshield;
    if (isdefined(self.weaponriotshield)) {
        weapon = self.weaponriotshield;
    }
    if (zm_equipment::is_equipment(weapon)) {
        self zm_equipment::take(weapon);
    } else {
        self zm_weapons::weapon_take(weapon);
    }
    self.hasriotshield = 0;
    self.hasriotshieldequipped = 0;
    self.var_dc5406eb = undefined;
}

// Namespace riotshield/zm_weap_riotshield
// Params 0, eflags: 0x0
// Checksum 0x3c2824c8, Offset: 0x24f0
// Size: 0x17a
function function_8aeed162() {
    current = self getcurrentweapon();
    if (current.isriotshield) {
        if (!self laststand::player_is_in_laststand()) {
            new_primary = level.weaponnone;
            primaryweapons = self getweaponslistprimaries();
            for (i = 0; i < primaryweapons.size; i++) {
                if (!primaryweapons[i].isriotshield) {
                    new_primary = primaryweapons[i];
                    break;
                }
            }
            if (new_primary == level.weaponnone) {
                self zm_weapons::give_fallback_weapon();
                self switchtoweaponimmediate();
                self playsound(#"wpn_riotshield_zm_destroy");
                return;
            }
            self switchtoweaponimmediate();
            self playsound(#"wpn_riotshield_zm_destroy");
            self waittill(#"weapon_change");
        }
    }
}

