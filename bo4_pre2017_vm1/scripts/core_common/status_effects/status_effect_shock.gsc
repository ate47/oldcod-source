#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/status_effects/status_effect_util;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace status_effect_shock;

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x2
// Checksum 0x50f37c43, Offset: 0x230
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("status_effect_shock", &__init__, undefined, undefined);
}

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x0
// Checksum 0x4a70ca8e, Offset: 0x270
// Size: 0xf0
function __init__() {
    var_a6ad716d = getscriptbundle("shock");
    status_effect::register_status_effect_callback_apply(4, &shock_apply);
    status_effect::function_9acf95a1(4, "shock");
    status_effect::function_96de5b5e(4, var_a6ad716d.var_804bc9d5 * 1000);
    clientfield::register("toplayer", "shocked", 1, 1, "int");
    if (!isdefined(level.shockduration)) {
        level.shockduration = var_a6ad716d.var_804bc9d5;
    }
}

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x0
// Checksum 0x7e81b59c, Offset: 0x368
// Size: 0x1f4
function shock_apply() {
    self notify(#"hash_2df0f367");
    self endon(#"hash_2df0f367");
    self endon(#"disconnect");
    self endon(#"death");
    waitframe(1);
    if (!(isdefined(self) && isalive(self))) {
        return;
    }
    var_c7372192 = level.shockduration * 1000;
    self.var_70237074 = status_effect::function_c9de0b56(4);
    if (status_effect::function_24365fad(4)) {
        var_fbdbcecc = self.var_70237074 + level.shockduration - gettime();
        if (var_fbdbcecc > var_c7372192) {
            self.shockduration = var_fbdbcecc;
        } else {
            self.shockduration = var_c7372192;
        }
    } else {
        self.shockduration = var_c7372192;
    }
    self clientfield::set_to_player("shocked", 1);
    self.shockendtime = self.var_70237074 + self.shockduration;
    self thread function_a00fc040();
    self thread function_ce0ec213();
    self thread function_593ff566();
    if (self.shockduration > 0) {
        wait self.shockduration / 1000;
    }
    if (isdefined(self)) {
        self notify(#"hash_253c19cc");
        self shock_end();
    }
}

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x4
// Checksum 0x208911d7, Offset: 0x568
// Size: 0x54
function private function_ce0ec213() {
    self notify(#"hash_cfee3f7");
    self endon(#"hash_cfee3f7");
    self endon(#"hash_253c19cc");
    self waittill("death");
    if (isdefined(self)) {
        self shock_end();
    }
}

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x4
// Checksum 0xe65c51a4, Offset: 0x5c8
// Size: 0x54
function private function_593ff566() {
    self notify(#"hash_7ba0b40");
    self endon(#"hash_7ba0b40");
    self endon(#"hash_253c19cc");
    self waittill("gadget_cleanse_on");
    if (isdefined(self)) {
        self shock_end();
    }
}

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x0
// Checksum 0x5c9beac, Offset: 0x628
// Size: 0x8a
function shock_end() {
    if (isdefined(self)) {
        self clientfield::set_to_player("shocked", 0);
        self setlowready(0);
        self util::freeze_player_controls(0);
        self stoprumble("proximity_grenade");
        self notify(#"hash_253c19cc");
    }
}

// Namespace status_effect_shock/status_effect_shock
// Params 0, eflags: 0x0
// Checksum 0x2546e4b3, Offset: 0x6c0
// Size: 0xce
function function_a00fc040() {
    self notify(#"hash_357a6230");
    self endon(#"hash_357a6230");
    self endon(#"hash_253c19cc");
    self setlowready(1);
    self util::freeze_player_controls(1);
    self thread shock_rumble_loop(self.shockduration / 1000);
    self playsound("wpn_taser_mine_zap");
    while (true) {
        playfxontag("weapon/fx_prox_grenade_impact_player_spwner", self, "J_SpineUpper");
        wait 1;
    }
}

// Namespace status_effect_shock/status_effect_shock
// Params 1, eflags: 0x4
// Checksum 0x2bcbf244, Offset: 0x798
// Size: 0x86
function private shock_rumble_loop(duration) {
    self notify(#"shock_rumble_loop");
    self endon(#"shock_rumble_loop");
    self endon(#"hash_253c19cc");
    goaltime = gettime() + duration * 1000;
    while (gettime() < goaltime) {
        self playrumbleonentity("proximity_grenade");
        wait 1;
    }
}

