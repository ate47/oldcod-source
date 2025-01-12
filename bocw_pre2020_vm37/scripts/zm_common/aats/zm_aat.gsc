#using script_128b98955a4e6608;
#using script_18f62abb5f881acf;
#using script_1a6b88eb823340b0;
#using script_3751b21462a54a7d;
#using script_3fbe90dd521a8e2d;
#using script_5f261a5d57de5f7c;
#using script_6b1f7ff883ed7f20;
#using script_7445d698c7893a17;
#using script_746c9396ccd2c32d;
#using script_b0d689da5c8d1c7;
#using script_f2ff9d02842d94d;
#using scripts\core_common\aat_shared;
#using scripts\core_common\system_shared;

#namespace zm_aat;

// Namespace zm_aat/zm_aat
// Params 0, eflags: 0x6
// Checksum 0x51ba649, Offset: 0x198
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_aat", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_aat/zm_aat
// Params 0, eflags: 0x5 linked
// Checksum 0x98738b5e, Offset: 0x1e0
// Size: 0x1dc
function private function_70a657d8() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    level.var_9d1d502c = 1;
    level.aat_initializing = 1;
    level aat::function_571fceb("ammomod_brainrot", &ammomod_brainrot::function_9384b521);
    level aat::function_571fceb("ammomod_cryofreeze", &ammomod_cryofreeze::function_ab6c8a0b);
    level aat::function_571fceb("ammomod_deadwire", &ammomod_deadwire::function_af1f180);
    level aat::function_571fceb("ammomod_napalmburst", &ammomod_napalmburst::function_4e4244c1);
    level aat::function_571fceb("ammomod_electriccherry", &ammomod_electriccherry::function_4b66248d);
    level aat::function_571fceb("zm_aat_kill_o_watt", &namespace_900a0996::function_d4a047b9);
    level aat::function_571fceb("zm_aat_brain_decay", &namespace_d00dc3ab::function_3de84616);
    level aat::function_571fceb("zm_aat_frostbite", &aat_frostbite::function_b39d1bd2);
    level aat::function_571fceb("zm_aat_plasmatic_burst", &namespace_56577988::function_a9c3764f);
    level aat::function_2b3bcce0();
    level.var_a839c34d = &function_3ac3c47e;
}

// Namespace zm_aat/zm_aat
// Params 1, eflags: 0x1 linked
// Checksum 0xcd21b31a, Offset: 0x3c8
// Size: 0x202
function function_296cde87(aat_name) {
    if (isdefined(aat_name)) {
        switch (aat_name) {
        case #"ammomod_cryofreeze":
        case #"ammomod_cryofreeze_5":
        case #"ammomod_cryofreeze_4":
        case #"ammomod_cryofreeze_1":
        case #"ammomod_cryofreeze_3":
        case #"ammomod_cryofreeze_2":
            return "ammomod_cryofreeze";
        case #"ammomod_napalmburst":
        case #"ammomod_napalmburst_1":
        case #"ammomod_napalmburst_2":
        case #"ammomod_napalmburst_3":
        case #"ammomod_napalmburst_4":
        case #"ammomod_napalmburst_5":
            return "ammomod_napalmburst";
        case #"ammomod_brainrot_4":
        case #"ammomod_brainrot_5":
        case #"ammomod_brainrot_1":
        case #"ammomod_brainrot_2":
        case #"ammomod_brainrot_3":
        case #"ammomod_brainrot":
            return "ammomod_brainrot";
        case #"ammomod_deadwire_2":
        case #"ammomod_deadwire_3":
        case #"ammomod_deadwire_1":
        case #"ammomod_deadwire_4":
        case #"ammomod_deadwire_5":
        case #"ammomod_deadwire":
            return "ammomod_deadwire";
        case #"ammomod_electriccherry":
            return "ammomod_electriccherry";
        }
    }
    return #"none";
}

// Namespace zm_aat/zm_aat
// Params 1, eflags: 0x0
// Checksum 0x6b8328d, Offset: 0x5d8
// Size: 0x8a
function function_70c0e823(aat_name) {
    assert(isdefined(level.aat[aat_name]), "<dev string:x38>" + (ishash(aat_name) ? function_9e72a96(aat_name) : aat_name));
    return level.aat[aat_name].element;
}

// Namespace zm_aat/zm_aat
// Params 3, eflags: 0x1 linked
// Checksum 0xdb234c6e, Offset: 0x670
// Size: 0x158
function function_3ac3c47e(name, now, attacker) {
    n_multiplier = 1;
    if (isplayer(attacker)) {
        if (attacker namespace_e86ffa8::function_cd6787b(3)) {
            n_multiplier = 0.3;
        } else if (attacker namespace_e86ffa8::function_cd6787b()) {
            n_multiplier = 0.15;
        }
    }
    if (isdefined(self.aat_cooldown_start) && now <= self.aat_cooldown_start[name] + level.aat[name].cooldown_time_entity * n_multiplier) {
        return true;
    }
    if (now <= attacker.aat_cooldown_start[name] + level.aat[name].cooldown_time_attacker * n_multiplier) {
        return true;
    }
    if (now <= level.aat[name].cooldown_time_global_start + level.aat[name].cooldown_time_global * n_multiplier) {
        return true;
    }
    return false;
}

