#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_weapons;

#namespace zm_bgb_shields_up;

// Namespace zm_bgb_shields_up/zm_bgb_shields_up
// Params 0, eflags: 0x2
// Checksum 0x1605d22b, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_bgb_shields_up", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_shields_up/zm_bgb_shields_up
// Params 0, eflags: 0x0
// Checksum 0x593178fb, Offset: 0xf0
// Size: 0x74
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_shields_up", "activated", 1, undefined, undefined, &validation, &activation);
}

// Namespace zm_bgb_shields_up/zm_bgb_shields_up
// Params 0, eflags: 0x0
// Checksum 0xf92b0306, Offset: 0x170
// Size: 0x1c
function activation() {
    self give_shield();
}

// Namespace zm_bgb_shields_up/zm_bgb_shields_up
// Params 0, eflags: 0x0
// Checksum 0xe166fe6, Offset: 0x198
// Size: 0xac
function validation() {
    if (isdefined(self.weaponriotshield) && self.weaponriotshield != level.weaponnone) {
        w_shield = self.weaponriotshield;
        n_health_max = int(w_shield.weaponstarthitpoints);
        var_8e375da4 = self damageriotshield(0);
        if (var_8e375da4 < n_health_max) {
            return true;
        }
        return false;
    }
    if (isdefined(level.var_119ddc6b)) {
        return true;
    }
    return false;
}

// Namespace zm_bgb_shields_up/zm_bgb_shields_up
// Params 0, eflags: 0x0
// Checksum 0x85cdd677, Offset: 0x250
// Size: 0x9c
function give_shield() {
    if (!(isdefined(self.hasriotshield) && self.hasriotshield) && !self hasweapon(level.var_119ddc6b)) {
        self zm_weapons::weapon_give(level.var_119ddc6b);
    }
    if (isdefined(self.hasriotshield) && self.hasriotshield && isdefined(self.player_shield_reset_health)) {
        self [[ self.player_shield_reset_health ]]();
    }
}

