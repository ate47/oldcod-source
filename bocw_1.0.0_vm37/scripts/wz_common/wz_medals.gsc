#using script_1d29de500c266470;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\gamestate_util;
#using scripts\core_common\loot_tracking;
#using scripts\core_common\match_record;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\player\player_record;

#namespace wz_medals;

// Namespace wz_medals/wz_medals
// Params 0, eflags: 0x6
// Checksum 0x724e8a94, Offset: 0xd8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"wz_medals", &preinit, undefined, undefined, undefined);
}

// Namespace wz_medals/wz_medals
// Params 0, eflags: 0x4
// Checksum 0x17b7b925, Offset: 0x120
// Size: 0x44
function private preinit() {
    callback::on_revived(&function_843da215);
    callback::on_player_killed(&function_f4837321);
}

// Namespace wz_medals/wz_medals
// Params 1, eflags: 0x0
// Checksum 0x8bffaa6, Offset: 0x170
// Size: 0xe4
function function_843da215(params) {
    if (!gamestate::is_state(#"playing") || !isplayer(params.reviver) || !isdefined(params.attacker)) {
        return;
    }
    if (params.attacker.team === params.reviver.team) {
        return;
    }
    weapon = getweapon(#"bare_hands");
    scoreevents::processscoreevent(#"revives", params.reviver, undefined, weapon);
}

// Namespace wz_medals/wz_medals
// Params 1, eflags: 0x0
// Checksum 0x18097773, Offset: 0x260
// Size: 0x104
function function_f4837321(*params) {
    if (!isdefined(self.laststandparams) || !isdefined(self.var_a1d415ee)) {
        return;
    }
    original_attacker = self.laststandparams.attacker;
    var_8efbdcbb = self.var_a1d415ee.attacker;
    weapon = self.laststandparams.weapon;
    if (!isdefined(original_attacker) || !isplayer(var_8efbdcbb) || !isdefined(weapon)) {
        return;
    }
    if (var_8efbdcbb.team === self.team) {
        return;
    }
    if (original_attacker != var_8efbdcbb) {
        scoreevents::processscoreevent(#"assists", var_8efbdcbb, undefined, weapon);
    }
}

