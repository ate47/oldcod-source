#using script_23789ec11f581cd0;
#using scripts\abilities\ability_player;
#using scripts\abilities\gadgets\gadget_hero_weapon;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace locaheal;

// Namespace locaheal/localheal
// Params 0, eflags: 0x2
// Checksum 0xcc3df1f1, Offset: 0x170
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"localheal", &init_shared, undefined, undefined);
}

// Namespace locaheal/localheal
// Params 0, eflags: 0x0
// Checksum 0xf83b7d8e, Offset: 0x1b8
// Size: 0x25c
function init_shared() {
    ability_player::register_gadget_activation_callbacks(36, &gadget_on, &gadget_off);
    ability_player::register_gadget_possession_callbacks(36, &hero_weapon::gadget_hero_weapon_on_give, &hero_weapon::gadget_hero_weapon_on_take);
    ability_player::register_gadget_ready_callbacks(36, &hero_weapon::gadget_hero_weapon_ready);
    clientfield::register("clientuimodel", "hudItems.localHealActive", 1, 1, "int");
    clientfield::register("allplayers", "tak_5_heal", 1, 1, "counter");
    callback::on_death(&function_ec7fed7);
    callback::on_spawned(&function_17178ff8);
    callback::on_actor_damage(&on_player_damaged);
    callback::on_player_damage(&on_player_damaged);
    callback::on_player_killed_with_params(&on_player_killed);
    weapon = getweapon("eq_localheal");
    if (isdefined(weapon) && weapon.name != #"none") {
        level.var_2ac91d38 = getscriptbundle(weapon.customsettings);
    } else {
        level.var_2ac91d38 = getscriptbundle("localheal_custom_settings");
    }
    globallogic_score::register_kill_callback(weapon, &function_6fdadb5e);
    globallogic_score::function_55e3f7c(weapon, &function_f46dd465);
}

// Namespace locaheal/localheal
// Params 1, eflags: 0x0
// Checksum 0xab93eb1d, Offset: 0x420
// Size: 0xcc
function function_ec7fed7(params) {
    entity = self;
    if (!isdefined(entity.localheal) || (isdefined(entity.localheal.var_c732abf1) ? entity.localheal.var_c732abf1 : 0) == 0) {
        return;
    }
    entity player::function_20786ad7("cleanse_buff");
    entity function_f34398af("hudItems.localHealActive", 0);
    entity function_7534848c(1, 0);
}

// Namespace locaheal/localheal
// Params 0, eflags: 0x0
// Checksum 0xab8c93f1, Offset: 0x4f8
// Size: 0x4e
function function_17178ff8() {
    player = self;
    player function_7534848c(1, 0);
    player.localheal = undefined;
    player.var_f2522aaf = undefined;
    player.var_2cec11ac = undefined;
}

// Namespace locaheal/localheal
// Params 5, eflags: 0x0
// Checksum 0x7157f058, Offset: 0x550
// Size: 0x108
function function_6fdadb5e(attacker, victim, weapon, attackerweapon, meansofdeath) {
    if (!isdefined(attacker) || !isdefined(attackerweapon) || !isdefined(attacker.var_2cec11ac) || !isplayer(attacker.var_2cec11ac) || attacker.team == victim.team) {
        return false;
    }
    if (isdefined(attacker.var_f2522aaf) && attacker.var_f2522aaf && attacker === attacker.var_2cec11ac && (!isdefined(level.iskillstreakweapon) || ![[ level.iskillstreakweapon ]](attackerweapon))) {
        return true;
    }
    return false;
}

// Namespace locaheal/localheal
// Params 4, eflags: 0x0
// Checksum 0xd7d39a12, Offset: 0x660
// Size: 0x62
function function_f46dd465(attacker, victim, weapon, attackerweapon) {
    attacker.var_b2757230 = isdefined(attacker.var_f2522aaf) && attacker.var_f2522aaf;
    return function_6fdadb5e(attacker, victim, weapon);
}

// Namespace locaheal/localheal
// Params 1, eflags: 0x0
// Checksum 0x969b71c7, Offset: 0x6d0
// Size: 0x1c4
function on_player_damaged(params) {
    player = self;
    if (!isdefined(player.localheal) || (isdefined(player.localheal.var_c732abf1) ? player.localheal.var_c732abf1 : 0) == 0) {
        return;
    }
    diff = player.var_63f2cd6e - max(player.maxhealth, player.health - params.idamage);
    if (diff >= 25) {
        var_8343c0e0 = int(diff / 25);
        player.localheal.var_c732abf1 = max(player.localheal.var_c732abf1 - var_8343c0e0, 0);
        if (player.localheal.var_c732abf1 > 0) {
            player player::function_129882c1("cleanse_buff", player.localheal.var_c732abf1 * 25, undefined, 1);
            return;
        }
        player player::function_20786ad7("cleanse_buff", 1);
        player thread function_965811c8();
    }
}

