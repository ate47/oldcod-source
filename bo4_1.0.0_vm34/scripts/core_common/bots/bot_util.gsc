#using scripts\core_common\ai_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\bots\bot_chain;
#using scripts\core_common\struct;

#namespace bot_util;

// Namespace bot_util/bot_util
// Params 4, eflags: 0x0
// Checksum 0x505d2c1c, Offset: 0xb0
// Size: 0x1b2
function function_3896525e(goal, b_force = 0, n_radius, n_height) {
    assert(isbot(self), "<invalid>" + "<dev string:x4c>");
    assert(isdefined(goal), "<invalid>" + "<dev string:x6b>");
    if (!isbot(self) || !isdefined(goal)) {
        return;
    }
    self ai::set_behavior_attribute("control", "autonomous");
    if (self bot_chain::function_3a0e73ad()) {
        self bot_chain::function_cd3d3573();
    }
    if (isdefined(n_radius)) {
        if (isdefined(n_height)) {
            self setgoal(goal, b_force, n_radius, n_height);
        } else {
            self setgoal(goal, b_force, n_radius);
        }
    } else {
        self setgoal(goal, b_force);
    }
    self.bot.var_5cff12d7 = goal;
    self.bot.var_59330b87 = b_force;
}

// Namespace bot_util/bot_util
// Params 0, eflags: 0x0
// Checksum 0xa6184ff6, Offset: 0x270
// Size: 0xd2
function function_aed787dd() {
    assert(isbot(self), "<invalid>" + "<dev string:x4c>");
    if (!isbot(self) || !isdefined(self.bot.var_5cff12d7)) {
        return;
    }
    self clearforcedgoal();
    self ai::set_behavior_attribute("control", "commander");
    self.bot.var_5cff12d7 = undefined;
    self.bot.var_59330b87 = undefined;
}

// Namespace bot_util/bot_util
// Params 1, eflags: 0x0
// Checksum 0x40ed22e3, Offset: 0x350
// Size: 0xbc
function function_78ce04ee(gameobject) {
    assert(isbot(self), "<invalid>" + "<dev string:x4c>");
    assert(isdefined(gameobject), "<invalid>" + "<dev string:xce>");
    if (!isbot(self) || !isdefined(gameobject)) {
        return;
    }
    self bot::set_interact(gameobject);
}

// Namespace bot_util/bot_util
// Params 1, eflags: 0x0
// Checksum 0xccc9d184, Offset: 0x418
// Size: 0x2c4
function function_92ea793e(startstruct) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"hash_5efbaef0ca9e2136");
    self endon(#"hash_5efbaef0ca9e2136");
    assert(isbot(self), "<invalid>" + "<dev string:x4c>");
    assert(isstruct(startstruct) || isstring(startstruct), "<invalid>" + "<dev string:x111>");
    if (isstring(startstruct)) {
        assert(isdefined(struct::get(startstruct)), "<invalid>" + "<dev string:x145>" + startstruct);
    }
    if (!isbot(self)) {
        return;
    }
    if (!isstruct(startstruct) && !isstring(startstruct)) {
        return;
    } else if (isstring(startstruct) && !isdefined(struct::get(startstruct))) {
        return;
    }
    if (self bot_chain::function_3a0e73ad()) {
        self bot_chain::function_cd3d3573();
    }
    self.bot.var_5cff12d7 = undefined;
    self.bot.var_59330b87 = undefined;
    self ai::set_behavior_attribute("control", "autonomous");
    self thread bot_chain::function_92ea793e(startstruct);
    while (self bot_chain::function_3a0e73ad()) {
        self waittill(#"hash_382a628dad5ecbb5");
    }
    if (!isdefined(self.bot.var_5cff12d7)) {
        self ai::set_behavior_attribute("control", "commander");
    }
}

// Namespace bot_util/bot_util
// Params 0, eflags: 0x0
// Checksum 0xaff5da69, Offset: 0x6e8
// Size: 0x34
function function_f252b83b() {
    if (!self bot_chain::function_3a0e73ad()) {
        return;
    }
    self bot_chain::function_cd3d3573();
}

// Namespace bot_util/bot_util
// Params 0, eflags: 0x0
// Checksum 0x86a5459c, Offset: 0x728
// Size: 0x1c
function function_b7ad9220() {
    self bot_action::function_38c9bca9(0);
}

// Namespace bot_util/bot_util
// Params 0, eflags: 0x0
// Checksum 0x40ca2a03, Offset: 0x750
// Size: 0x1c
function function_fd5e48a4() {
    self bot_action::function_38c9bca9(1);
}

// Namespace bot_util/bot_util
// Params 0, eflags: 0x0
// Checksum 0x2a13f6bb, Offset: 0x778
// Size: 0x1c
function function_bbf51083() {
    self bot_action::function_38c9bca9(2);
}

