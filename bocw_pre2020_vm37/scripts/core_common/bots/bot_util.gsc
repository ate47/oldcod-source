#using scripts\core_common\ai_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\bots\bot_chain;
#using scripts\core_common\struct;

#namespace bot_util;

// Namespace bot_util/bot_util
// Params 4, eflags: 0x1 linked
// Checksum 0x6aa8a6d6, Offset: 0xb0
// Size: 0x1b2
function function_23cbc6c1(goal, b_force = 0, n_radius, n_height) {
    assert(isbot(self), "<dev string:x38>" + "<dev string:x57>");
    assert(isdefined(goal), "<dev string:x38>" + "<dev string:x79>");
    if (!isbot(self) || !isdefined(goal)) {
        return;
    }
    self ai::set_behavior_attribute("control", "autonomous");
    if (self bot_chain::function_58b429fb()) {
        self bot_chain::function_73d1cfe6();
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
    self.bot.var_bd883a25 = goal;
    self.bot.var_4e3a654 = b_force;
}

// Namespace bot_util/bot_util
// Params 0, eflags: 0x1 linked
// Checksum 0x4c285723, Offset: 0x270
// Size: 0xd2
function function_33834a13() {
    assert(isbot(self), "<dev string:x9e>" + "<dev string:x57>");
    if (!isbot(self) || !isdefined(self.bot.var_bd883a25)) {
        return;
    }
    self clearforcedgoal();
    self ai::set_behavior_attribute("control", "commander");
    self.bot.var_bd883a25 = undefined;
    self.bot.var_4e3a654 = undefined;
}

// Namespace bot_util/bot_util
// Params 1, eflags: 0x0
// Checksum 0xad4c3248, Offset: 0x350
// Size: 0xbc
function function_e449b57(gameobject) {
    assert(isbot(self), "<dev string:xbf>" + "<dev string:x57>");
    assert(isdefined(gameobject), "<dev string:xbf>" + "<dev string:xe5>");
    if (!isbot(self) || !isdefined(gameobject)) {
        return;
    }
    self bot::set_interact(gameobject);
}

// Namespace bot_util/bot_util
// Params 1, eflags: 0x0
// Checksum 0x97267b44, Offset: 0x418
// Size: 0x2c4
function function_cf70f2fe(startstruct) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"hash_5efbaef0ca9e2136");
    self endon(#"hash_5efbaef0ca9e2136");
    assert(isbot(self), "<dev string:x110>" + "<dev string:x57>");
    assert(isstruct(startstruct) || isstring(startstruct), "<dev string:x110>" + "<dev string:x12e>");
    if (isstring(startstruct)) {
        assert(isdefined(struct::get(startstruct)), "<dev string:x110>" + "<dev string:x165>" + startstruct);
    }
    if (!isbot(self)) {
        return;
    }
    if (!isstruct(startstruct) && !isstring(startstruct)) {
        return;
    } else if (isstring(startstruct) && !isdefined(struct::get(startstruct))) {
        return;
    }
    if (self bot_chain::function_58b429fb()) {
        self bot_chain::function_73d1cfe6();
    }
    self.bot.var_bd883a25 = undefined;
    self.bot.var_4e3a654 = undefined;
    self ai::set_behavior_attribute("control", "autonomous");
    self thread bot_chain::function_cf70f2fe(startstruct);
    while (self bot_chain::function_58b429fb()) {
        self waittill(#"hash_382a628dad5ecbb5");
    }
    if (!isdefined(self.bot.var_bd883a25)) {
        self ai::set_behavior_attribute("control", "commander");
    }
}

// Namespace bot_util/bot_util
// Params 0, eflags: 0x0
// Checksum 0x4427e465, Offset: 0x6e8
// Size: 0x34
function function_f89d0427() {
    if (!self bot_chain::function_58b429fb()) {
        return;
    }
    self bot_chain::function_73d1cfe6();
}