// Namespace locaheal/localheal
// Params 0, eflags: 0x0
// Checksum 0x21502f4d, Offset: 0x8a0
// Size: 0x72
function function_965811c8() {
    self endon(#"disconnect", #"death");
    level endon(#"game_ended");
    self notify("35ba9338ebb801dc");
    self endon("35ba9338ebb801dc");
    wait 1;
    self.localheal = undefined;
    self.var_f2522aaf = undefined;
    self.var_2cec11ac = undefined;
}

// Namespace locaheal/localheal
// Params 1, eflags: 0x0
// Checksum 0xebba2b3, Offset: 0x920
// Size: 0xdc
function on_player_killed(params) {
    player = self;
    attacker = params.eattacker;
    weapon = params.weapon;
    if (!isdefined(attacker)) {
        return;
    }
    if (isdefined(player.var_f2522aaf) && player.var_f2522aaf && player === player.var_2cec11ac && player.team != attacker.team) {
        scoreevents::processscoreevent(#"tak5_shutdown", attacker, player.var_2cec11ac, weapon);
    }
}

// Namespace locaheal/localheal
// Params 0, eflags: 0x0
// Checksum 0x2d2cec9, Offset: 0xa08
// Size: 0x3e
function has_target() {
    return isdefined(self.localheal) && isdefined(self.localheal.targets) && self.localheal.targets.size > 0;
}

// Namespace locaheal/localheal
// Params 2, eflags: 0x0
// Checksum 0x29c6342b, Offset: 0xa50
// Size: 0x4c
function function_f34398af(str_field_name, n_value) {
    if (isplayer(self)) {
        self clientfield::set_player_uimodel(str_field_name, n_value);
    }
}

// Namespace locaheal/localheal
// Params 2, eflags: 0x0
// Checksum 0x37db2d61, Offset: 0xaa8
// Size: 0x4c
function function_7534848c(slot, value) {
    if (isplayer(self)) {
        self function_53265cac(slot, value);
    }
}

// Namespace locaheal/localheal
// Params 3, eflags: 0x0
// Checksum 0x675608b8, Offset: 0xb00
// Size: 0x3a4
function regen_health(weapon, source_player, var_9e193855) {
    player = self;
    if (player == source_player) {
        maxhealth = player.var_63f2cd6e + var_9e193855 * 25;
        var_da4024ed = min(level.var_2ac91d38.var_797ba02f, maxhealth);
        diff = int(max(maxhealth - var_da4024ed, 0) / 25);
        var_9e193855 -= diff;
    }
    if (var_9e193855 <= 0) {
        return;
    }
    if (!player.localheal.var_c732abf1 || player == source_player) {
        player.var_f2522aaf = 1;
        player.var_2cec11ac = source_player;
        if (player == source_player) {
            player playsoundtoplayer(#"hash_74180c0cc64f28b", player);
            player playsoundtoallbutplayer(#"hash_74180c0cc64f28b", player);
        } else {
            player playsound(#"hash_74180c0cc64f28b");
        }
        player callback::callback(#"on_buff");
        player function_f34398af("hudItems.localHealActive", 1);
        player clientfield::increment("tak_5_heal");
        var_64986176 = getstatuseffect(#"wound");
        player status_effect::function_280d8ac0(var_64986176.setype, var_64986176.var_d20b8ed2);
        var_64986176 = getstatuseffect(#"wound_radiation");
        player status_effect::function_280d8ac0(var_64986176.setype, var_64986176.var_d20b8ed2);
        if (player != source_player) {
            scoreevents::processscoreevent(#"tak5_boosted", source_player, player, weapon);
            source_player.localheal.var_5533ce4b += 1;
        }
        player.localheal.var_c732abf1 += var_9e193855;
        source_player.var_e7dbe562 = 1;
        player player::function_129882c1("cleanse_buff", player.localheal.var_c732abf1 * 25);
        player.health = self.var_63f2cd6e;
        player player::function_581b3131();
    }
}

// Namespace locaheal/localheal
// Params 2, eflags: 0x0
// Checksum 0x8efa2e66, Offset: 0xeb0
// Size: 0xfc
function function_68258711(weapon, source_player) {
    player = self;
    var_e2a9f898 = isdefined(isdefined(level.var_2ac91d38.var_ea941b91) ? level.var_2ac91d38.var_ea941b91 : player != source_player ? level.var_2ac91d38.var_9372a163 : 0) ? isdefined(level.var_2ac91d38.var_ea941b91) ? level.var_2ac91d38.var_ea941b91 : player != source_player ? level.var_2ac91d38.var_9372a163 : 0 : 0;
    player regen_health(weapon, source_player, var_e2a9f898);
}

// Namespace locaheal/localheal
// Params 0, eflags: 0x0
// Checksum 0xfd71e252, Offset: 0xfb8
// Size: 0x52
function function_8390592d() {
    player = self;
    if (!isdefined(player.localheal)) {
        player.localheal = spawnstruct();
        player.localheal.var_c732abf1 = 0;
    }
}

// Namespace locaheal/localheal
// Params 2, eflags: 0x0
// Checksum 0x5fcf21ba, Offset: 0x1018
// Size: 0xa4
function function_5281d5f5(array, entnum) {
    inarray = undefined;
    foreach (target_info in array) {
        if (target_info.entnum == entnum) {
            inarray = target_info;
            break;
        }
    }
    return inarray;
}

// Namespace locaheal/localheal
// Params 2, eflags: 0x0
// Checksum 0x10a98d5d, Offset: 0x10c8
// Size: 0x2ec
function gadget_on(slot, weapon) {
    player = self;
    player notify(#"hash_1fc72d26f9bee4eb");
    player endon(#"hash_1fc72d26f9bee4eb", #"disconnect");
    player function_8390592d();
    player.localheal.var_5533ce4b = 0;
    player.localheal.targets = [];
    players = getplayers(player.team);
    if (isdefined(level.var_79c86e46)) {
        players = [[ level.var_79c86e46 ]](players);
    }
    if (sessionmodeiscampaigngame()) {
        var_663bd33d = getactorteamarray(player.team);
        foreach (friendly in var_663bd33d) {
            if (!isdefined(players)) {
                players = [];
            } else if (!isarray(players)) {
                players = array(players);
            }
            players[players.size] = friendly;
        }
    }
    foreach (index, friendly in players) {
        if (!isalive(friendly) || friendly == player || isdefined(friendly.localheal) && (isdefined(friendly.localheal.var_c732abf1) ? friendly.localheal.var_c732abf1 : 0)) {
            players[index] = undefined;
            continue;
        }
        friendly function_8390592d();
    }
    player.localheal.targets = players;
    player do_gadget(slot, weapon);
}

// Namespace locaheal/localheal
// Params 2, eflags: 0x0
// Checksum 0x5f5ad9da, Offset: 0x13c0
// Size: 0x38
function gadget_off(slot, weapon) {
    player = self;
    player notify(#"hash_4889384a249efc16");
}

// Namespace locaheal/localheal
// Params 2, eflags: 0x0
// Checksum 0xea219a10, Offset: 0x1400
// Size: 0x2fc
function do_gadget(slot, weapon) {
    player = self;
    var_da3df0fa = 0;
    player.var_e7dbe562 = 0;
    foreach (target in player.localheal.targets) {
        if (!isdefined(target)) {
            continue;
        }
        friendly = target;
        var_bac689e7 = friendly.maxhealth - friendly.health;
        if (var_bac689e7 > 50) {
            scoreevents::processscoreevent(#"hash_66aed2c0af3fe6bd", player, friendly, weapon);
        }
        if (isdefined(level.var_86ebfbc0)) {
            var_848752a7 = [[ level.var_86ebfbc0 ]]("localHealSuccessLineCount", 0) * 25;
            if (var_bac689e7 > (isdefined(var_848752a7) ? var_848752a7 : 0)) {
                player thread [[ level.playgadgetsuccess ]](weapon, undefined, undefined, self);
            }
        }
        if (isdefined(level.var_e4f2d52f)) {
            friendly [[ level.var_e4f2d52f ]](weapon, player);
        }
        profilestart();
        friendly function_68258711(weapon, player);
        player function_68258711(weapon, player);
        profilestop();
    }
    if (isdefined(level.var_2ac91d38.var_3bf7e02) && level.var_2ac91d38.var_3bf7e02) {
        if (player.localheal.var_5533ce4b >= (isdefined(level.var_2ac91d38.var_c91238cb) ? level.var_2ac91d38.var_c91238cb : 0)) {
            var_da3df0fa = 1;
            profilestart();
            player regen_health(weapon, player, isdefined(level.var_2ac91d38.var_6bb27a7) ? level.var_2ac91d38.var_6bb27a7 : 0);
            profilestop();
        }
    }
    self luinotifyevent(#"localheal_fire", 2, player.var_e7dbe562, var_da3df0fa);
}

