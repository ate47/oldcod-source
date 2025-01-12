#using script_1d29de500c266470;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\gamestate;
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
// Checksum 0xfd489259, Offset: 0xe8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"wz_medals", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace wz_medals/wz_medals
// Params 0, eflags: 0x5 linked
// Checksum 0xb29cb65b, Offset: 0x130
// Size: 0x44
function private function_70a657d8() {
    callback::on_revived(&function_843da215);
    callback::on_player_killed(&function_f4837321);
}

// Namespace wz_medals/wz_medals
// Params 1, eflags: 0x1 linked
// Checksum 0xe9a24144, Offset: 0x180
// Size: 0xdc
function function_843da215(params) {
    if (!gamestate::is_state("playing") || !isplayer(params.reviver) || !isdefined(params.attacker)) {
        return;
    }
    if (params.attacker.team === params.reviver.team) {
        return;
    }
    weapon = getweapon(#"bare_hands");
    scoreevents::processscoreevent(#"revives", params.reviver, undefined, weapon);
}

// Namespace wz_medals/wz_medals
// Params 1, eflags: 0x1 linked
// Checksum 0xb4ae5edc, Offset: 0x268
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

