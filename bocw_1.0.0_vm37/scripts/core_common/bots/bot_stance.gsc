#namespace bot_stance;

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x60
// Size: 0x4
function preinit() {
    
}

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x0
// Checksum 0xf6a33eef, Offset: 0x70
// Size: 0x13c
function think() {
    if (isdefined(self.bot.traversal) || self isplayinganimscripted() || self arecontrolsfrozen() || self function_5972c3cf()) {
        return;
    }
    if (is_true(self.bot.var_9cf66413)) {
        self bottapbutton(8);
        return;
    }
    if (is_true(self.bot.var_ce28855b)) {
        self bottapbutton(9);
        return;
    }
    if (self function_29975d32()) {
        self bottapbutton(39);
        return;
    }
    if (self function_a4a505a9()) {
        self bottapbutton(1);
    }
}

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x4
// Checksum 0xc109c7b6, Offset: 0x1b8
// Size: 0x1c0
function private function_29975d32() {
    if (!(!isdefined(self.bot.difficulty) || is_true(self.bot.difficulty.allowslide))) {
        return false;
    }
    if (self issliding()) {
        return true;
    }
    if (!self issprinting()) {
        return false;
    }
    var_8be65bb9 = self function_f04bd922();
    if (!isdefined(var_8be65bb9) || !isdefined(var_8be65bb9.var_b8c123c0)) {
        return false;
    }
    mindist = 250;
    if (isdefined(var_8be65bb9.var_2cfdc66d)) {
        if (self.bot.order !== #"chase_enemy") {
            return false;
        }
        mindist *= 0.8;
    }
    var_b8c123c0 = var_8be65bb9.var_b8c123c0;
    if (var_b8c123c0[2] - self.origin[2] >= 16) {
        return false;
    }
    maxdist = mindist + 75;
    distsq = distance2dsquared(self.origin, var_b8c123c0);
    if (distsq > maxdist * maxdist || distsq < mindist * mindist) {
        return false;
    }
    return true;
}

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x4
// Checksum 0xb8b407a2, Offset: 0x380
// Size: 0x176
function private function_a4a505a9() {
    if (!(!isdefined(self.bot.difficulty) || is_true(self.bot.difficulty.allowsprint))) {
        return false;
    }
    if (self playerads() > 0) {
        return false;
    }
    move = self getnormalizedmovement();
    if (move[0] < 0.826772) {
        return false;
    }
    if (self.bot.order === #"assault" || self.bot.order === #"chase_enemy") {
        return true;
    }
    var_8be65bb9 = self function_f04bd922();
    if (!isdefined(var_8be65bb9) || !isdefined(var_8be65bb9.var_b8c123c0)) {
        return false;
    }
    distsq = distance2dsquared(self.origin, var_8be65bb9.var_b8c123c0);
    if (distsq < 202500) {
        return false;
    }
    return true;
}

