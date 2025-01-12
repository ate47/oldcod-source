#using scripts\abilities\ability_player;
#using scripts\abilities\ability_util;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;

#namespace gadget_combat_efficiency;

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 0, eflags: 0x2
// Checksum 0xee8fb93a, Offset: 0xf8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"gadget_combat_efficiency", &__init__, undefined, undefined);
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 0, eflags: 0x0
// Checksum 0x9bb2da24, Offset: 0x140
// Size: 0xc4
function __init__() {
    ability_player::register_gadget_activation_callbacks(12, &gadget_combat_efficiency_on_activate, &gadget_combat_efficiency_on_off);
    ability_player::register_gadget_is_inuse_callbacks(12, &gadget_combat_efficiency_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(12, &gadget_combat_efficiency_is_flickering);
    ability_player::register_gadget_ready_callbacks(12, &gadget_combat_efficiency_ready);
    clientfield::register("clientuimodel", "hudItems.combatEfficiencyActive", 1, 1, "int");
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 1, eflags: 0x0
// Checksum 0xe128e170, Offset: 0x210
// Size: 0x22
function gadget_combat_efficiency_is_inuse(slot) {
    return self gadgetisactive(slot);
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 1, eflags: 0x0
// Checksum 0xeb8d9511, Offset: 0x240
// Size: 0x22
function gadget_combat_efficiency_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 5, eflags: 0x0
// Checksum 0x53674c69, Offset: 0x270
// Size: 0xf4
function function_3e71185b(attacker, var_13c56510, var_ba90c157, capturedobjective, var_e9da6ec7) {
    if (!isdefined(attacker) || !isdefined(var_13c56510) || !isdefined(var_e9da6ec7) || !isdefined(attacker.var_36875ebe)) {
        return;
    }
    if (function_2e7a7089(attacker, undefined, var_13c56510) && isdefined(attacker.var_22f47e1a) && attacker.var_22f47e1a && attacker != attacker.var_36875ebe) {
        scoreevents::processscoreevent(#"stim_vanguard", attacker.var_36875ebe, undefined, var_e9da6ec7);
    }
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 5, eflags: 0x0
// Checksum 0x67e7b8d3, Offset: 0x370
// Size: 0xfc
function function_5cb43699(attacker, time, var_13c56510, var_e9da6ec7, objectivekill) {
    if (!isdefined(attacker) || !isdefined(var_13c56510) || !isdefined(var_e9da6ec7) || !isdefined(attacker.var_36875ebe) || !isdefined(objectivekill)) {
        return;
    }
    if (function_2e7a7089(attacker, undefined, var_13c56510)) {
        if (objectivekill) {
            scoreevents::processscoreevent(#"battle_command_ultimate_command", attacker, undefined, var_e9da6ec7);
            return;
        }
        if (attacker == attacker.var_36875ebe) {
            scoreevents::processscoreevent(#"hash_1c12195e708977c5", attacker, undefined, var_e9da6ec7);
        }
    }
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 4, eflags: 0x0
// Checksum 0x8d70c276, Offset: 0x478
// Size: 0xd4
function function_802e54e5(attacker, lastkilltime, var_13c56510, var_e9da6ec7) {
    if (!isdefined(attacker) || !isdefined(var_13c56510) || !isdefined(var_e9da6ec7) || !isdefined(attacker.var_36875ebe)) {
        return;
    }
    if (function_2e7a7089(attacker, undefined, var_13c56510) && isdefined(attacker.var_22f47e1a) && attacker.var_22f47e1a) {
        scoreevents::processscoreevent(#"hash_3d7b27350807786b", attacker.var_36875ebe, undefined, var_e9da6ec7);
    }
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 5, eflags: 0x0
// Checksum 0x17d8d2dd, Offset: 0x558
// Size: 0xce
function function_2e7a7089(attacker, victim, weapon, attackerweapon, meansofdeath) {
    if (!isdefined(attacker) || !isdefined(weapon)) {
        return false;
    }
    if (isdefined(attacker.playerrole) && isdefined(attacker.playerrole.ultimateweapon)) {
        ultweapon = getweapon(attacker.playerrole.ultimateweapon);
        if (attacker ability_util::function_955639fe() && weapon == ultweapon) {
            return true;
        }
    }
    return false;
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 4, eflags: 0x0
// Checksum 0x9f6c59ee, Offset: 0x630
// Size: 0x6a
function function_1d11182a(attacker, victim, weapon, attackerweapon) {
    if (!isdefined(attacker)) {
        return 0;
    }
    attacker.var_22f47e1a = attacker ability_util::function_955639fe();
    return function_2e7a7089(attacker, victim, weapon, attackerweapon);
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 2, eflags: 0x0
// Checksum 0xb012eef2, Offset: 0x6a8
// Size: 0xa6
function gadget_combat_efficiency_on_activate(slot, weapon) {
    self._gadget_combat_efficiency = 1;
    self._gadget_combat_efficiency_success = 0;
    self.scorestreaksearnedperuse = 0;
    self.combatefficiencylastontime = gettime();
    self function_5b71b4cd();
    self thread function_1722e74e(slot, weapon);
    result = self gestures::function_42215dfa(#"gestable_battle_cry", undefined, 0);
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 2, eflags: 0x0
// Checksum 0x6f79ba94, Offset: 0x758
// Size: 0x10c
function gadget_combat_efficiency_on_off(slot, weapon) {
    self._gadget_combat_efficiency = 0;
    self.combatefficiencylastontime = gettime();
    self function_5b71b4cd();
    self stats::function_4f10b697(self.heroability, #"scorestreaks_earned_2", int(self.scorestreaksearnedperuse / 2));
    self stats::function_4f10b697(self.heroability, #"scorestreaks_earned_3", int(self.scorestreaksearnedperuse / 3));
    if (isalive(self) && isdefined(level.playgadgetsuccess)) {
        self [[ level.playgadgetsuccess ]](weapon);
    }
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 2, eflags: 0x0
// Checksum 0x94f54c07, Offset: 0x870
// Size: 0x156
function function_1722e74e(slot, weapon) {
    if (self function_ae7bec28() == 0) {
        return;
    }
    self notify("1da58f971e958838");
    self endon("1da58f971e958838");
    self endon(#"death", #"disconnect", #"joined_team", #"joined_spectators");
    var_a3b559ec = weapon.gadget_power_usage_rate * 0.5 * float(function_f9f48566()) / 1000;
    do {
        current_power = self gadgetpowerget(slot);
        self gadgetpowerset(slot, min(current_power + var_a3b559ec, 100));
        waitframe(1);
    } while (self._gadget_combat_efficiency);
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 2, eflags: 0x0
// Checksum 0xcaa9171d, Offset: 0x9d0
// Size: 0x14
function gadget_combat_efficiency_ready(slot, weapon) {
    
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 3, eflags: 0x0
// Checksum 0xf246ebcf, Offset: 0x9f0
// Size: 0xbc
function set_gadget_combat_efficiency_status(weapon, status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    /#
        if (getdvarint(#"scr_cpower_debug_prints", 0) > 0) {
            self iprintlnbold("<dev string:x30>" + weapon.name + "<dev string:x4a>" + status + timestr);
        }
    #/
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 0, eflags: 0x0
// Checksum 0xb03827ea, Offset: 0xab8
// Size: 0xf6
function function_5b71b4cd() {
    enabled = self ability_util::function_955639fe();
    if (isdefined(self.team)) {
        teammates = getplayers(self.team);
        foreach (player in teammates) {
            player clientfield::set_player_uimodel("hudItems.combatEfficiencyActive", enabled);
            if (enabled) {
                player.var_36875ebe = self;
                continue;
            }
            player.var_36875ebe = undefined;
        }
    }
}

