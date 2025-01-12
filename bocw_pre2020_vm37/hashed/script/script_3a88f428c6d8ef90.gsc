#using script_2c5daa95f8fec03c;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\scoreevents;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace namespace_b61a349a;

// Namespace namespace_b61a349a/namespace_b61a349a
// Params 0, eflags: 0x6
// Checksum 0xb6b75032, Offset: 0xb0
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"hash_775f993ac537d970", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace namespace_b61a349a/namespace_b61a349a
// Params 0, eflags: 0x5 linked
// Checksum 0x8db4a4a4, Offset: 0x108
// Size: 0x1c
function private function_70a657d8() {
    /#
        level.var_6aa829ef = &function_6aa829ef;
    #/
}

// Namespace namespace_b61a349a/namespace_b61a349a
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x130
// Size: 0x4
function private postinit() {
    
}

// Namespace namespace_b61a349a/namespace_b61a349a
// Params 1, eflags: 0x1 linked
// Checksum 0x9f267808, Offset: 0x140
// Size: 0x2ca
function function_998f8321(weapon) {
    /#
        var_df6f833b = getdvarint(#"hash_31933df32887a98b", 0);
        if (var_df6f833b > 0) {
            return var_df6f833b;
        }
    #/
    var_8c590502 = isdefined(getgametypesetting(#"hash_3c2c78e639bfd3c6")) ? getgametypesetting(#"hash_3c2c78e639bfd3c6") : 0;
    if (var_8c590502 > 0) {
        return var_8c590502;
    }
    w_base = zm_weapons::get_base_weapon(weapon);
    if (isdefined(level.zombie_weapons[w_base])) {
        switch (level.zombie_weapons[w_base].weapon_classname) {
        case #"ar":
            return self zm_stats::function_12b698fa(#"hash_e4ec67369bdd326");
        case #"lmg":
            return self zm_stats::function_12b698fa(#"hash_5511ea176da6ac83");
        case #"pistol":
            return self zm_stats::function_12b698fa(#"hash_47a2d98887910102");
        case #"shotgun":
            return self zm_stats::function_12b698fa(#"hash_1f78483ef16f84d5");
        case #"smg":
            return self zm_stats::function_12b698fa(#"hash_2c88d3bcf790ec34");
        case #"sniper":
            return self zm_stats::function_12b698fa(#"hash_3d590f7af842ad92");
        case #"tr":
            return self zm_stats::function_12b698fa(#"hash_707a5c5c35f50dec");
        case #"melee":
            return self zm_stats::function_12b698fa(#"hash_265dfd25205ffba8");
        }
    }
}

// Namespace namespace_b61a349a/namespace_b61a349a
// Params 12, eflags: 0x1 linked
// Checksum 0xdd559a2f, Offset: 0x418
// Size: 0xfbc
function function_b3496fde(*inflictor, attacker, damage, *flags, meansofdeath, weapon, *vpoint, *vdir, shitloc, *psoffsettime, *boneindex, *surfacetype) {
    n_base_damage = shitloc;
    if (psoffsettime == "MOD_MELEE") {
        n_tier = vdir zm_stats::function_12b698fa(#"hash_265dfd25205ffba8");
        /#
            var_df6f833b = getdvarint(#"hash_31933df32887a98b", 0);
            if (var_df6f833b > 0) {
                n_tier = var_df6f833b;
            }
        #/
        switch (n_tier) {
        case 2:
            return function_1fd0807c(1, n_base_damage);
        case 4:
            return function_1fd0807c(2, n_base_damage);
        case 5:
            if (isplayer(vdir)) {
                vdir.health += int(0.5 * n_base_damage);
                if (vdir.health > vdir.var_66cb03ad) {
                    vdir.health = vdir.var_66cb03ad;
                }
            }
            return function_1fd0807c(2, n_base_damage);
        default:
            return 0;
        }
    }
    n_tier = 0;
    n_tier = vdir function_998f8321(boneindex);
    w_base = zm_weapons::get_base_weapon(boneindex);
    if (isdefined(level.zombie_weapons[w_base])) {
        switch (level.zombie_weapons[w_base].weapon_classname) {
        case #"ar":
            switch (n_tier) {
            case 2:
                var_67fbadf9 = 0;
                if (vdir playerads()) {
                    var_67fbadf9 = function_1fd0807c(0.1, n_base_damage);
                }
                return var_67fbadf9;
            case 3:
                var_67fbadf9 = 0;
                var_15fc340f = function_1fd0807c(0.1, n_base_damage);
                if (vdir playerads()) {
                    var_67fbadf9 = function_1fd0807c(0.1, n_base_damage);
                }
                return (var_15fc340f + var_67fbadf9);
            case 4:
                var_67fbadf9 = 0;
                var_15fc340f = function_1fd0807c(0.1, n_base_damage);
                if (vdir playerads()) {
                    var_67fbadf9 = function_1fd0807c(0.25, n_base_damage);
                }
                return (var_15fc340f + var_67fbadf9);
            case 5:
                var_67fbadf9 = 0;
                var_15fc340f = function_1fd0807c(0.25, n_base_damage);
                if (vdir playerads()) {
                    var_67fbadf9 = function_1fd0807c(0.25, n_base_damage);
                }
                return (var_15fc340f + var_67fbadf9);
            }
            break;
        case #"lmg":
            switch (n_tier) {
            case 3:
            case 4:
                return function_1fd0807c(0.1, n_base_damage);
            case 5:
                return function_1fd0807c(0.25, n_base_damage);
            }
            break;
        case #"pistol":
            switch (n_tier) {
            case 1:
                return function_1fd0807c(0.05, n_base_damage);
            case 2:
                var_67fbadf9 = 0;
                var_15fc340f = function_1fd0807c(0.05, n_base_damage);
                if (vdir playerads()) {
                    var_67fbadf9 = function_1fd0807c(0.5, n_base_damage);
                }
                return (var_15fc340f + var_67fbadf9);
            case 3:
                var_67fbadf9 = 0;
                var_15fc340f = function_1fd0807c(0.15, n_base_damage);
                if (vdir playerads()) {
                    var_67fbadf9 = function_1fd0807c(0.5, n_base_damage);
                }
                return (var_15fc340f + var_67fbadf9);
            case 4:
                var_67fbadf9 = 0;
                var_15fc340f = function_1fd0807c(0.15, n_base_damage);
                if (vdir playerads()) {
                    var_67fbadf9 = function_1fd0807c(1, n_base_damage);
                }
                return (var_15fc340f + var_67fbadf9);
            case 5:
                var_67fbadf9 = 0;
                var_15fc340f = function_1fd0807c(0.3, n_base_damage);
                if (vdir playerads()) {
                    var_67fbadf9 = function_1fd0807c(1, n_base_damage);
                }
                return (var_15fc340f + var_67fbadf9);
            }
            break;
        case #"shotgun":
            switch (n_tier) {
            case 1:
                return function_1fd0807c(0.05, n_base_damage);
            case 2:
                var_9b4953c = 0;
                var_15fc340f = function_1fd0807c(0.05, n_base_damage);
                if (self function_1d2de48d(vdir)) {
                    var_9b4953c = function_1fd0807c(0.1, n_base_damage);
                }
                return (var_15fc340f + var_9b4953c);
            case 3:
                var_9b4953c = 0;
                var_15fc340f = function_1fd0807c(0.15, n_base_damage);
                if (self function_1d2de48d(vdir)) {
                    var_9b4953c = function_1fd0807c(0.1, n_base_damage);
                }
                return (var_15fc340f + var_9b4953c);
            case 4:
                var_9b4953c = 0;
                var_15fc340f = function_1fd0807c(0.15, n_base_damage);
                if (self function_1d2de48d(vdir)) {
                    var_9b4953c = function_1fd0807c(0.25, n_base_damage);
                }
                return (var_15fc340f + var_9b4953c);
            case 5:
                var_9b4953c = 0;
                var_15fc340f = function_1fd0807c(0.3, n_base_damage);
                if (self function_1d2de48d(vdir)) {
                    var_9b4953c = function_1fd0807c(0.25, n_base_damage);
                }
                return (var_15fc340f + var_9b4953c);
            }
            break;
        case #"smg":
            switch (n_tier) {
            case 2:
                var_d5e19106 = 0;
                if (!vdir playerads()) {
                    var_d5e19106 = function_1fd0807c(0.1, n_base_damage);
                }
                return var_d5e19106;
            case 3:
                var_d5e19106 = 0;
                var_15fc340f = function_1fd0807c(0.1, n_base_damage);
                if (!vdir playerads()) {
                    var_d5e19106 = function_1fd0807c(0.1, n_base_damage);
                }
                return (var_15fc340f + var_d5e19106);
            case 4:
                var_d5e19106 = 0;
                var_15fc340f = function_1fd0807c(0.1, n_base_damage);
                if (!vdir playerads()) {
                    var_d5e19106 = function_1fd0807c(0.25, n_base_damage);
                }
                return (var_15fc340f + var_d5e19106);
            case 5:
                var_d5e19106 = 0;
                var_15fc340f = function_1fd0807c(0.25, n_base_damage);
                if (!vdir playerads()) {
                    var_d5e19106 = function_1fd0807c(0.25, n_base_damage);
                }
                return (var_15fc340f + var_d5e19106);
            }
            break;
        case #"sniper":
            switch (n_tier) {
            case 2:
                if (self function_c8d068bf(shitloc, surfacetype, psoffsettime)) {
                    return function_1fd0807c(0.1, n_base_damage);
                }
                break;
            case 3:
                var_adb54cb3 = 0;
                var_15fc340f = function_1fd0807c(0.1, n_base_damage);
                if (self function_c8d068bf(shitloc, surfacetype, psoffsettime)) {
                    var_adb54cb3 = function_1fd0807c(0.1, n_base_damage);
                }
                return (var_15fc340f + var_adb54cb3);
            case 4:
                var_adb54cb3 = 0;
                var_15fc340f = function_1fd0807c(0.1, n_base_damage);
                if (self function_c8d068bf(shitloc, surfacetype, psoffsettime)) {
                    var_adb54cb3 = function_1fd0807c(0.25, n_base_damage);
                }
                return (var_15fc340f + var_adb54cb3);
            case 5:
                var_adb54cb3 = 0;
                var_15fc340f = function_1fd0807c(0.25, n_base_damage);
                if (self function_c8d068bf(shitloc, surfacetype, psoffsettime)) {
                    var_adb54cb3 = function_1fd0807c(0.25, n_base_damage);
                }
                return (var_15fc340f + var_adb54cb3);
            }
            break;
        case #"tr":
            switch (n_tier) {
            case 2:
                if (self function_cf4432e8(boneindex, vdir)) {
                    return function_1fd0807c(0.1, n_base_damage);
                }
                break;
            case 3:
                var_4323fd31 = 0;
                var_15fc340f = function_1fd0807c(0.1, n_base_damage);
                if (self function_cf4432e8(boneindex, vdir)) {
                    var_4323fd31 = function_1fd0807c(0.1, n_base_damage);
                }
                return (var_15fc340f + var_4323fd31);
            case 4:
                var_4323fd31 = 0;
                var_15fc340f = function_1fd0807c(0.1, n_base_damage);
                if (self function_cf4432e8(boneindex, vdir)) {
                    var_4323fd31 = function_1fd0807c(0.25, n_base_damage);
                }
                return (var_15fc340f + var_4323fd31);
            case 5:
                var_4323fd31 = 0;
                var_15fc340f = function_1fd0807c(0.25, n_base_damage);
                if (self function_cf4432e8(boneindex, vdir)) {
                    var_4323fd31 = function_1fd0807c(0.25, n_base_damage);
                }
                return (var_15fc340f + var_4323fd31);
            }
            break;
        }
    }
    return 0;
}

// Namespace namespace_b61a349a/namespace_b61a349a
// Params 2, eflags: 0x1 linked
// Checksum 0x31ee07bb, Offset: 0x13e0
// Size: 0x1a
function function_1fd0807c(n_percent, n_base_damage) {
    return n_base_damage * n_percent;
}

// Namespace namespace_b61a349a/namespace_b61a349a
// Params 2, eflags: 0x1 linked
// Checksum 0x485cafb6, Offset: 0x1408
// Size: 0x96
function function_cf4432e8(weapon, attacker) {
    weaponclass = util::getweaponclass(weapon);
    weap_min_dmg_range = scoreevents::get_distance_for_weapon(weapon, weaponclass);
    disttovictim = distancesquared(self.origin, attacker.origin);
    if (disttovictim > weap_min_dmg_range) {
        return true;
    }
    return false;
}

// Namespace namespace_b61a349a/namespace_b61a349a
// Params 1, eflags: 0x1 linked
// Checksum 0xdc721578, Offset: 0x14a8
// Size: 0x58
function function_1d2de48d(attacker) {
    var_2e4eec5f = 10000;
    disttovictim = distancesquared(self.origin, attacker.origin);
    if (disttovictim <= var_2e4eec5f) {
        return true;
    }
    return false;
}

// Namespace namespace_b61a349a/namespace_b61a349a
// Params 3, eflags: 0x1 linked
// Checksum 0xd4c4e628, Offset: 0x1508
// Size: 0x3e
function function_c8d068bf(damage, shitloc, meansofdeath) {
    if (self zm_utility::is_headshot(damage, shitloc, meansofdeath)) {
        return true;
    }
    return false;
}

/#

    // Namespace namespace_b61a349a/namespace_b61a349a
    // Params 0, eflags: 0x0
    // Checksum 0x92dc1e69, Offset: 0x1550
    // Size: 0x164
    function function_6aa829ef() {
        level endon(#"game_ended");
        setdvar(#"hash_53ca11fb4a63975f", "<dev string:x38>");
        adddebugcommand("<dev string:x3c>" + 0 + "<dev string:x8f>");
        adddebugcommand("<dev string:x94>" + 1 + "<dev string:x8f>");
        adddebugcommand("<dev string:xe7>" + 2 + "<dev string:x8f>");
        adddebugcommand("<dev string:x13a>" + 3 + "<dev string:x8f>");
        adddebugcommand("<dev string:x18d>" + 4 + "<dev string:x8f>");
        adddebugcommand("<dev string:x1e0>" + 5 + "<dev string:x8f>");
        function_cd140ee9(#"hash_53ca11fb4a63975f", &function_6cb3521c);
    }

    // Namespace namespace_b61a349a/namespace_b61a349a
    // Params 1, eflags: 0x0
    // Checksum 0x24f72330, Offset: 0x16c0
    // Size: 0x14c
    function function_6cb3521c(params) {
        self notify("<dev string:x233>");
        self endon("<dev string:x233>");
        waitframe(1);
        foreach (player in getplayers()) {
            if (params.value == "<dev string:x38>") {
                continue;
            }
            if (params.name === #"hash_53ca11fb4a63975f") {
                setdvar(#"hash_31933df32887a98b", int(params.value));
            }
        }
        setdvar(#"hash_53ca11fb4a63975f", "<dev string:x38>");
    }

#/
