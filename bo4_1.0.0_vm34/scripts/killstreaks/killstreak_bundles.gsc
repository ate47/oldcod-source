#using scripts\core_common\struct;

#namespace killstreak_bundles;

// Namespace killstreak_bundles/killstreak_bundles
// Params 1, eflags: 0x0
// Checksum 0xb8c4017a, Offset: 0x1a0
// Size: 0xac
function register_killstreak_bundle(type) {
    level.killstreakbundle[type] = struct::get_script_bundle("killstreak", "killstreak_" + type);
    level.killstreakbundle["inventory_" + type] = level.killstreakbundle[type];
    level.killstreakmaxhealthfunction = &get_max_health;
    assert(isdefined(level.killstreakbundle[type]));
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 2, eflags: 0x0
// Checksum 0x8c2ad8f0, Offset: 0x258
// Size: 0x6c
function register_bundle(type, bundle) {
    level.killstreakbundle[type] = bundle;
    level.killstreakmaxhealthfunction = &get_max_health;
    assert(isdefined(level.killstreakbundle[type]));
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 1, eflags: 0x0
// Checksum 0x75d4eb81, Offset: 0x2d0
// Size: 0xaa
function get_bundle(killstreak) {
    if (killstreak.archetype === "raps") {
        return level.killstreakbundle[#"raps_drone"];
    }
    if (killstreak.killstreaktype === "drone_squadron" && sessionmodeiscampaigngame()) {
        return level.killstreakbundle["drone_squadron" + "_cp"];
    }
    return level.killstreakbundle[killstreak.killstreaktype];
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 1, eflags: 0x0
// Checksum 0x519868d8, Offset: 0x388
// Size: 0x1a
function spawned(bundle) {
    self.var_63a22f1e = bundle;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0x56e3c783, Offset: 0x3b0
// Size: 0xa
function function_bf8322cd() {
    return self.var_63a22f1e;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0xe6cf9c0a, Offset: 0x3c8
// Size: 0x22
function get_hack_timeout() {
    return get_bundle(self).kshacktimeout;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0x75bf1ac0, Offset: 0x3f8
// Size: 0x48
function get_hack_protection() {
    return isdefined(get_bundle(self).kshackprotection) ? get_bundle(self).kshackprotection : 0;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0xd9c4a89d, Offset: 0x448
// Size: 0x4a
function get_hack_tool_inner_time() {
    return isdefined(get_bundle(self).kshacktoolinnertime) ? get_bundle(self).kshacktoolinnertime : 10000;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0x5ae27227, Offset: 0x4a0
// Size: 0x4a
function get_hack_tool_outer_time() {
    return isdefined(get_bundle(self).kshacktooloutertime) ? get_bundle(self).kshacktooloutertime : 10000;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0x4a3f267c, Offset: 0x4f8
// Size: 0x4a
function get_hack_tool_inner_radius() {
    return isdefined(get_bundle(self).kshacktoolinnerradius) ? get_bundle(self).kshacktoolinnerradius : 10000;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0x1a969feb, Offset: 0x550
// Size: 0x4a
function get_hack_tool_outer_radius() {
    return isdefined(get_bundle(self).kshacktoolouterradius) ? get_bundle(self).kshacktoolouterradius : 10000;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0x7c3c572b, Offset: 0x5a8
// Size: 0x4a
function get_lost_line_of_sight_limit_msec() {
    return isdefined(get_bundle(self).kshacktoollostlineofsightlimitms) ? get_bundle(self).kshacktoollostlineofsightlimitms : 1000;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0xdde7e6e0, Offset: 0x600
// Size: 0x4a
function get_hack_tool_no_line_of_sight_time() {
    return isdefined(get_bundle(self).kshacktoolnolineofsighttime) ? get_bundle(self).kshacktoolnolineofsighttime : 1000;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0x8ac84b72, Offset: 0x658
// Size: 0x48
function get_hack_scoreevent() {
    return isdefined(get_bundle(self).kshackscoreevent) ? get_bundle(self).kshackscoreevent : undefined;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0xcdefe7e7, Offset: 0x6a8
// Size: 0x4e
function get_hack_fx() {
    return isdefined(get_bundle(self).kshackfx) ? get_bundle(self).kshackfx : "";
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0x2dbf436, Offset: 0x700
// Size: 0x4e
function get_hack_loop_fx() {
    return isdefined(get_bundle(self).kshackloopfx) ? get_bundle(self).kshackloopfx : "";
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 1, eflags: 0x0
// Checksum 0x9c53d4d5, Offset: 0x758
// Size: 0x22
function get_max_health(killstreaktype) {
    return level.killstreakbundle[killstreaktype].kshealth;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 1, eflags: 0x0
// Checksum 0x89e63070, Offset: 0x788
// Size: 0x22
function get_low_health(killstreaktype) {
    return level.killstreakbundle[killstreaktype].kslowhealth;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 1, eflags: 0x0
// Checksum 0x37576e55, Offset: 0x7b8
// Size: 0x22
function get_hacked_health(killstreaktype) {
    return level.killstreakbundle[killstreaktype].kshackedhealth;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 3, eflags: 0x0
// Checksum 0xfdd8ad3b, Offset: 0x7e8
// Size: 0x3dc
function get_shots_to_kill(weapon, meansofdeath, bundle) {
    shotstokill = undefined;
    switch (weapon.rootweapon.name) {
    case #"remote_missile_missile":
        shotstokill = bundle.ksremote_missile_missile;
        break;
    case #"hero_annihilator":
        shotstokill = bundle.kshero_annihilator;
        break;
    case #"hero_armblade":
        shotstokill = bundle.kshero_armblade;
        break;
    case #"hero_bowlauncher2":
    case #"hero_bowlauncher3":
    case #"hero_bowlauncher4":
    case #"hero_bowlauncher":
        if (meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_PROJECTILE") {
            shotstokill = bundle.kshero_bowlauncher;
        } else {
            shotstokill = -1;
        }
        break;
    case #"eq_gravityslam":
        shotstokill = bundle.kshero_gravityspikes;
        break;
    case #"shock_rifle":
        shotstokill = bundle.var_e8dfe37b;
        break;
    case #"hero_minigun":
        shotstokill = bundle.kshero_minigun;
        break;
    case #"hero_pineapple_grenade":
    case #"hero_pineapplegun":
        shotstokill = bundle.kshero_pineapplegun;
        break;
    case #"hero_firefly_swarm":
        shotstokill = (isdefined(bundle.kshero_firefly_swarm) ? bundle.kshero_firefly_swarm : 0) * 4;
        break;
    case #"dart_blade":
    case #"dart_turret":
        shotstokill = bundle.ksdartstokill;
        break;
    case #"recon_car":
        shotstokill = bundle.var_c6c908f1;
        break;
    case #"ability_dog":
        shotstokill = bundle.var_c2b3e3e1;
        break;
    case #"planemortar":
        shotstokill = bundle.var_28cb88f2;
        break;
    case #"gadget_heat_wave":
        shotstokill = bundle.kshero_heatwave;
        break;
    case #"hero_flamethrower":
        if (isdefined(bundle.var_21309166) && bundle.var_21309166) {
            shotstokill = 1;
        } else {
            shotstokill = bundle.var_96fbccdc;
        }
        break;
    case #"eq_concertina_wire":
        if (isdefined(bundle.var_26a9bfed) && bundle.var_26a9bfed) {
            shotstokill = 1;
        }
        break;
    case #"ability_smart_cover":
        if (isdefined(bundle.var_dcc90d31) && bundle.var_dcc90d31) {
            shotstokill = 1;
        } else {
            var_8cb8bd25 = bundle.var_5f3902ff;
        }
        break;
    }
    return isdefined(shotstokill) ? shotstokill : 0;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 2, eflags: 0x0
// Checksum 0x553a2011, Offset: 0xbd0
// Size: 0xb8
function get_emp_grenade_damage(killstreaktype, maxhealth) {
    emp_weapon_damage = undefined;
    if (isdefined(level.killstreakbundle[killstreaktype])) {
        bundle = level.killstreakbundle[killstreaktype];
        empgrenadestokill = isdefined(bundle.ksempgrenadestokill) ? bundle.ksempgrenadestokill : 0;
        if (empgrenadestokill == 0) {
        } else if (empgrenadestokill > 0) {
            emp_weapon_damage = maxhealth / empgrenadestokill + 1;
        } else {
            emp_weapon_damage = 0;
        }
    }
    return emp_weapon_damage;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 3, eflags: 0x0
// Checksum 0xf0509eb3, Offset: 0xc90
// Size: 0x6e
function function_a440843b(maxhealth, weapon_damage, var_1ccb7c9d) {
    var_1ccb7c9d = isdefined(var_1ccb7c9d) ? var_1ccb7c9d : 0;
    if (var_1ccb7c9d == 0) {
    } else if (var_1ccb7c9d > 0) {
        weapon_damage = maxhealth / var_1ccb7c9d + 1;
    } else {
        weapon_damage = 0;
    }
    return weapon_damage;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 2, eflags: 0x0
// Checksum 0xded20429, Offset: 0xd08
// Size: 0x56
function function_9065ceb1(damage, damage_multiplier) {
    damage_multiplier = isdefined(damage_multiplier) ? damage_multiplier : 0;
    if (damage_multiplier == 0) {
        return undefined;
    } else if (damage_multiplier > 0) {
        return (damage * damage_multiplier);
    }
    return 0;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 2, eflags: 0x0
// Checksum 0x19e0301, Offset: 0xd68
// Size: 0x5a
function function_3af0bf3e(weapon, levelweapon) {
    return isdefined(levelweapon) && weapon.statname == levelweapon.statname && levelweapon.statname != level.weaponnone.statname;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 2, eflags: 0x0
// Checksum 0xd357f004, Offset: 0xdd0
// Size: 0x5a
function function_938072db(weapon, levelweapon) {
    return isdefined(levelweapon) && weapon.name == levelweapon.name && levelweapon.statname != level.weaponnone.statname;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 8, eflags: 0x0
// Checksum 0xb121bfb1, Offset: 0xe38
// Size: 0xba
function get_weapon_damage(killstreaktype, maxhealth, attacker, weapon, type, damage, flags, chargeshotlevel) {
    weapon_damage = undefined;
    if (isdefined(level.killstreakbundle[killstreaktype])) {
        bundle = level.killstreakbundle[killstreaktype];
        weapon_damage = function_9c163c89(bundle, maxhealth, attacker, weapon, type, damage, flags, chargeshotlevel);
    }
    return weapon_damage;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 8, eflags: 0x0
// Checksum 0x5c91669b, Offset: 0xf00
// Size: 0x682
function function_9c163c89(bundle, maxhealth, attacker, weapon, type, damage, flags, chargeshotlevel) {
    weapon_damage = undefined;
    if (isdefined(bundle)) {
        if (isdefined(weapon)) {
            shotstokill = get_shots_to_kill(weapon, type, bundle);
            if (shotstokill == 0) {
            } else if (shotstokill > 0) {
                if (isdefined(chargeshotlevel) && chargeshotlevel > 0) {
                    shotstokill /= chargeshotlevel;
                }
                weapon_damage = maxhealth / shotstokill + 1;
            } else {
                weapon_damage = 0;
            }
        }
        if (!isdefined(weapon_damage)) {
            if (type == "MOD_RIFLE_BULLET" || type == "MOD_PISTOL_BULLET" || type == "MOD_HEAD_SHOT") {
                hasarmorpiercing = isdefined(attacker) && isplayer(attacker) && attacker hasperk(#"specialty_armorpiercing");
                clipstokill = isdefined(bundle.ksclipstokill) ? bundle.ksclipstokill : 0;
                if (clipstokill == -1) {
                    weapon_damage = 0;
                } else if (hasarmorpiercing && self.aitype !== "spawner_bo3_robot_grunt_assault_mp_escort") {
                    weapon_damage = damage + int(damage * level.cac_armorpiercing_data);
                }
                if (weapon.weapclass == "spread") {
                    ksshotgunmultiplier = isdefined(bundle.ksshotgunmultiplier) ? bundle.ksshotgunmultiplier : 1;
                    if (ksshotgunmultiplier == 0) {
                    } else if (ksshotgunmultiplier > 0) {
                        weapon_damage = (isdefined(weapon_damage) ? weapon_damage : damage) * ksshotgunmultiplier;
                    }
                }
            } else if (type == "MOD_IMPACT" && isdefined(level.shockrifleweapon) && function_3af0bf3e(weapon, level.shockrifleweapon)) {
                var_16e49cc5 = isdefined(bundle.var_e8dfe37b) ? bundle.var_e8dfe37b : 0;
                if (var_16e49cc5 == 0) {
                } else if (var_16e49cc5 > 0) {
                    weapon_damage = maxhealth / var_16e49cc5 + 1;
                } else {
                    weapon_damage = 0;
                }
            } else if ((type == "MOD_PROJECTILE" || type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE_SPLASH" && bundle.var_687d7003 === 1) && (!isdefined(weapon.isempkillstreak) || !weapon.isempkillstreak) && (!isdefined(level.weaponpistolenergy) || weapon.statname != level.weaponpistolenergy.statname || level.weaponpistolenergy.statname == level.weaponnone.statname) && (!isdefined(level.weaponspecialcrossbow) || weapon.statname != level.weaponspecialcrossbow.statname || level.weaponspecialcrossbow.statname == level.weaponnone.statname)) {
                if (function_3af0bf3e(weapon, level.weaponshotgunenergy)) {
                    weapon_damage = function_a440843b(maxhealth, weapon_damage, bundle.ksshotgunenergytokill);
                } else if (function_938072db(weapon, level.var_f5c917fc)) {
                    weapon_damage = function_a440843b(maxhealth, weapon_damage, bundle.var_71f11202);
                } else {
                    rocketstokill = isdefined(bundle.ksrocketstokill) ? bundle.ksrocketstokill : 0;
                    if (rocketstokill == 0) {
                    } else if (rocketstokill > 0) {
                        if (weapon.rootweapon.name == "launcher_multi") {
                            rocketstokill *= 2;
                        }
                        weapon_damage = maxhealth / rocketstokill + 1;
                    } else {
                        weapon_damage = 0;
                    }
                }
            } else if ((type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH") && (!isdefined(weapon.isempkillstreak) || !weapon.isempkillstreak)) {
                weapon_damage = function_9065ceb1(damage, bundle.ksgrenadedamagemultiplier);
            } else if (type == "MOD_MELEE_WEAPON_BUTT" || type == "MOD_MELEE") {
                weapon_damage = function_9065ceb1(damage, bundle.ksmeleedamagemultiplier);
            } else if (type == "MOD_PROJECTILE_SPLASH") {
                weapon_damage = function_9065ceb1(damage, bundle.ksprojectilespashmultiplier);
            }
        }
    }
    return weapon_damage;
}

