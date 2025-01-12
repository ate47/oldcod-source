#using script_56658a4b2d9bfa24;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;

#namespace namespace_87549638;

// Namespace namespace_87549638/namespace_87549638
// Params 0, eflags: 0x1 linked
// Checksum 0x5ca689f5, Offset: 0xf8
// Size: 0x24
function function_70a657d8() {
    callback::on_spawned(&on_player_spawned);
}

// Namespace namespace_87549638/namespace_87549638
// Params 0, eflags: 0x5 linked
// Checksum 0xef5124cc, Offset: 0x128
// Size: 0x34
function private on_player_spawned() {
    if (!isbot(self)) {
        return;
    }
    self clear();
}

// Namespace namespace_87549638/namespace_87549638
// Params 0, eflags: 0x1 linked
// Checksum 0x2a9b29ee, Offset: 0x168
// Size: 0x1f6
function think() {
    bot = self.bot;
    /#
        if (namespace_1f0cb9eb::function_c3d7f7d6()) {
            self.bot.var_9931c7dc = 0;
            return;
        }
    #/
    if (isdefined(bot.traversal)) {
        self function_23401de9(bot.traversal);
        self.bot.var_9931c7dc = 0;
        return;
    }
    if (isdefined(bot.var_94a7f067)) {
        self function_b5543946(bot.var_94a7f067);
        self.bot.var_9931c7dc = self function_8174b063(bot.var_94a7f067);
        return;
    }
    if (bot.enemyvisible) {
        self function_58d48e86(self.enemy, bot.enemydist, bot.aimtag);
        self.bot.var_9931c7dc = 1;
        return;
    }
    if (bot.var_e8c84f98 && self function_8174b063(self.enemylastseenpos)) {
        self function_b5543946(self.enemylastseenpos);
        self.bot.var_9931c7dc = 1;
        return;
    }
    if (self haspath()) {
        self function_311aed8b();
        self.bot.var_9931c7dc = 0;
        return;
    }
    self function_eb94f73e();
    self.bot.var_9931c7dc = 0;
}

// Namespace namespace_87549638/namespace_87549638
// Params 1, eflags: 0x1 linked
// Checksum 0xd0d1dda1, Offset: 0x368
// Size: 0x1e
function function_aa7316c1(origin) {
    self.bot.var_94a7f067 = origin;
}

// Namespace namespace_87549638/namespace_87549638
// Params 1, eflags: 0x1 linked
// Checksum 0xb597c5e2, Offset: 0x390
// Size: 0x1e
function function_7c7431fc(tag) {
    self.bot.aimtag = tag;
}

// Namespace namespace_87549638/namespace_87549638
// Params 1, eflags: 0x1 linked
// Checksum 0x8965e162, Offset: 0x3b8
// Size: 0x1e
function projectile_weapon(weapon) {
    self.bot.var_596fc216 = weapon;
}

// Namespace namespace_87549638/namespace_87549638
// Params 0, eflags: 0x1 linked
// Checksum 0x15616bd8, Offset: 0x3e0
// Size: 0x32
function clear() {
    self.bot.var_94a7f067 = undefined;
    self.bot.aimtag = undefined;
    self.bot.var_596fc216 = undefined;
}

// Namespace namespace_87549638/namespace_87549638
// Params 0, eflags: 0x1 linked
// Checksum 0x27c3fabc, Offset: 0x420
// Size: 0x78
function function_df48dc35() {
    var_f5842481 = self haspath() ? 0.76 : 0.85;
    if (!isdefined(var_f5842481)) {
        var_f5842481 = 0;
    }
    return self botgetlookdot() >= var_f5842481;
}

// Namespace namespace_87549638/namespace_87549638
// Params 0, eflags: 0x1 linked
// Checksum 0xb6e1eb40, Offset: 0x4a0
// Size: 0x2c
function function_16245ece() {
    return self botgetlookdot() >= 0.8;
}

// Namespace namespace_87549638/namespace_87549638
// Params 0, eflags: 0x1 linked
// Checksum 0xdbc36cd8, Offset: 0x4d8
// Size: 0x2c
function function_a231de5d() {
    return self botgetlookdot() >= 0.9;
}

// Namespace namespace_87549638/namespace_87549638
// Params 0, eflags: 0x1 linked
// Checksum 0x54326ade, Offset: 0x510
// Size: 0x24
function function_6e1ecc98() {
    return self botgetlookdot() >= 0.98;
}

// Namespace namespace_87549638/namespace_87549638
// Params 1, eflags: 0x5 linked
// Checksum 0x3188f679, Offset: 0x540
// Size: 0x3c
function private function_b5543946(origin) {
    self function_b5460039(origin, "Origin", (0, 1, 1));
}

