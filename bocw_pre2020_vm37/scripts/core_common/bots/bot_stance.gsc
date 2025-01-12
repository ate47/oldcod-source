#using scripts\core_common\ai_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;

#namespace bot_stance;

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x78
// Size: 0x4
function function_70a657d8() {
    
}

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x1 linked
// Checksum 0xd21462e, Offset: 0x88
// Size: 0x64
function think() {
    if (self slide()) {
        self bottapbutton(39);
        return;
    }
    if (self sprint()) {
        self bottapbutton(1);
    }
}

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x5 linked
// Checksum 0x95252347, Offset: 0xf8
// Size: 0x118
function private slide() {
    if (!self ai::get_behavior_attribute(#"slide")) {
        return false;
    }
    if (!self issprinting()) {
        return false;
    }
    var_8be65bb9 = self function_f04bd922();
    if (!isdefined(var_8be65bb9) || !isdefined(var_8be65bb9.var_b8c123c0) || isdefined(var_8be65bb9.var_2cfdc66d)) {
        return false;
    }
    var_b8c123c0 = var_8be65bb9.var_b8c123c0;
    if (var_b8c123c0[2] - self.origin[2] >= 16) {
        return false;
    }
    distsq = distance2dsquared(self.origin, var_b8c123c0);
    if (distsq > 75625 || distsq < 62500) {
        return false;
    }
    return true;
}

// Namespace bot_stance/bot_stance
// Params 0, eflags: 0x5 linked
// Checksum 0x27af463d, Offset: 0x218
// Size: 0xfe
function private sprint() {
    if (!self ai::get_behavior_attribute(#"sprint")) {
        return false;
    }
    if (self playerads() > 0) {
        return false;
    }
    movedir = self getnormalizedmovement();
    if (movedir[0] < 0.826772) {
        return false;
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

