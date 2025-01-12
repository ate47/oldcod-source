#using script_7124f66ae9dd2bde;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;

#namespace bot_orders;

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x1 linked
// Checksum 0x755345d6, Offset: 0x78
// Size: 0x34
function function_70a657d8() {
    level.var_efeb78b7 = [];
    callback::on_spawned(&on_player_spawned);
}

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x5 linked
// Checksum 0x7a5f2fe1, Offset: 0xb8
// Size: 0x34
function private on_player_spawned() {
    if (!isbot(self)) {
        return;
    }
    self clear();
}

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x5 linked
// Checksum 0xad470f48, Offset: 0xf8
// Size: 0x42
function private clear() {
    self.bot.order = undefined;
    self.bot.var_24e30bb8 = undefined;
    self.bot.var_e923c16d = undefined;
    self.bot.var_a97b148b = undefined;
}

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x1 linked
// Checksum 0x9a31fbb8, Offset: 0x148
// Size: 0x20c
function think() {
    bot = self.bot;
    info = self function_4794d6a3();
    if (info.goalforced) {
        clear();
        return;
    }
    if (!isdefined(bot.order)) {
        /#
            if (self bot::should_record(#"hash_bb5c278818b000b")) {
                record3dtext("<dev string:x38>", self.origin, (0, 1, 1), "<dev string:x53>", self, 0.5);
            }
        #/
        var_d3a2864f = self function_ba78ccd2();
        if (isdefined(var_d3a2864f)) {
            region = var_d3a2864f.regions[randomint(var_d3a2864f.regions.size)];
            origin = function_b507a336(region).origin;
            self patrol(origin);
        }
        return;
    }
    if (bot.order == #"patrol") {
        self patrol_think();
        return;
    }
    if (bot.order == #"assault") {
        self function_6a672c6d();
        return;
    }
    if (bot.order == #"defend") {
        self function_72084729();
    }
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x5 linked
// Checksum 0xb5af5a14, Offset: 0x360
// Size: 0x104
function private patrol(origin) {
    if (self.bot.var_e8c84f98) {
        origin = self.enemy.origin;
    }
    var_28edea35 = randomint(3);
    var_24e30bb8 = namespace_4567f5de::function_89751246(level.var_8706e44e, self.origin, origin, var_28edea35);
    if (var_24e30bb8.size <= 0) {
        return;
    }
    self.bot.order = #"patrol";
    if (self.bot.var_e8c84f98) {
        self.bot.var_a97b148b = function_375cb5ff(origin);
    }
    self function_fd78dbc(var_24e30bb8);
}

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x5 linked
// Checksum 0xfde87302, Offset: 0x470
// Size: 0x22c
function private patrol_think() {
    bot = self.bot;
    /#
        if (self bot::should_record(#"hash_bb5c278818b000b")) {
            record3dtext("<dev string:x5d>", self.origin, (0, 1, 1), "<dev string:x53>", self, 0.5);
            if (isdefined(bot.var_a97b148b)) {
                record3dtext("<dev string:x6f>", self.origin, (0, 1, 1), "<dev string:x53>", self, 0.5);
            }
        }
    #/
    if (bot.enemyvisible) {
        var_a97b148b = function_375cb5ff(self.enemy.origin);
        if (isdefined(var_a97b148b)) {
            if (!isdefined(bot.var_a97b148b) || bot.var_a97b148b != var_a97b148b) {
                var_28edea35 = randomint(3);
                var_24e30bb8 = namespace_4567f5de::function_89751246(level.var_8706e44e, self.origin, self.enemy.origin, var_28edea35);
                if (var_24e30bb8.size > 0) {
                    self function_fd78dbc(var_24e30bb8);
                    bot.var_a97b148b = var_a97b148b;
                }
            }
        }
    } else if (isdefined(self.enemy) && !self.bot.var_e8c84f98) {
        if (isdefined(bot.var_a97b148b)) {
            self clear();
            return;
        }
    }
    function_db3a19e8();
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x4
// Checksum 0x25f9f980, Offset: 0x6a8
// Size: 0xa4
function private assault(origin) {
    var_28edea35 = randomint(3);
    var_24e30bb8 = namespace_4567f5de::function_89751246(level.var_8706e44e, self.origin, origin, var_28edea35);
    if (var_24e30bb8.size <= 0) {
        return;
    }
    self.bot.order = #"assault";
    self function_fd78dbc(var_24e30bb8);
}

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x5 linked
// Checksum 0x79fedcfb, Offset: 0x758
// Size: 0x7c
function private function_6a672c6d() {
    /#
        if (self bot::should_record(#"hash_bb5c278818b000b")) {
            record3dtext("<dev string:x84>", self.origin, (0, 1, 1), "<dev string:x53>", self, 0.5);
        }
    #/
    function_db3a19e8();
}

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x7e0
// Size: 0x4
function defend() {
    
}

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x7f0
// Size: 0x4
function private function_72084729() {
    
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x5 linked
// Checksum 0x82fafa3, Offset: 0x800
// Size: 0x42
function private function_375cb5ff(origin) {
    tacpoint = getclosesttacpoint(origin);
    if (isdefined(tacpoint)) {
        return tacpoint.region;
    }
    return undefined;
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x5 linked
// Checksum 0xe2f6d29a, Offset: 0x850
// Size: 0x46
function private in_region(region) {
    tpoint = getclosesttacpoint(self.origin);
    return isdefined(tpoint) && tpoint.region == region;
}

// Namespace bot_orders/bot_orders
// Params 1, eflags: 0x5 linked
// Checksum 0xf56d1096, Offset: 0x8a0
// Size: 0x46
function private function_fd78dbc(var_24e30bb8) {
    /#
        self function_d966fb1c(var_24e30bb8);
    #/
    self.bot.var_24e30bb8 = var_24e30bb8;
    self.bot.var_e923c16d = 0;
}

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x5 linked
// Checksum 0x47aa2c31, Offset: 0x8f0
// Size: 0x114
function private function_db3a19e8() {
    bot = self.bot;
    var_c35c6f07 = bot.var_24e30bb8[bot.var_e923c16d];
    info = self function_4794d6a3();
    if (!isdefined(info.regionid) || info.regionid != var_c35c6f07) {
        self setgoal(var_c35c6f07);
        return;
    }
    if (in_region(var_c35c6f07)) {
        var_161b41f9 = bot.var_24e30bb8[bot.var_e923c16d + 1];
        if (isdefined(var_161b41f9)) {
            bot.var_e923c16d++;
            self setgoal(var_161b41f9);
            return;
        }
        self clear();
    }
}

// Namespace bot_orders/bot_orders
// Params 0, eflags: 0x5 linked
// Checksum 0x8c851ebb, Offset: 0xa10
// Size: 0x92
function private function_ba78ccd2() {
    if (!isdefined(level.var_8706e44e)) {
        return undefined;
    }
    players = function_a1ef346b();
    player = players[randomint(players.size)];
    if (player.team == self.team) {
        return undefined;
    }
    return namespace_4567f5de::function_a9de216e(level.var_8706e44e, player.origin);
}

/#

    // Namespace bot_orders/bot_orders
    // Params 1, eflags: 0x0
    // Checksum 0xd4eb895c, Offset: 0xab0
    // Size: 0x186
    function function_d966fb1c(var_24e30bb8) {
        if (!self bot::should_record(#"hash_bb5c278818b000b")) {
            return;
        }
        lastorigin = undefined;
        foreach (i, id in var_24e30bb8) {
            info = function_b507a336(id);
            text = "<dev string:x97>" + i + "<dev string:xa1>" + id + "<dev string:xb0>" + info.weight;
            record3dtext(text, info.origin, (0, 1, 1), "<dev string:x53>", self);
            if (isdefined(lastorigin)) {
                recordline(lastorigin, info.origin, (0, 1, 1), "<dev string:x53>", self);
            }
            lastorigin = info.origin;
        }
    }

#/
