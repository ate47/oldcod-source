#using scripts\core_common\struct;
#using scripts\killstreaks\killstreaks_shared;

#namespace killstreak_bundles;

// Namespace killstreak_bundles/killstreak_bundles
// Params 1, eflags: 0x0
// Checksum 0xafbf031, Offset: 0x190
// Size: 0x1a
function spawned(bundle) {
    self.var_22a05c26 = bundle;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0xede0418, Offset: 0x1b8
// Size: 0xa
function function_48e9536e() {
    return self.var_22a05c26;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0x8aed3461, Offset: 0x1d0
// Size: 0x22
function get_hack_timeout() {
    return level.killstreaks[self.killstreaktype].script_bundle.kshacktimeout;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0xcb8f8ab3, Offset: 0x200
// Size: 0x4c
function get_hack_protection() {
    return isdefined(level.killstreaks[self.killstreaktype].script_bundle.kshackprotection) ? level.killstreaks[self.killstreaktype].script_bundle.kshackprotection : 0;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0xc9a03717, Offset: 0x258
// Size: 0x4e
function get_hack_tool_inner_time() {
    return isdefined(level.killstreaks[self.killstreaktype].script_bundle.kshacktoolinnertime) ? level.killstreaks[self.killstreaktype].script_bundle.kshacktoolinnertime : 10000;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0x651cfe7, Offset: 0x2b0
// Size: 0x4e
function get_hack_tool_outer_time() {
    return isdefined(level.killstreaks[self.killstreaktype].script_bundle.kshacktooloutertime) ? level.killstreaks[self.killstreaktype].script_bundle.kshacktooloutertime : 10000;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0xbdcbfa64, Offset: 0x308
// Size: 0x4e
function get_hack_tool_inner_radius() {
    return isdefined(level.killstreaks[self.killstreaktype].script_bundle.kshacktoolinnerradius) ? level.killstreaks[self.killstreaktype].script_bundle.kshacktoolinnerradius : 10000;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0x2717771a, Offset: 0x360
// Size: 0x4e
function get_hack_tool_outer_radius() {
    return isdefined(level.killstreaks[self.killstreaktype].script_bundle.kshacktoolouterradius) ? level.killstreaks[self.killstreaktype].script_bundle.kshacktoolouterradius : 10000;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0x6c74fa9b, Offset: 0x3b8
// Size: 0x4e
function get_lost_line_of_sight_limit_msec() {
    return isdefined(level.killstreaks[self.killstreaktype].script_bundle.kshacktoollostlineofsightlimitms) ? level.killstreaks[self.killstreaktype].script_bundle.kshacktoollostlineofsightlimitms : 1000;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0xf248aeb3, Offset: 0x410
// Size: 0x4e
function get_hack_tool_no_line_of_sight_time() {
    return isdefined(level.killstreaks[self.killstreaktype].script_bundle.kshacktoolnolineofsighttime) ? level.killstreaks[self.killstreaktype].script_bundle.kshacktoolnolineofsighttime : 1000;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0xe9f81d9a, Offset: 0x468
// Size: 0x4c
function get_hack_scoreevent() {
    return isdefined(level.killstreaks[self.killstreaktype].script_bundle.kshackscoreevent) ? level.killstreaks[self.killstreaktype].script_bundle.kshackscoreevent : undefined;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0x7f02f6e9, Offset: 0x4c0
// Size: 0x52
function get_hack_fx() {
    return isdefined(level.killstreaks[self.killstreaktype].script_bundle.kshackfx) ? level.killstreaks[self.killstreaktype].script_bundle.kshackfx : "";
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0xa7a49690, Offset: 0x520
// Size: 0x52
function get_hack_loop_fx() {
    return isdefined(level.killstreaks[self.killstreaktype].script_bundle.kshackloopfx) ? level.killstreaks[self.killstreaktype].script_bundle.kshackloopfx : "";
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 1, eflags: 0x0
// Checksum 0x2940600e, Offset: 0x580
// Size: 0x36
function get_max_health(killstreaktype) {
    bundle = killstreaks::get_script_bundle(killstreaktype);
    return bundle.kshealth;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 1, eflags: 0x0
// Checksum 0xaac9c643, Offset: 0x5c0
// Size: 0x36
function get_low_health(killstreaktype) {
    bundle = killstreaks::get_script_bundle(killstreaktype);
    return bundle.kslowhealth;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 1, eflags: 0x0
// Checksum 0x352eaf7a, Offset: 0x600
// Size: 0x36
function get_hacked_health(killstreaktype) {
    bundle = killstreaks::get_script_bundle(killstreaktype);
    return bundle.kshackedhealth;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 3, eflags: 0x0
// Checksum 0x2b6ceeea, Offset: 0x640
// Size: 0x494
function get_shots_to_kill(weapon, meansofdeath, bundle) {
    shotstokill = undefined;
    switch (weapon.rootweapon.name) {
    case #"remote_missile_missile":
        shotstokill = bundle.ksremote_missile_missile;
        break;
    case #"hero_annihilator":
        shotstokill = bundle.kshero_annihilator;
        break;
    case #"eq_gravityslam":
        shotstokill = bundle.kshero_gravityspikes;
        break;
    case #"shock_rifle":
        shotstokill = bundle.var_4be7d629;
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
        shotstokill = bundle.var_8eca21ba;
        break;
    case #"ability_dog":
        shotstokill = bundle.var_a758f9e6;
        break;
    case #"planemortar":
        shotstokill = bundle.var_843b7bd3;
        break;
    case #"jetfighter_missile":
        shotstokill = 1;
        break;
    case #"gadget_heat_wave":
        shotstokill = bundle.kshero_heatwave;
        break;
    case #"hero_flamethrower":
        if (is_true(bundle.var_2db988a0)) {
            shotstokill = 1;
        } else {
            shotstokill = bundle.var_2e48926e;
        }
        break;
    case #"eq_concertina_wire":
        if (is_true(bundle.var_ab14c65a)) {
            shotstokill = 1;
        }
        break;
    case #"ability_smart_cover":
        if (is_true(bundle.var_4de0b9db)) {
            shotstokill = 1;
        } else {
            shotstokill = bundle.var_9efbc14a;
        }
        break;
    case #"hash_17df39d53492b0bf":
        shotstokill = bundle.var_605815a6;
        break;
    case #"hash_7b24d0d0d2823bca":
        shotstokill = bundle.var_50c51e5;
        break;
    case #"ac130_chaingun":
        shotstokill = bundle.var_676a4c7;
        break;
    case #"eq_tripwire":
        shotstokill = bundle.var_8f65bc5d;
        break;
    case #"hatchet":
        shotstokill = bundle.var_8ca2602b;
        break;
    case #"eq_emp_grenade":
        shotstokill = bundle.ksempgrenadestokill;
        break;
    case #"sig_blade":
        shotstokill = bundle.var_5789ac76;
        break;
    case #"hash_180035d2349984a1":
        shotstokill = bundle.var_1a2b2555;
        break;
    }
    if (!isdefined(shotstokill)) {
        switch (weapon.statname) {
        case #"hero_bowlauncher":
        case #"sig_bow_flame":
            if (meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_GRENADE_SPLASH") {
                shotstokill = bundle.kshero_bowlauncher;
            } else {
                shotstokill = -1;
            }
            break;
        }
    }
    return isdefined(shotstokill) ? shotstokill : 0;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 2, eflags: 0x0
// Checksum 0xe54c1322, Offset: 0xae0
// Size: 0xa8
function get_emp_grenade_damage(killstreaktype, maxhealth) {
    emp_weapon_damage = undefined;
    bundle = killstreaks::get_script_bundle(killstreaktype);
    if (bundle) {
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
// Checksum 0xd1cb1383, Offset: 0xb90
// Size: 0x6a
function function_daad16b8(maxhealth, weapon_damage, var_8cef04) {
    var_8cef04 = isdefined(var_8cef04) ? var_8cef04 : 0;
    if (var_8cef04 == 0) {
    } else if (var_8cef04 > 0) {
        weapon_damage = maxhealth / var_8cef04 + 1;
    } else {
        weapon_damage = 0;
    }
    return weapon_damage;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 2, eflags: 0x0
// Checksum 0x75bb6af, Offset: 0xc08
// Size: 0x52
function function_14bd8ba5(damage, damage_multiplier) {
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
// Checksum 0x6e92c7cd, Offset: 0xc68
// Size: 0x52
function function_6bacfedc(weapon, levelweapon) {
    return isdefined(levelweapon) && weapon.statname == levelweapon.statname && levelweapon.statname != level.weaponnone.statname;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 2, eflags: 0x0
// Checksum 0xd590fd43, Offset: 0xcc8
// Size: 0x52
function function_90509610(weapon, levelweapon) {
    return isdefined(levelweapon) && weapon.name == levelweapon.name && levelweapon.statname != level.weaponnone.statname;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 8, eflags: 0x0
// Checksum 0xa1af5215, Offset: 0xd28
// Size: 0xa2
function get_weapon_damage(killstreaktype, maxhealth, attacker, weapon, type, damage, flags, chargeshotlevel) {
    weapon_damage = undefined;
    bundle = killstreaks::get_script_bundle(killstreaktype);
    if (isdefined(bundle)) {
        weapon_damage = function_dd7587e4(bundle, maxhealth, attacker, weapon, type, damage, flags, chargeshotlevel);
    }
    return weapon_damage;
}

// Namespace killstreak_bundles/killstreak_bundles
// Params 8, eflags: 0x0
// Checksum 0xd206d3b6, Offset: 0xdd8
// Size: 0x592
function function_dd7587e4(bundle, maxhealth, attacker, weapon, type, damage, *flags, chargeshotlevel) {
    weapon_damage = undefined;
    if (isdefined(maxhealth)) {
        if (isdefined(type)) {
            shotstokill = get_shots_to_kill(type, damage, maxhealth);
            if (shotstokill == 0) {
            } else if (shotstokill > 0) {
                if (isdefined(chargeshotlevel) && chargeshotlevel > 0) {
                    shotstokill /= chargeshotlevel;
                }
                weapon_damage = attacker / shotstokill + 1;
            } else {
                weapon_damage = 0;
            }
        }
        if (!isdefined(weapon_damage)) {
            if (damage == "MOD_RIFLE_BULLET" || damage == "MOD_PISTOL_BULLET" || damage == "MOD_HEAD_SHOT") {
                hasarmorpiercing = isdefined(weapon) && isplayer(weapon) && weapon hasperk(#"specialty_armorpiercing");
                clipstokill = isdefined(maxhealth.ksclipstokill) ? maxhealth.ksclipstokill : 0;
                if (clipstokill == -1) {
                    weapon_damage = 0;
                } else if (hasarmorpiercing && self.aitype !== "spawner_bo3_robot_grunt_assault_mp_escort") {
                    weapon_damage = flags + int(flags * level.cac_armorpiercing_data);
                }
                if (type.weapclass == "spread") {
                    ksshotgunmultiplier = isdefined(maxhealth.ksshotgunmultiplier) ? maxhealth.ksshotgunmultiplier : 1;
                    if (ksshotgunmultiplier == 0) {
                    } else if (ksshotgunmultiplier > 0) {
                        weapon_damage = (isdefined(weapon_damage) ? weapon_damage : flags) * ksshotgunmultiplier;
                    }
                }
            } else if (damage == "MOD_IMPACT") {
                if (isdefined(level.shockrifleweapon) && function_6bacfedc(type, level.shockrifleweapon)) {
                    var_108f064f = isdefined(maxhealth.var_4be7d629) ? maxhealth.var_4be7d629 : 0;
                    if (var_108f064f == 0) {
                    } else if (var_108f064f > 0) {
                        weapon_damage = attacker / var_108f064f + 1;
                    } else {
                        weapon_damage = 0;
                    }
                }
            } else if (type.var_7f292fed === 1 && (damage == "MOD_PROJECTILE" || damage == "MOD_EXPLOSIVE" || damage == "MOD_PROJECTILE_SPLASH" && maxhealth.var_38de4989 === 1)) {
                if (function_6bacfedc(type, level.weaponshotgunenergy)) {
                    weapon_damage = function_daad16b8(attacker, weapon_damage, maxhealth.ksshotgunenergytokill);
                } else {
                    rocketstokill = isdefined(maxhealth.ksrocketstokill) ? maxhealth.ksrocketstokill : 0;
                    if (level.competitivesettingsenabled && maxhealth.var_391f7118 !== 0) {
                        rocketstokill = maxhealth.var_391f7118;
                    }
                    if (rocketstokill == 0) {
                    } else if (rocketstokill > 0) {
                        if (type.rootweapon.name == "launcher_multi" || type.rootweapon.name == #"hash_2de6f2fb4eb1529") {
                            rocketstokill *= 2;
                        }
                        weapon_damage = attacker / rocketstokill + 1;
                    } else {
                        weapon_damage = 0;
                    }
                }
            } else if ((damage == "MOD_GRENADE" || damage == "MOD_GRENADE_SPLASH") && (!isdefined(type.isempkillstreak) || !type.isempkillstreak)) {
                weapon_damage = function_14bd8ba5(flags, maxhealth.ksgrenadedamagemultiplier);
            } else if (damage == "MOD_MELEE_WEAPON_BUTT" || damage == "MOD_MELEE") {
                weapon_damage = function_14bd8ba5(flags, maxhealth.ksmeleedamagemultiplier);
            } else if (damage == "MOD_PROJECTILE_SPLASH") {
                weapon_damage = function_14bd8ba5(flags, maxhealth.ksprojectilespashmultiplier);
            }
        }
    }
    return weapon_damage;
}

