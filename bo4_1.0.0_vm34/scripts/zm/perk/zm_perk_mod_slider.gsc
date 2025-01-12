#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_slider;

// Namespace zm_perk_mod_slider/zm_perk_mod_slider
// Params 0, eflags: 0x2
// Checksum 0x3230a94, Offset: 0x88
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_slider", &__init__, &__main__, undefined);
}

// Namespace zm_perk_mod_slider/zm_perk_mod_slider
// Params 0, eflags: 0x0
// Checksum 0xcfcf9672, Offset: 0xd8
// Size: 0x14
function __init__() {
    function_ea6c5013();
}

// Namespace zm_perk_mod_slider/zm_perk_mod_slider
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xf8
// Size: 0x4
function __main__() {
    
}

// Namespace zm_perk_mod_slider/zm_perk_mod_slider
// Params 0, eflags: 0x0
// Checksum 0x4d989c4c, Offset: 0x108
// Size: 0x84
function function_ea6c5013() {
    zm_perks::register_perk_mod_basic_info(#"specialty_mod_phdflopper", "mod_slider", #"specialty_phdflopper", 4500);
    zm_perks::register_perk_threads(#"specialty_mod_phdflopper", &function_2f864fb6, &function_eb543b40);
}

// Namespace zm_perk_mod_slider/zm_perk_mod_slider
// Params 0, eflags: 0x0
// Checksum 0xb796fe41, Offset: 0x198
// Size: 0x1c
function function_2f864fb6() {
    self thread function_69caa899();
}

// Namespace zm_perk_mod_slider/zm_perk_mod_slider
// Params 3, eflags: 0x0
// Checksum 0x7a5538eb, Offset: 0x1c0
// Size: 0x36
function function_eb543b40(b_pause, str_perk, str_result) {
    self notify(#"hash_19d583212e9b3200");
    self.var_1c9efd2f = undefined;
}

// Namespace zm_perk_mod_slider/zm_perk_mod_slider
// Params 0, eflags: 0x0
// Checksum 0xeec05c41, Offset: 0x200
// Size: 0x110
function function_69caa899() {
    self endon(#"disconnect", #"hash_19d583212e9b3200");
    var_a295978e = 0;
    while (true) {
        self.var_b6bbcd31 = undefined;
        while (!self isonground()) {
            if (!var_a295978e) {
                var_a295978e = 1;
                self.var_1c9efd2f = 0;
                var_c59bcfc5 = self.origin[2];
            } else if (var_c59bcfc5 < self.origin[2]) {
                var_c59bcfc5 = self.origin[2];
            }
            waitframe(1);
        }
        if (var_a295978e) {
            self.var_b6bbcd31 = max(0, var_c59bcfc5 - self.origin[2]);
            var_a295978e = 0;
            waitframe(1);
        }
        waitframe(1);
    }
}

