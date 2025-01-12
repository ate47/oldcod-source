#using scripts\core_common\armor;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace weapon_armor;

// Namespace weapon_armor/armor
// Params 0, eflags: 0x6
// Checksum 0x422e2cf2, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"weapon_armor", &init_shared, undefined, undefined, undefined);
}

// Namespace weapon_armor/armor
// Params 0, eflags: 0x1 linked
// Checksum 0xc819d98c, Offset: 0xf0
// Size: 0x54
function init_shared() {
    killstreaks::register_killstreak(#"weapon_armor", &use_armor);
    callback::on_player_killed(&on_player_killed);
}

// Namespace weapon_armor/armor
// Params 1, eflags: 0x1 linked
// Checksum 0x7dedaaaf, Offset: 0x150
// Size: 0x16e
function use_armor(*killstreaktype) {
    if (self killstreakrules::iskillstreakallowed(#"weapon_armor", self.team) == 0) {
        return false;
    }
    self.var_c79fb13d = self killstreakrules::killstreakstart(#"weapon_armor", self.team);
    if (self.var_c79fb13d == -1) {
        return false;
    }
    var_f721af54 = spawn("script_origin", self.origin);
    var_f721af54 linkto(self);
    self.var_f721af54 = var_f721af54;
    var_f721af54 killstreaks::configure_team(#"weapon_armor", self.var_c79fb13d, self);
    self armor::set_armor(150, 150, 2, 0.4, 1, 0.5, 0, 1, 1, 1);
    self.var_67f4fd41 = &function_b299c6ec;
    return true;
}

// Namespace weapon_armor/armor
// Params 2, eflags: 0x1 linked
// Checksum 0x5c2a634f, Offset: 0x2c8
// Size: 0xbc
function function_b299c6ec(eattacker, weapon) {
    if (sessionmodeismultiplayergame()) {
        killstreakrules::killstreakstop(#"weapon_armor", self.team, self.var_c79fb13d);
    }
    if (isdefined(self.var_f721af54)) {
        self.var_f721af54 delete();
    }
    if (isplayer(eattacker)) {
        scoreevents::processscoreevent(#"hash_7b5132f56f758d9", eattacker, self, weapon);
    }
}

// Namespace weapon_armor/armor
// Params 1, eflags: 0x1 linked
// Checksum 0x96382141, Offset: 0x390
// Size: 0x104
function on_player_killed(params) {
    if (armor::get_armor() > 0) {
        if (sessionmodeismultiplayergame()) {
            killstreakrules::killstreakstop(#"weapon_armor", self.team, self.var_c79fb13d);
        }
        if (isdefined(self.var_f721af54)) {
            self.var_f721af54 delete();
        }
        eattacker = params.eattacker;
        weapon = params.weapon;
        if (isplayer(eattacker) && eattacker != self) {
            scoreevents::processscoreevent(#"hash_7b5132f56f758d9", eattacker, self, weapon);
        }
    }
}

