#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;

#namespace zm_bgb_alchemical_antithesis;

// Namespace zm_bgb_alchemical_antithesis/zm_bgb_alchemical_antithesis
// Params 0, eflags: 0x2
// Checksum 0x8f078f71, Offset: 0xc8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_alchemical_antithesis", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_alchemical_antithesis/zm_bgb_alchemical_antithesis
// Params 0, eflags: 0x0
// Checksum 0x70a4bb67, Offset: 0x118
// Size: 0xb4
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_alchemical_antithesis", "activated", 1, undefined, undefined, undefined, &activation);
    bgb::function_336ffc4e(#"zm_bgb_alchemical_antithesis");
    bgb::function_ff4b2998(#"zm_bgb_alchemical_antithesis", &add_to_player_score_override, 0);
}

// Namespace zm_bgb_alchemical_antithesis/zm_bgb_alchemical_antithesis
// Params 0, eflags: 0x0
// Checksum 0x2842c2e5, Offset: 0x1d8
// Size: 0x36
function validation() {
    return !(isdefined(self bgb::get_active()) && self bgb::get_active());
}

// Namespace zm_bgb_alchemical_antithesis/zm_bgb_alchemical_antithesis
// Params 0, eflags: 0x0
// Checksum 0xdc5cd384, Offset: 0x218
// Size: 0x32
function activation() {
    self.ready_for_score_events = 0;
    self bgb::run_timer(60);
    self.ready_for_score_events = 1;
}

// Namespace zm_bgb_alchemical_antithesis/zm_bgb_alchemical_antithesis
// Params 3, eflags: 0x0
// Checksum 0xf0572fc1, Offset: 0x258
// Size: 0x1d6
function add_to_player_score_override(points, str_awarded_by, var_1ed9bd9b) {
    if (!(isdefined(self.bgb_active) && self.bgb_active)) {
        return points;
    }
    var_4375ef8a = int(points / 7.5);
    current_weapon = self getcurrentweapon();
    if (zm_loadout::is_offhand_weapon(current_weapon)) {
        return points;
    }
    if (self zm_utility::is_drinking()) {
        return points;
    }
    if (current_weapon == level.weaponrevivetool) {
        return points;
    }
    var_b8f62d73 = self getweaponammostock(current_weapon);
    var_b8f62d73 += var_4375ef8a;
    if (self hasperk(#"specialty_extraammo")) {
        var_b8f62d73 = math::clamp(var_b8f62d73, 0, current_weapon.maxammo);
    } else {
        var_b8f62d73 = math::clamp(var_b8f62d73, 0, current_weapon.startammo);
    }
    self setweaponammostock(current_weapon, var_b8f62d73);
    self thread function_a6bf711f();
    self zm_stats::increment_challenge_stat("GUM_GOBBLER_ALCHEMICAL_ANTITHESIS", var_4375ef8a);
    return 0;
}

// Namespace zm_bgb_alchemical_antithesis/zm_bgb_alchemical_antithesis
// Params 0, eflags: 0x0
// Checksum 0xe90f5be3, Offset: 0x438
// Size: 0x6e
function function_a6bf711f() {
    if (!isdefined(self.var_82764e33)) {
        self.var_82764e33 = 0;
    }
    if (!self.var_82764e33) {
        self.var_82764e33 = 1;
        self playsoundtoplayer(#"zmb_bgb_alchemical_ammoget", self);
        wait 0.5;
        if (isdefined(self)) {
            self.var_82764e33 = 0;
        }
    }
}

