#namespace perks;

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x9aa9b7fa, Offset: 0x68
// Size: 0xd4
function perk_setperk(str_perk) {
    if (!isdefined(self.var_dd533644)) {
        self.var_dd533644 = [];
    }
    if (!isdefined(self.var_dd533644[str_perk])) {
        self.var_dd533644[str_perk] = 0;
    }
    assert(self.var_dd533644[str_perk] >= 0, "<dev string:x30>");
    assert(self.var_dd533644[str_perk] < 23, "<dev string:x48>");
    self.var_dd533644[str_perk]++;
    self setperk(str_perk);
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0xf5a26a05, Offset: 0x148
// Size: 0xb4
function perk_unsetperk(str_perk) {
    if (!isdefined(self.var_dd533644)) {
        self.var_dd533644 = [];
    }
    if (!isdefined(self.var_dd533644[str_perk])) {
        self.var_dd533644[str_perk] = 0;
    }
    self.var_dd533644[str_perk]--;
    assert(self.var_dd533644[str_perk] >= 0, "<dev string:x30>");
    if (self.var_dd533644[str_perk] <= 0) {
        self unsetperk(str_perk);
    }
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x8b81d15a, Offset: 0x208
// Size: 0x4a
function perk_hasperk(str_perk) {
    if (isdefined(self.var_dd533644) && isdefined(self.var_dd533644[str_perk]) && self.var_dd533644[str_perk] > 0) {
        return true;
    }
    return false;
}

// Namespace perks/perks
// Params 0, eflags: 0x0
// Checksum 0x8fd83442, Offset: 0x260
// Size: 0x26
function perk_reset_all() {
    self clearperks();
    self.var_dd533644 = [];
}

