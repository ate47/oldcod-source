#using script_14cc8298d95c14a3;
#using script_1f38e4dd404966a1;
#using script_2ef9d49dba7e6893;
#using script_3d4ed6bb74993d3b;
#using script_473313f86f37e854;
#using script_53e6e796bb019ba1;
#using script_6b434dd0138cd5c1;
#using script_6e9eec954598627c;
#using script_767fdceb6d7ef024;
#using scripts\core_common\aat_shared;
#using scripts\core_common\system_shared;

#namespace zm_aat;

// Namespace zm_aat/zm_aat
// Params 0, eflags: 0x6
// Checksum 0x51ba649, Offset: 0x188
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_aat", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_aat/zm_aat
// Params 0, eflags: 0x5 linked
// Checksum 0x347460b7, Offset: 0x1d0
// Size: 0x1b4
function private function_70a657d8() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
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
}

