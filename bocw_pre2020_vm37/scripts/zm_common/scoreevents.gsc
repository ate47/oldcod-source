#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_utility;

#namespace scoreevents;

// Namespace scoreevents/scoreevents
// Params 0, eflags: 0x6
// Checksum 0x66270cad, Offset: 0x350
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"scoreevents", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace scoreevents/scoreevents
// Params 0, eflags: 0x5 linked
// Checksum 0xee63d0cc, Offset: 0x398
// Size: 0x54
function private function_70a657d8() {
    registerscoreeventcallback("scoreEventZM", &scoreeventzm);
    registerscoreeventcallback("killingBlow", &function_970a97b2);
}

// Namespace scoreevents/scoreevents
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3f8
// Size: 0x4
function init() {
    
}

// Namespace scoreevents/scoreevents
// Params 1, eflags: 0x1 linked
// Checksum 0x5350f722, Offset: 0x408
// Size: 0x54
function scoreeventzm(params) {
    if (isdefined(params.scoreevent) && isdefined(params.attacker)) {
        processscoreevent(params.scoreevent, params.attacker);
    }
}

// Namespace scoreevents/scoreevents
// Params 1, eflags: 0x1 linked
// Checksum 0x376276bc, Offset: 0x468
// Size: 0x3ac
function function_970a97b2(params) {
    if (params.smeansofdeath === "MOD_MELEE") {
        processscoreevent("melee_killingblow_zm", params.eattacker);
    } else if (params.var_3fb48d9c === 1) {
        processscoreevent("headshot_killingblow_zm", params.eattacker);
    }
    switch (params.weapon.name) {
    case #"hatchet":
        processscoreevent("hatchet_killingblow_zm", params.eattacker);
        break;
    case #"frag_grenade":
        processscoreevent("frag_killingblow_zm", params.eattacker);
        break;
    case #"eq_sticky_grenade":
        processscoreevent("semtex_killingblow_zm", params.eattacker);
        break;
    case #"satchel_charge":
        processscoreevent("satchel_charge_killingblow_zm", params.eattacker);
        break;
    case #"cymbal_monkey":
        processscoreevent("monkey_bomb_killingblow_zm", params.eattacker);
        break;
    case #"molotov_fire":
        processscoreevent("molotov_killingblow_zm", params.eattacker);
        break;
    case #"eq_slow_grenade":
        processscoreevent("concussion_grenade_killingblow_zm", params.eattacker);
        break;
    }
    if (isdefined(params.enemy.var_716c0cc9[#"kill"])) {
        processscoreevent(params.enemy.var_716c0cc9[#"kill"], params.eattacker);
    }
    if (isplayer(params.eattacker) && params.eattacker isinvehicle()) {
        veh = params.eattacker getvehicleoccupied();
        if (veh getoccupantseat(params.eattacker) !== 0) {
            driver = veh getseatoccupant(0);
            if (isdefined(driver)) {
                processscoreevent("passenger_assist_zm", driver);
            }
        }
    }
    updatemultikill(params);
    function_f2ce8b86(params);
    function_513fa6e4(params.enemy, params.eattacker);
}

// Namespace scoreevents/scoreevents
// Params 4, eflags: 0x1 linked
// Checksum 0xcd93294f, Offset: 0x820
// Size: 0xfc
function function_82234b38(victim, attacker, weapon, meansofdeath) {
    if (!isdefined(victim.var_c2dcab66)) {
        victim.var_c2dcab66 = [];
    }
    if (zm_utility::is_player_valid(attacker, 0, 1)) {
        victim.var_c2dcab66[attacker getentitynumber()] = {#player:attacker, #time:gettime(), #weapon:weapon};
    }
    if (weapon.name === #"eq_slow_grenade" && meansofdeath !== "MOD_IMPACT") {
        processscoreevent("concussion_grenade_concussed_enemy_zm", attacker);
    }
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x1 linked
// Checksum 0x7a451a3b, Offset: 0x928
// Size: 0x66
function function_46e3cf42(zombie, player) {
    if (zm_utility::is_player_valid(player, 0, 1)) {
        zombie.var_9624a42c = {#player:player, #time:gettime()};
    }
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x1 linked
// Checksum 0xd7531cf7, Offset: 0x998
// Size: 0xa4
function function_513fa6e4(zombie, player) {
    if (isdefined(zombie.var_9624a42c)) {
        if (zm_utility::is_player_valid(zombie.var_9624a42c.player, 0, 1) && player !== zombie.var_9624a42c.player && zombie.var_9624a42c.time > gettime() - 10000) {
            processscoreevent("kill_enemy_injuring_teammate_zm", player);
        }
    }
}

// Namespace scoreevents/scoreevents
// Params 1, eflags: 0x1 linked
// Checksum 0x56330ffd, Offset: 0xa48
// Size: 0x360
function function_f2ce8b86(params) {
    if (isdefined(params.enemy.var_716c0cc9[#"assist"]) && isdefined(params.enemy.var_c2dcab66)) {
        foreach (var_c2dcab66 in params.enemy.var_c2dcab66) {
            if (zm_utility::is_player_valid(var_c2dcab66.player, 0, 1) && var_c2dcab66.time > gettime() - 10000 && (is_true(params.enemy.var_7b22b800) || var_c2dcab66.player != params.eattacker)) {
                if (var_c2dcab66.player !== params.eattacker) {
                    function_4ffff5df(var_c2dcab66.player, var_c2dcab66.weapon);
                }
                if (var_c2dcab66.player === params.eattacker && var_c2dcab66.player isinvehicle()) {
                    veh = var_c2dcab66.player getvehicleoccupied();
                    switch (veh getoccupantseat(var_c2dcab66.player)) {
                    case 0:
                        processscoreevent("driver_kia_zm", var_c2dcab66.player);
                        break;
                    case 1:
                    case 2:
                    case 3:
                    case 4:
                        processscoreevent("gunner_kia_zm", var_c2dcab66.player);
                        break;
                    case 5:
                    case 6:
                    case 7:
                    case 8:
                    case 9:
                    case 10:
                        processscoreevent("freelance_kia_zm", var_c2dcab66.player);
                        break;
                    }
                }
                processscoreevent(params.enemy.var_716c0cc9[#"assist"], var_c2dcab66.player);
            }
        }
    }
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x1 linked
// Checksum 0xa24e5d95, Offset: 0xdb0
// Size: 0x8c
function function_4ffff5df(attacker, weapon) {
    if (weapon.name === #"molotov_fire") {
        processscoreevent("molotov_assist_zm", attacker);
        return;
    }
    if (weapon.name === #"eq_slow_grenade") {
        processscoreevent("concussion_grenade_assist_zm", attacker);
    }
}

// Namespace scoreevents/scoreevents
// Params 1, eflags: 0x1 linked
// Checksum 0x60e7736e, Offset: 0xe48
// Size: 0x5a0
function updatemultikill(params) {
    if (params.weapon.name === #"eq_sticky_grenade" || params.weapon.name === #"satchel_charge" || params.weapon.name === #"frag_grenade" || params.weapon.name === #"cymbal_monkey" || params.weapon.name === #"molotov_fire" || params.weapon.name === #"concussion_grenade") {
        if (!isdefined(params.eattacker.var_4927d3d)) {
            params.eattacker.var_4927d3d = [];
        }
        if (zm_utility::is_player_valid(params.eattacker, 0, 1)) {
            if (isdefined(params.eattacker.var_4927d3d[params.weapon.name])) {
                if (params.eattacker.var_4927d3d[params.weapon.name].time > gettime() - 2000 && params.eattacker.var_4927d3d[params.weapon.name].on_cooldown === 0) {
                    params.eattacker.var_4927d3d[params.weapon.name].multikills++;
                    if (params.eattacker.var_4927d3d[params.weapon.name].multikills >= 3) {
                        switch (params.weapon.name) {
                        case #"eq_sticky_grenade":
                            processscoreevent("semtex_multikill_zm", params.eattacker, undefined, params.weapon);
                            break;
                        case #"satchel_charge":
                            processscoreevent("satchel_charge_multikill_zm", params.eattacker, undefined, params.weapon);
                            break;
                        case #"frag_grenade":
                            processscoreevent("frag_multikill_zm", params.eattacker, undefined, params.weapon);
                            break;
                        case #"cymbal_monkey":
                            processscoreevent("monkey_bomb_multikill_zm", params.eattacker, undefined, params.weapon);
                            break;
                        case #"molotov_fire":
                            processscoreevent("molotov_multikill_zm", params.eattacker, undefined, params.weapon);
                            break;
                        case #"eq_slow_grenade":
                            processscoreevent("concussion_granade_multikill_zm", params.eattacker, undefined, params.weapon);
                            break;
                        }
                        params.eattacker.var_4927d3d[params.weapon.name] = {#player:params.eattacker, #time:gettime() + 2000, #weapon:params.weapon, #multikills:0};
                    }
                } else if (params.eattacker.var_4927d3d[params.weapon.name].time < gettime()) {
                    params.eattacker.var_4927d3d[params.weapon.name] = {#player:params.eattacker, #time:gettime(), #weapon:params.weapon, #multikills:1, #on_cooldown:0};
                }
                return;
            }
            params.eattacker.var_4927d3d[params.weapon.name] = {#player:params.eattacker, #time:gettime(), #weapon:params.weapon, #multikills:1, #on_cooldown:0};
        }
    }
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x1 linked
// Checksum 0x91394276, Offset: 0x13f0
// Size: 0x1f6
function get_distance_for_weapon(weapon, weaponclass) {
    distance = 0;
    if (!isdefined(weaponclass)) {
        return 0;
    }
    if (weapon.rootweapon.name == "pistol_shotgun") {
        weaponclass = "weapon_cqb";
    }
    switch (weaponclass) {
    case #"weapon_smg":
        distance = 1960000;
        break;
    case #"weapon_assault":
        distance = 2560000;
        break;
    case #"weapon_tactical":
        distance = 2560000;
        break;
    case #"weapon_lmg":
        distance = 2560000;
        break;
    case #"weapon_sniper":
        distance = 4000000;
        break;
    case #"weapon_pistol":
        distance = 1000000;
        break;
    case #"weapon_cqb":
        distance = 302500;
        break;
    case #"weapon_special":
        baseweapon = weapon.rootweapon;
        if (weapon.isballisticknife || baseweapon == level.weaponspecialcrossbow) {
            distance = 2250000;
        }
        break;
    case #"weapon_grenade":
        if (weapon.rootweapon.name == "hatchet") {
            distance = 2250000;
        }
        break;
    default:
        distance = 0;
        break;
    }
    return distance;
}

