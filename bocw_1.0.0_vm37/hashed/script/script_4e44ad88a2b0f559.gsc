#using scripts\core_common\bots\bot;

#namespace namespace_87549638;

// Namespace namespace_87549638/namespace_87549638
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xc8
// Size: 0x4
function preinit() {
    
}

// Namespace namespace_87549638/namespace_87549638
// Params 0, eflags: 0x0
// Checksum 0x268d4ade, Offset: 0xd8
// Size: 0x3f0
function think() {
    pixbeginevent(#"");
    if (self isinexecutionvictim() || self isinexecutionattack()) {
        profilestop();
        return;
    }
    if (isdefined(self.bot.var_5efe88e4)) {
        self botsetlookangles(self.bot.var_5efe88e4);
        self.bot.var_9931c7dc = 0;
    } else if (self isplayinganimscripted() || self arecontrolsfrozen() || self.bot.flashed) {
        self.bot.var_9931c7dc = 0;
    } else if (self function_37d408b6()) {
        self function_23401de9();
        self.bot.var_9931c7dc = 0;
    } else if (isdefined(self.bot.var_87751145)) {
        self.bot.var_9931c7dc = self function_2f110827();
    } else if (self.bot.enemyvisible) {
        entity = self.enemy;
        if (isplayer(self.enemy) && self.enemy isinvehicle() && !self.enemy isremotecontrolling()) {
            entity = self.enemy getvehicleoccupied();
        }
        self.bot.var_9931c7dc = self aim_at_entity(entity, self.bot.enemydist, self.bot.var_2d563ebf);
    } else if (self.bot.var_e8c84f98 && self function_204b5b9c() && self function_8174b063(self.enemylastseenpos)) {
        self.bot.var_9931c7dc = self function_e958519b();
    } else if (self function_b21ea513()) {
        self.bot.var_9931c7dc = 0;
    } else if (isdefined(self.bot.var_941ba251) && self function_8174b063(self.bot.var_941ba251)) {
        self function_19ef91d7();
        self.bot.var_9931c7dc = 1;
    } else if (self haspath()) {
        self function_311aed8b();
        self.bot.var_9931c7dc = 0;
    } else if (isdefined(self.bot.traversal)) {
        self function_23401de9();
        self.bot.var_9931c7dc = 0;
    } else {
        self function_eb94f73e();
        self.bot.var_9931c7dc = 0;
    }
    profilestop();
}

// Namespace namespace_87549638/namespace_87549638
// Params 1, eflags: 0x4
// Checksum 0xfd39f891, Offset: 0x4d0
// Size: 0x74
function private function_8174b063(aimpoint) {
    pixbeginevent(#"");
    eye = self.origin + (0, 0, self getplayerviewheight());
    profilestop();
    return bullettracepassed(eye, aimpoint, 0, self, self.enemy, 1, 1, 1);
}

// Namespace namespace_87549638/namespace_87549638
// Params 1, eflags: 0x4
// Checksum 0x5e4a7845, Offset: 0x550
// Size: 0x72
function private function_37d408b6(traversal) {
    if (!isdefined(traversal)) {
        return false;
    }
    return traversal.type == #"ladder" || traversal.type == #"jump" || traversal.deltaz >= 50;
}

// Namespace namespace_87549638/namespace_87549638
// Params 2, eflags: 0x4
// Checksum 0x43b8af67, Offset: 0x5d0
// Size: 0xac
function private function_9b25bbe5(traversal, aimpoint) {
    if (!self function_37d408b6(traversal)) {
        return false;
    }
    eye = self.origin + (0, 0, self getplayerviewheight());
    dir = vectornormalize(eye - aimpoint);
    return vectordot(traversal.normal, dir) < 0.5;
}

// Namespace namespace_87549638/namespace_87549638
// Params 0, eflags: 0x4
// Checksum 0x97c630e4, Offset: 0x688
// Size: 0xa8
function private function_204b5b9c() {
    point = self.enemylastseenpos;
    if (distance2dsquared(self.origin, point) <= 9216) {
        return false;
    }
    normal = self.bot.var_a0b6205e;
    if (isdefined(normal)) {
        dir = self.origin - self.enemylastseenpos;
        return (vectordot(dir, normal) > 0);
    }
    return true;
}

// Namespace namespace_87549638/namespace_87549638
// Params 0, eflags: 0x4
// Checksum 0x11a86b66, Offset: 0x738
// Size: 0x210
function private function_b21ea513() {
    if (self.bot.var_e8c84f98 || self.ignoreall) {
        return false;
    }
    enemies = self getenemiesinradius(self.origin, 1000);
    var_8a75d6bc = undefined;
    var_6e4e5c17 = undefined;
    foreach (enemy in enemies) {
        if (is_true(enemy.ignoreme)) {
            continue;
        }
        var_f1e73cd = self lastknowntime(enemy);
        enemypos = self lastknownpos(enemy);
        if (!isdefined(var_f1e73cd) || !isdefined(enemypos) || var_f1e73cd + 3000 < gettime()) {
            continue;
        }
        if (!isdefined(var_6e4e5c17) || var_6e4e5c17 < var_f1e73cd) {
            var_6e4e5c17 = var_f1e73cd;
            var_8a75d6bc = enemypos;
        }
    }
    if (!isdefined(var_8a75d6bc)) {
        return false;
    }
    var_8a75d6bc += (0, 0, self getplayerviewheight());
    self function_b5460039(var_8a75d6bc, #"hash_4d7ab907ebdddd3c", (1, 0.5, 0));
    return true;
}

// Namespace namespace_87549638/namespace_87549638
// Params 0, eflags: 0x4
// Checksum 0xd7f2fb3e, Offset: 0x950
// Size: 0xaa
function private function_2f110827() {
    point = self.bot.var_87751145;
    if (self function_9b25bbe5(self.bot.traversal, point)) {
        self function_23401de9();
        return 0;
    }
    self function_b5460039(point, #"point", (0, 1, 1));
    return self function_8174b063(point);
}

// Namespace namespace_87549638/namespace_87549638
// Params 0, eflags: 0x4
// Checksum 0x67ed1e72, Offset: 0xa08
// Size: 0x88
function private function_e958519b() {
    point = self.enemylastseenpos;
    if (self function_9b25bbe5(self.bot.traversal, point)) {
        self function_23401de9();
        return false;
    }
    self function_b5460039(point, #"hash_517fc0a2cf80dbb8", (1, 0, 1));
    return true;
}

// Namespace namespace_87549638/namespace_87549638
// Params 0, eflags: 0x4
// Checksum 0x4ceec540, Offset: 0xa98
// Size: 0x94
function private function_19ef91d7() {
    point = self.bot.var_941ba251;
    if (self function_9b25bbe5(self.bot.traversal, point)) {
        self function_23401de9();
        return;
    }
    self function_b5460039(point, #"threat", (1, 0.5, 0));
}

// Namespace namespace_87549638/namespace_87549638
// Params 3, eflags: 0x4
// Checksum 0x799c539b, Offset: 0xb38
// Size: 0x240
function private aim_at_entity(ent, dist, tag) {
    if (self function_9b25bbe5(self.bot.traversal, ent.origin)) {
        self function_23401de9();
        return false;
    }
    if (isdefined(self.scriptenemy) && self.scriptenemy == ent) {
        tag = self.scriptenemytag;
    } else if (isdefined(ent.shootattag)) {
        tag = ent.shootattag;
    }
    if (isdefined(tag)) {
        tagorigin = ent gettagorigin(tag);
        if (isdefined(tagorigin)) {
            self function_b5460039(tagorigin, tag, (1, 0, 1));
            return true;
        }
    } else if (isvehicle(ent) && target_istarget(ent)) {
        tagorigin = target_getorigin(ent);
        self function_b5460039(tagorigin, #"hash_7b9926f357c45aa8", (1, 0, 1));
        return true;
    } else {
        point = self function_466e841e(ent, dist);
        if (isdefined(point)) {
            self function_b5460039(point, #"entity", (1, 0, 1));
            return true;
        }
    }
    centroid = ent getcentroid();
    self function_b5460039(centroid, #"centroid", (1, 0, 1));
    return true;
}

// Namespace namespace_87549638/namespace_87549638
// Params 2, eflags: 0x4
// Checksum 0x76e023cc, Offset: 0xd80
// Size: 0xe4
function private function_466e841e(ent, dist) {
    pixbeginevent(#"");
    defaultorigin = ent gettagorigin("j_spineupper");
    if (!isdefined(defaultorigin)) {
        profilestop();
        return undefined;
    }
    if (dist >= 250) {
        profilestop();
        return defaultorigin;
    }
    var_d7b829fb = ent gettagorigin("j_neck");
    if (!isdefined(var_d7b829fb)) {
        profilestop();
        return defaultorigin;
    }
    t = max(dist / 250, 0.25);
    profilestop();
    return vectorlerp(var_d7b829fb, defaultorigin, t);
}

// Namespace namespace_87549638/namespace_87549638
// Params 0, eflags: 0x4
// Checksum 0xf3318f19, Offset: 0xe70
// Size: 0xf4
function private function_311aed8b() {
    var_8be65bb9 = self function_f04bd922();
    if (isdefined(var_8be65bb9)) {
        if (self function_35170b35(var_8be65bb9.var_b8c123c0, 128, #"hash_c5ef7c07caa7856", (0, 1, 1))) {
            return;
        }
        if (self function_35170b35(var_8be65bb9.var_bef48941, 64, #"hash_77da0a5a26fe7baf", (0, 0, 1))) {
            return;
        }
        if (self function_35170b35(var_8be65bb9.var_2cfdc66d, 32, #"hash_4c52ca575ab8182b", (1, 0, 1))) {
            return;
        }
    }
    self function_eb94f73e();
}

// Namespace namespace_87549638/namespace_87549638
// Params 4, eflags: 0x4
// Checksum 0xe70ed9b0, Offset: 0xf70
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
// Params 0, eflags: 0x4
// Checksum 0xc4a4b050, Offset: 0x1020
// Size: 0xfc
function private function_eb94f73e() {
    movedir = self bot::move_dir();
    if (lengthsquared(movedir) > 0.0001) {
        eye = self.origin + (0, 0, self getplayerviewheight());
        var_d9100e0 = eye + vectornormalize(movedir) * 128;
        self function_b5460039(var_d9100e0, #"forward", (0, 1, 1));
        return;
    }
    self botsetlookangles(self.angles);
}

// Namespace namespace_87549638/namespace_87549638
// Params 0, eflags: 0x4
// Checksum 0x976d789b, Offset: 0x1128
// Size: 0xfc
function private function_23401de9() {
    traversal = self.bot.traversal;
    enddist = vectordot(self.origin - traversal.var_15dca465, traversal.normal);
    if (enddist > 15) {
        endpoint = traversal.end_position + (0, 0, self getplayerviewheight());
        self function_b5460039(endpoint, #"hash_7d35f3d861b9ec10", (1, 1, 0));
        return;
    }
    dir = (0, 0, 0) - traversal.normal;
    self botsetlookdir(dir);
}

// Namespace namespace_87549638/namespace_87549638
// Params 3, eflags: 0x4
// Checksum 0x25c9f99d, Offset: 0x1230
// Size: 0x2c4
function private function_b5460039(point, var_e125ba43, debugcolor) {
    var_a3375299 = undefined;
    if (isdefined(self.bot.var_32d8dabe)) {
        var_a3375299 = point;
        point += rotatepoint(self.bot.var_32d8dabe, self.angles + (0, 180, 0));
    }
    /#
        if (self bot::should_record("<dev string:x38>")) {
            function_af72dbc5(point, (-1.5, -1.5, -1.5), (1.5, 1.5, 1.5), self.angles[1], debugcolor, "<dev string:x49>", self);
            record3dtext(function_9e72a96(var_e125ba43), point + (0, 0, -0.75), (1, 1, 1), "<dev string:x49>", self, 0.5);
            if (isdefined(var_a3375299)) {
                function_af72dbc5(var_a3375299, (-1.5, -1.5, -1.5), (1.5, 1.5, 1.5), self.angles[1], (0.75, 0.75, 0.75), "<dev string:x49>", self);
                recordline(var_a3375299, point, (0.75, 0.75, 0.75), "<dev string:x49>", self);
                if (isdefined(self.bot.var_9e5aaf8d)) {
                    record3dtext(self.bot.var_9e5aaf8d + "<dev string:x53>", var_a3375299, (1, 1, 0), "<dev string:x49>", self, 0.5);
                }
            }
        }
    #/
    if (isdefined(self.bot.var_f50fa466)) {
        var_deb75a87 = self botgetprojectileaimangles(self.bot.var_f50fa466, point);
        if (isdefined(var_deb75a87)) {
            self botsetlookangles(var_deb75a87.var_478aeacd);
        } else {
            self botsetlookcurrent();
        }
        return;
    }
    self botsetlookpoint(point);
}

