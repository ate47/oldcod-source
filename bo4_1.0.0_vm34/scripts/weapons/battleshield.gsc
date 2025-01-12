#using scripts\abilities\ability_player;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace battleshield;

// Namespace battleshield/battleshield
// Params 0, eflags: 0x2
// Checksum 0xe3429950, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"battleshield", &__init__, undefined, undefined);
}

// Namespace battleshield/battleshield
// Params 0, eflags: 0x0
// Checksum 0x6f64abb9, Offset: 0xf0
// Size: 0xd4
function __init__() {
    level.weaponsigbuckler = getweapon(#"sig_buckler");
    level.weaponsigbucklerlh = getweapon(#"sig_buckler_lh");
    level.weaponsigshieldturret = getweapon(#"sig_shield_turret");
    level.var_8bac9677 = getdvarfloat(#"hash_27445ccf68d30520", 5);
    ability_player::register_gadget_activation_callbacks(11, &function_c796965f, undefined);
}

// Namespace battleshield/battleshield
// Params 2, eflags: 0x0
// Checksum 0x26b08d1d, Offset: 0x1d0
// Size: 0xfc
function function_c796965f(abilityslot, weapon) {
    if (weapon != getweapon(#"sig_buckler_dw")) {
        return;
    }
    self.var_d9a0386 = 1;
    self.var_2b9ad42c = gettime();
    if (!(isdefined(level.var_d5570eb4) && level.var_d5570eb4)) {
        if (isdefined(self)) {
            self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 1);
        }
    }
    self waittill(#"death", #"weapon_change");
    if (isdefined(self)) {
        self.var_d9a0386 = 0;
        self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 0);
    }
}