// Namespace namespace_87549638/namespace_87549638
// Params 3, eflags: 0x5 linked
// Checksum 0x153af9c, Offset: 0x588
// Size: 0x14c
function private function_58d48e86(ent, dist, tag) {
    if (isdefined(self.scriptenemy) && self.scriptenemy == ent) {
        tag = self.scriptenemytag;
    } else if (isdefined(ent.shootattag)) {
        tag = ent.shootattag;
    }
    if (isdefined(tag)) {
        origin = ent gettagorigin(tag);
        if (isdefined(origin)) {
            self function_b5460039(origin, tag, (1, 0, 1));
            return;
        }
    } else {
        origin = self function_4973ba1f(ent, dist);
        if (isdefined(origin)) {
            self function_b5460039(origin, "Entity", (1, 0, 1));
            return;
        }
    }
    centroid = ent getcentroid();
    self function_b5460039(centroid, "Centroid", (1, 0, 1));
}

// Namespace namespace_87549638/namespace_87549638
// Params 0, eflags: 0x5 linked
// Checksum 0x23a33993, Offset: 0x6e0
// Size: 0x134
function private function_311aed8b() {
    var_8be65bb9 = self function_f04bd922();
    if (isdefined(var_8be65bb9)) {
        if (self function_35170b35(var_8be65bb9.var_b8c123c0, getdvarint(#"hash_5e2a707ab6b2031a", 128), "Corner Enter", (0, 1, 1))) {
            return;
        }
        if (self function_35170b35(var_8be65bb9.var_bef48941, getdvarint(#"hash_59325dde11523b77", 64), "Corner Leave", (0, 0, 1))) {
            return;
        }
        if (self function_35170b35(var_8be65bb9.var_2cfdc66d, getdvarint(#"hash_3e28e560311fdbdd", 128), "Next Corner Enter", (1, 0, 1))) {
            return;
        }
    }
    self function_eb94f73e();
}

// Namespace namespace_87549638/namespace_87549638
// Params 4, eflags: 0x5 linked
// Checksum 0x3abe1f01, Offset: 0x820
// Size: 0xa8
function private function_35170b35(var_104d463, mindist, var_e125ba43, debugcolor) {
    if (!isdefined(var_104d463) || distance2dsquared(self.origin, var_104d463) < mindist * mindist) {
        return false;
    }
    aimoffset = (0, 0, self getplayerviewheight());
    self function_b5460039(var_104d463 + aimoffset, var_e125ba43, debugcolor);
    return true;
}

// Namespace namespace_87549638/namespace_87549638
// Params 1, eflags: 0x5 linked
// Checksum 0xbaa6a27c, Offset: 0x8d0
// Size: 0x3c
function private function_23401de9(traversal) {
    dir = (0, 0, 0) - traversal.normal;
    self botsetlookdir(dir);
}

// Namespace namespace_87549638/namespace_87549638
// Params 0, eflags: 0x5 linked
// Checksum 0x7b077beb, Offset: 0x918
// Size: 0x10c
function private function_eb94f73e() {
    velocity = self getvelocity();
    if (lengthsquared(velocity) > 0.0001) {
        dir = vectornormalize((velocity[0], velocity[1], 0));
        eye = self.origin + (0, 0, self getplayerviewheight());
        var_d9100e0 = eye + dir * 128;
        self function_b5460039(var_d9100e0, "Forward ", (1, 0.5, 0));
        return;
    }
    self botsetlookangles(self.angles);
}

// Namespace namespace_87549638/namespace_87549638
// Params 2, eflags: 0x5 linked
// Checksum 0x80a627b6, Offset: 0xa30
// Size: 0xda
function private function_4973ba1f(ent, dist) {
    var_c8e8809e = ent gettagorigin("j_spineupper");
    if (!isdefined(var_c8e8809e)) {
        return undefined;
    }
    if (dist >= 250) {
        return var_c8e8809e;
    }
    var_d7b829fb = ent gettagorigin("j_neck");
    if (!isdefined(var_d7b829fb)) {
        return var_c8e8809e;
    }
    t = max(dist / 250, 0.25);
    return vectorlerp(var_d7b829fb, var_c8e8809e, t);
}

// Namespace namespace_87549638/namespace_87549638
// Params 3, eflags: 0x5 linked
// Checksum 0x94e89b86, Offset: 0xb18
// Size: 0x164
function private function_b5460039(point, var_e125ba43, debugcolor) {
    /#
        if (self bot::should_record("<dev string:x38>")) {
            function_af72dbc5(point, (-1.5, -1.5, -1.5), (1.5, 1.5, 1.5), 0, debugcolor, "<dev string:x49>");
            record3dtext(function_9e72a96(var_e125ba43), point + (0, 0, -0.75), (1, 1, 1), "<dev string:x49>", self, 0.5);
        }
    #/
    if (isdefined(self.bot.var_596fc216)) {
        var_deb75a87 = self botgetprojectileaimangles(self.bot.var_596fc216, point);
        if (isdefined(var_deb75a87)) {
            self botsetlookangles(var_deb75a87.var_478aeacd);
        } else {
            self botsetlookcurrent();
        }
        return;
    }
    self botsetlookpoint(point);
}

// Namespace namespace_87549638/namespace_87549638
// Params 1, eflags: 0x5 linked
// Checksum 0xb1be146f, Offset: 0xc88
// Size: 0x5a
function private function_8174b063(origin) {
    eye = self.origin + (0, 0, self getplayerviewheight());
    return bullettracepassed(eye, origin, 0, self, self.enemy, 1);
}

